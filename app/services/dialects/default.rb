module Dialects
  module Default
    def initialize(text)
      @text = text
    end

    def translate
      raise NotImplementedError
    end

    private

    attr_reader :text
  end
end
