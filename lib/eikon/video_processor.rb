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

    sig { returns(String) }
    def split_video_into_images
      file_name = get_file_name(@file_name)

      setup_tmp_folder

      output_folder_path = "tmp/videos/#{file_name}_#{Time.now.utc.strftime("%Y%m%d%H%M%S")}"
      begin
        make_dir_command = Terrapin::CommandLine.new("mkdir", ":folder_name")
        make_dir_command.run(folder_name: output_folder_path)
      rescue Terrapin::ExitStatusError
        raise "Folder already exists for this export"
      end

      # ffmpeg -i pexels-ron-lach-7121125.mp4 -vf fps=10/60 out%d.png
      line = Terrapin::CommandLine.new("ffmpeg", "-i :file_name -vf fps=10/60 :folder_name")
      line.run(file_name: @file_name, folder_name: "#{output_folder_path}/#{file_name}_%d.png")
      output_folder_path
    end

    def get_frames_dhash(folder_path)
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
