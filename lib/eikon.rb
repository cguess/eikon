require "eikon/version"
require "vips"

module Eikon
  class Error < StandardError; end

  def dhash_for_file(filename)
    image = Eikon::Processor.new
    image.load_image("./test/images/00001.jpg")
    image.preprocess_image
    image.generate_byte_array
    image.byte_array
  end

  class Processor
    @image = nil
    @byte_array = nil

    attr_reader :byte_array

    def load_image(filename)
      @image = Vips::Image.new_from_file(filename)
    end

    def preprocess_image
      # Black and white
      @image = @image.colourspace "b-w"
      # For some reason thumbnail is only created via a buffer, so we save one quick
      image_buffer = @image.write_to_buffer ".tiff"
      # shrink image
      @image = Vips::Image.thumbnail_buffer(image_buffer, 9, height: 8, size: :force)
    end

    def generate_byte_array
      @byte_array = ""
      for y in  0..7 do
        for x in 0..7 do
          @byte_array += @image.getpoint(x,y)[0] < @image.getpoint((x+1), y)[0] ? "1" : "0"
        end
      end
    end
  end
end
