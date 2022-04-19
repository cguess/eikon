# typed: strict
require "sorbet-runtime"
require "terrapin"

module Eikon
  class VideoProcessor
    extend T::Sig

    sig { returns(String) }
    attr_reader :filename

    sig { params(filename: String).void }
    def initialize(filename)
      @filename = T.let(filename, String)
    end

    sig { returns(String) }
    def split_video_into_images
      filename = get_file_name(@filename)

      setup_tmp_folder

      output_folder_path = "tmp/videos/#{filename}_#{Time.now.utc.strftime("%Y%m%d%H%M%S")}"
      begin
        make_dir_command = Terrapin::CommandLine.new("mkdir", ":foldername")
        make_dir_command.run(foldername: output_folder_path)
      rescue Terrapin::ExitStatusError
        raise "Folder already exists for this export"
      end

      # ffmpeg -i pexels-ron-lach-7121125.mp4 -vf fps=10/60 out%d.png
      line = Terrapin::CommandLine.new("ffmpeg", "-i :filename -vf fps=10/60 :foldername")
      line.run(filename: @filename, foldername: "#{output_folder_path}/#{filename}_%d.png")
      output_folder_path
    end

  private

    sig { params(filename: String).returns(String) }
    def get_file_name(filename)
      filename_parts = filename.split(".")
      filename_parts.select! { |e| !e.empty? }
      filename = filename_parts.first
      T.must(T.must(filename).split("/").last)
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
