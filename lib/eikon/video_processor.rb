# typed: strict

require "sorbet-runtime"
require "terrapin"

module Eikon
  class VideoProcessor
    extend T::Sig

    sig { returns(String) }
    attr_reader :file_name

    sig { params(file_name: String).void }
    def initialize(file_name)
      @file_name = T.let(file_name, String)
    end

    # Note, this isn't guranteed to give the number of frames since we remove blank images
    sig { params(number_of_frames: Integer).returns(String) }
    def split_video_into_images(number_of_frames = 0)
      file_name = get_file_name(@file_name)

      setup_tmp_folder

      output_folder_path = "tmp/videos/#{file_name}_#{Time.now.utc.strftime("%Y%m%d%H%M%S")}"
      begin
        make_dir_command = Terrapin::CommandLine.new("mkdir", ":folder_name")
        make_dir_command.run(folder_name: output_folder_path)
      rescue Terrapin::ExitStatusError
        raise "Folder already exists for this export"
      end

      # Get length of video
      line = Terrapin::CommandLine.new("ffmpeg", "-i :file_name 2>&1 | grep Duration | cut -d ' ' -f 4 | sed s/,//")
      time = line.run(file_name: @file_name).chomp

      # Turn the time into total seconds (with two points of precision)
      time_parts =  time.split(":")
      total_time =  time_parts[0].to_i * 60 * 60 # Hours
      total_time += time_parts[1].to_i * 60 # Minutes
      total_time += time_parts[2].to_f # Seconds

      # Figure out the number of frames per minute given the number of frames we want, default to every ten seconds out of sixty
      if number_of_frames > 2
        # number_of_frames = number_of_frames - 2
        # number_of_frames = 0 if number_of_frames.negative?

        # NOTE: This has to be a fraction, not a whole number, but also, never 0
        fps = (number_of_frames - 2) / total_time # We subtract two because we're taking the start and end
        line = Terrapin::CommandLine.new("ffmpeg", "-i :file_name -vf fps=#{fps} :folder_name")
        line.run(file_name: @file_name, folder_name: "#{output_folder_path}/#{file_name}_%05d.png")
      else
        line = Terrapin::CommandLine.new("ffmpeg", "-i :file_name -filter:v \"select='gt(scene,0.4)',showinfo\" -vsync 0 :output_directory/:output_file_name")
        line.run(file_name: @file_name, output_directory: output_folder_path, output_file_name: "#{file_name}_%05d.png")
      end

      # Screenshot the second second and second to last second
      # ffmpeg -ss 01:23:45 -i input -frames:v 1 -q:v 2 output.jpg
      last_time = "#{time_parts[0]}:#{time_parts[1]}:#{(time_parts[2].to_f - 1).abs.floor}"
      ffmpeg_command = "-ss 00:00:02 -i :file_name " +
                       "-ss :last_time -i :file_name " +
                       "-map 0:v -vframes 1 :output_directory/:output_file_name_start " +
                       "-map 1:v -vframes 1 :output_directory/:output_file_name_end"
      line = Terrapin::CommandLine.new("ffmpeg", ffmpeg_command)
      line.run(
        file_name: @file_name,
        last_time: last_time,
        output_directory: output_folder_path,
        output_file_name_start: "#{file_name}_%05d.png",
        output_file_name_end: "#{file_name}_%05d.png"
      )
      remove_blank_shots(output_folder_path)

      output_folder_path
    end

    sig { params(folder_path: String).returns(T::Array[T::Hash[String, T.any(Integer, String)]]) }
    def get_frames_dhash(folder_path)
      # Filter the '.' and '..' directories from the current directory's file list
      file_names = Dir.entries(folder_path).filter { |entry| entry.start_with?(".") == false }

      dhashes = file_names.map do |file_name|
        dhash = Eikon.dhash_for_image("#{folder_path}/#{file_name}")
        { file_name: file_name, dhash: dhash }
      end
      dhashes
    end

  private

    sig { params(file_name: String).returns(String) }
    def get_file_name(file_name)
      file_name_parts = file_name.split(".")
      file_name_parts.select! { |e| !e.empty? }
      file_name = file_name_parts.first
      T.must(T.must(file_name).split("/").last)
    end

    sig { void }
    def setup_tmp_folder
      begin
        make_dir_command = Terrapin::CommandLine.new("mkdir", "tmp/")
        make_dir_command.run
      rescue Terrapin::ExitStatusError; end

      begin
        make_dir_command = Terrapin::CommandLine.new("mkdir", "tmp/videos")
        make_dir_command.run
      rescue Terrapin::ExitStatusError; end
    end

    sig { params(folder_path: String).void }
    def remove_blank_shots(folder_path)
      # Scan through the directory getting all images (naïvely)
      # Find the average size of the files, then choose files that are less than 20% of the average size
      # This means they're probably mostly one color, so we delete them

      # Filter the '.' and '..' directories from the current directory's file list
      file_names = Dir.entries(folder_path).filter do |entry|
        !entry.start_with?(".") ||
          entry.downcase.end_with?(".png") ||
          entry.downcase.end_with?(".jpg") ||
          entry.downcase.end_with?(".jpeg")
      end

      # Somehow there's an emnpty list of files,
      # This is going to exclusively be a bug in a different part of the code
      # that is using this library, so we'll just make sure we don't break
      if file_names.empty?
        puts "No files found in the directory. This is likely a bug in the code that called this library."
        return
      end

      # Get the average size of the files
      total_size = file_names.reduce(0) do |sum, file_name|
        sum + File.size("#{folder_path}/#{file_name}")
      end

      average_size = total_size / file_names.count

      # Delete files that are less than 20% of the average size
      file_names.each do |file_name|
        file_path = "#{folder_path}/#{file_name}"
        file_size = File.size(file_path)

        File.delete(file_path) if file_size < (average_size * 0.2)
      end
    end
  end
end
