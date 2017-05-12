# frozen_string_literal: true

require 'net/http'

module Dialects
  class Yoda
    include Default
    SUCCESS_CODE = 200

    def translate
      response = request_api
      if response.code.to_i == SUCCESS_CODE
        parse_response(response)
      else
        # We could have some fallback to handle when api is down
        log_error(response)
        text
      end
    end

    private

    def request_api
      Net::HTTP.get_response(URI(enc_uri))
    end

    def enc_uri
      URI.escape("#{base_uri}/translate/yoda.json?text=#{text}")
    end

    def parse_response(response)
      JSON.parse(response.body).fetch('contents').fetch('translated')
    end

    def log_error(response)
      error_message = JSON.parse(response.body).fetch('error').fetch('message')
      Rails.logger.error "Failed request to dialects api - response #{error_message}"
    end

    def base_uri
      Settings.dialects.yoda
    end
  end
end
