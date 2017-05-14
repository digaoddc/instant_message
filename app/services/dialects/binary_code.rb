module Dialects
  class BinaryCode
    include Default

    def translate
      text.unpack("B40")
    end
  end
end
