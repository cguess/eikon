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

      # Figure out the number of frames per minute given the number of frames we want, default to every ten seconds out of sixty
      fps = 0.166 # 10/60
      unless number_of_frames.zero?
        # Get length of video
        line = Terrapin::CommandLine.new("ffmpeg", "-i :file_name 2>&1 | grep Duration | cut -d ' ' -f 4 | sed s/,//")
        time = line.run(file_name: @file_name).chomp

        # Turn the time into total seconds (with two points of precision)
        time_parts =  time.split(":")
        total_time =  Integer(time_parts[0]) * 60 * 60 # Hours
        total_time += Integer(time_parts[1]) * 60 # Minutes
        total_time += Float(time_parts[2]) # Seconds

        fps = number_of_frames / total_time
      end

      # ffmpeg -i pexels-ron-lach-7121125.mp4 -vf fps=10/60 out%d.png
      line = Terrapin::CommandLine.new("ffmpeg", "-i :file_name -vf fps=#{fps} :folder_name")
      line.run(file_name: @file_name, folder_name: "#{output_folder_path}/#{file_name}_%d.png")
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
  end
end
