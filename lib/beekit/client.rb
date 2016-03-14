module Beekit
  class Client
    attr_accessor :company, :api_token

    def initialize(company, api_token)
      @api_token = api_token
      @company = company
    end
  end
end
