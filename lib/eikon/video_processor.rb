module Eikon
  class VideoProcessor
    attr_reader :filename

    def initializer(filename)
      @@filename = filename
    end
  end
end
