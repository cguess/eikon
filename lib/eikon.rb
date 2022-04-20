# typed: strict
require "eikon/version"
require "eikon/comparator"
require "eikon/video_processor"
require "eikon/image_processor"
require "vips"
require "ruby_jard"
require "sorbet-runtime"

module Eikon
  extend T::Sig

  class Error < StandardError; end

  sig { params(filename: T.untyped).returns(String) }
  def self.dhash_for_file(filename)
    image = Eikon::ImageProcessor.new(filename)
    image.preprocess_image
    image.generate_byte_array
    image.byte_array
  end

  sig { params(filename_1: String, filename_2: String).returns(Integer) }
  def self.distance_between_files(filename_1, filename_2)
    Eikon::Comparator.compare(dhash_for_file(filename_1), dhash_for_file(filename_2))
  end

  sig { params(filename: String).returns(NilClass) }
  def self.process_video(filename)
    # video_processor = Eikon::VideoProcessor.new(filename)
  end
end
