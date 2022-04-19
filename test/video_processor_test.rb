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
end
