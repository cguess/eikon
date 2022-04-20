# typed: true
require "test_helper"
require "byebug"

class ImageProcessorTest < Minitest::Test
  def setup
    @image = Eikon::ImageProcessor.new("./test/images/00001.jpg")
  end

  def test_image_can_be_loaded
    assert @image.nil? == false
  end

  def test_image_can_be_processed_into_byte_array
    @image.generate_byte_array
    assert @image.byte_array.nil? == false
  end
end
