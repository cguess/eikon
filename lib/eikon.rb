# typed: strict
require "eikon/version"
require "eikon/comparator"
require "eikon/video_processor"
require "eikon/image_processor"
require "vips"
require "sorbet-runtime"

module Eikon
  extend T::Sig

  class Error < StandardError; end

  sig { params(filename: T.untyped).returns(String) }
  def self.dhash_for_image(filename)
    image = Eikon::ImageProcessor.new(filename)
    image.preprocess_image
    image.generate_byte_array
    image.byte_array
  end

  sig { params(filename: String, number_of_frames: Integer).returns(T::Array[T::Hash[String, T.any(Integer, String)]]) }
  def self.dhash_for_video(filename, number_of_frames = 0)
    video_processor = Eikon::VideoProcessor.new(filename)
    storage_path = video_processor.split_video_into_images(number_of_frames)
    dhashes = video_processor.get_frames_dhash(storage_path)
    dhashes
  end

  sig { params(filename_1: String, filename_2: String).returns(Integer) }
  def self.distance_between_files(filename_1, filename_2)
    Eikon::Comparator.compare(dhash_for_image(filename_1), dhash_for_image(filename_2))
  end
end
