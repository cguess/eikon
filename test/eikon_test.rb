# typed: true
require "test_helper"
require "byebug"

class EikonTest < Minitest::Test
  def test_that_it_has_a_version_number
    assert_not_nil ::Eikon::VERSION
  end

  def test_one_shot_image_loader
    assert Eikon.dhash_for_image("./test/images/00001.jpg").nil? == false
  end

  def test_one_shot_video_loader
    ensure_video_assets_exist
    assert Eikon.dhash_for_video("./test/videos/pexels-ron-lach-7121125.mp4").nil? == false
  end

  def test_one_shot_video_loader_with_set_number_of_frames
    ensure_video_assets_exist
    assert Eikon.dhash_for_video("./test/videos/pexels-ron-lach-7121125.mp4", 4).nil? == false
  end

  def test_different_images_should_produce_different_hashes
    dhash_1 = Eikon.dhash_for_image("./test/images/00001.jpg")
    dhash_2 = Eikon.dhash_for_image("./test/images/00003.jpg")
    assert dhash_1 != dhash_2
  end

  def test_hamming_distance_comparator
    distance = Eikon.distance_between_files("./test/images/00001.jpg", "./test/images/00002.jpg")
    assert distance != 0
  end

  def test_bucks_image
    assert Eikon.dhash_for_image("./test/images/buckstest.jpeg").nil? == false
  end
end
