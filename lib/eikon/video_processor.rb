# typed: strict
module Eikon
  class VideoProcessor
    extend T::Sig

    sig { returns(String) }
    attr_reader :filename

    sig { params(filename: String).void }
    def initialize(filename)
      @filename = T.let(filename, String)
    end
  end
end
