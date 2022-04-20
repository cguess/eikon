# typed: strict
require "sorbet-runtime"

module Eikon
  class ImageProcessor
    # This is an implementation of the algorithm described at http://hackerfactor.com/blog/index.php?/archives/529-Kind-of-Like-That.html

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
end
