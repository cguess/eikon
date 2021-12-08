require "test_helper"

class EikonTest < Minitest::Test
  def setup
    @image = Eikon::Processor.new
    @image.load_image("./test/images/00001.jpg")
  end

  def test_that_it_has_a_version_number
    refute_nil ::Eikon::VERSION
  end

  def test_image_can_be_loaded
    assert @image.nil? == false
  end

  def test_image_can_preprocess_image
    @image.preprocess_image # will fail if something goes south
  end

  def test_image_can_be_processed_into_byte_array
    @image.preprocess_image
    @image.generate_byte_array
    assert @image.byte_array.nil? == false
  end

  def test_one_shot_image_loader
    assert Eikon.dhash_for_file("./test/images/00001.jpg").nil? == false
  end
end
