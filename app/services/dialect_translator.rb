# frozen_string_literal: true

class DialectTranslator
  def self.perform(text, dialect)
    klass = Object.const_get "Dialects::#{dialect.classify}"
    klass.new(text).translate
  rescue NameError
    text
  end
end
