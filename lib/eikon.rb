# typed: strict
require "eikon/version"
require "eikon/video_processor"
require "vips"
require "ruby_jard"
require "sorbet-runtime"

module Eikon
  extend T::Sig

  class Error < StandardError; end

  sig { params(filename: T.untyped).returns(String) }
  def self.dhash_for_file(filename)
    image = Eikon::Processor.new(filename)
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

  class Processor
    extend T::Sig

    sig { returns(String) }
    attr_reader :byte_array

    sig { returns(String) }
    attr_reader :filename

    sig { params(filename: String).void }
    def initialize(filename)
      @filename = filename
      @image = T.let(Vips::Image.new_from_file(filename), Vips::Image)
      @byte_array = T.let("", String)
    end

    sig { returns(NilClass) }
    def preprocess_image
      # Black and white
      @image = T.unsafe(@image).colourspace "b-w"
      # For some reason thumbnail is only created via a buffer, so we save one quick
      image_buffer = @image.write_to_buffer ".tiff"
      # shrink image
      @image = T.unsafe(Vips::Image).thumbnail_buffer(image_buffer, 9, height: 8, size: :force)
      image_buffer = @image.write_to_buffer ".tiff"
      @image = Vips::Image.new_from_buffer(image_buffer, "")

      nil
    end

    sig { returns(NilClass) }
    def generate_byte_array
      for y in  0..7 do
        for x in 0..7 do
          @byte_array += T.unsafe(@image).getpoint(x, y)[0] < T.unsafe(@image).getpoint((x + 1), y)[0] ? "1" : "0"
        end
      end

      nil
    end
  end

  class Comparator
    extend T::Sig
    sig { params(dhash_1: String, dhash_2: String).returns(Integer) }
    def self.compare(dhash_1, dhash_2)
      hamming_distance = 0
      dhash_1.chars.each_with_index do |character, index|
        hamming_distance += 1 if character != dhash_2.chars[index]
      end

      hamming_distance
    end
  end
end
