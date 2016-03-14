module Beekit
  class Client
    attr_accessor :company, :api_token

    def initialize(company, api_token)
      @api_token = api_token
    end
  end
end
