require "beekit/client/tickets"

module Beekit
  class Client
    include Beekit::Tickets

    attr_accessor :company, :api_token

    def initialize(company, api_token)
      @api_token = api_token
      @company = company
    end
  end
end
