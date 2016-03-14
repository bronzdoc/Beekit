require "beekit/client/tickets"

module Beekit
  class Client
    include Beekit::Tickets

    attr_accessor :company, :api_token, :base_uri, :headers

    def initialize(company, api_token)
      @api_token = api_token
      @company   = company
      @base_uri  = "https://#{@company}.supportbee.com"
      @headers   = {"Content-type" => "application/json", "Accept" => "application/json"}
    end
  end
end
