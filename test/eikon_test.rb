# typed: true
require "test_helper"
require "byebug"

class EikonTest < Minitest::Test
  def setup
    @image = Eikon::Processor.new("./test/images/00001.jpg")
  end

  def test_that_it_has_a_version_number
    assert_not_nil ::Eikon::VERSION
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

  def test_different_images_should_produce_different_hashes
    dhash_1 = Eikon.dhash_for_file("./test/images/00001.jpg")
    dhash_2 = Eikon.dhash_for_file("./test/images/00003.jpg")
    assert dhash_1 != dhash_2
  end

  def test_hamming_distance_comparator
    distance = Eikon.distance_between_files("./test/images/00001.jpg", "./test/images/00002.jpg")
    assert distance != 0
  end

  # def test_bucks_image
  #   assert Eikon.dhash_for_file("./test/images/buckstest.jpeg").nil? == false
  # end
end
