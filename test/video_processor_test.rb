# typed: true
require "test_helper"
require "byebug"
require "sorbet-runtime"
require "fileutils"

class VideoProcessorTest < Minitest::Test
  def setup
    @video = Eikon::VideoProcessor.new("test/videos/pexels-ron-lach-7121125.mp4")
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

  def test_dhash_can_be_generated_for_video_frames
    output_path = @video.split_video_into_images
    dhashes = @video.get_frames_dhash(output_path)

    assert_not_nil dhashes
    assert dhashes.count == (Dir.entries(output_path).drop(2).count)
  end
end
