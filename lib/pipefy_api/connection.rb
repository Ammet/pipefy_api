module PipefyAPI
  class Connection
    include API

    PIPEFY_URL = 'https://app.pipefy.com/'.freeze
    DEFAULT_CONTENT_TYPE = 'application/json'.freeze

    attr_accessor :email, :api_key

    def initialize(email, api_key)
      @email = email
      @api_key = api_key
    end

    private

    def connection
      Faraday.new(url: PIPEFY_URL, headers: headers)
    end

    def headers
      {
        'Accept' => DEFAULT_CONTENT_TYPE,
        'X-User-Email' => email,
        'X-User-Token' => api_key
      }
    end
  end
end
