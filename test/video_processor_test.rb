# typed: true

require "test_helper"
require "byebug"
require "sorbet-runtime"
require "fileutils"
require "terrapin"
require "date"

class VideoProcessorTest < Minitest::Test
  def setup
    ensure_video_assets_exist
    @video = Eikon::VideoProcessor.new("test/videos/WATCH Biden attends a Hispanic Heritage Month event in Kissimmee Florida.mp4")
  end

  def teardown
    # We want to clear out the tmp/videos folder after testing
    FileUtils.rm_rf("tmp/videos")
  end

  def test_video_can_be_loaded
    assert_not_nil @video
  end

  def test_video_can_be_split
    output_path = @video.split_video_into_images

    assert_not_nil output_path
    assert Dir.entries(output_path).count > 2
  end

  def test_video_can_be_split_by_number_of_frames
    output_path = @video.split_video_into_images(10)

    assert_not_nil output_path
    assert Dir.entries(output_path).count == 10
  end

  def test_empty_images_are_deleted
    output_path = @video.split_video_into_images
    Dir.entries(output_path).count == 7
  end

  def test_dhash_can_be_generated_for_video_frames
    output_path = @video.split_video_into_images
    dhashes = @video.get_frames_dhash(output_path)

    assert_not_nil dhashes
    assert dhashes.count == (Dir.entries(output_path).drop(2).count)
  end

  def test_dhash_can_be_generated_for_specified_number_of_video_frames
    output_path = @video.split_video_into_images(4)
    dhashes = @video.get_frames_dhash(output_path)

    assert_not_nil dhashes
    assert dhashes.count == 4
  end

  def test_odd_framed_video
    @video = Eikon::VideoProcessor.new("test/videos/american-airlines.mp4")
    output_path = @video.split_video_into_images
    dhashes = @video.get_frames_dhash(output_path)
    assert_not_nil dhashes
  end
end
