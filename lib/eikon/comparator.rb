# typed: strict

require "sorbet-runtime"

module Eikon
  class Comparator
    extend T::Sig
    sig { params(dhash_1: String, dhash_2: String).returns(Integer) }
    def self.compare(dhash_1, dhash_2)
      hamming_distance = 0
      dhash_1.chars.each_with_index do |character, index|
        hamming_distance += 1 if character != dhash_2[index]
      end

      hamming_distance + (dhash_1.length - dhash_2.length).abs
    end
  end
end
