require "httparty"

module Beekit
  module Tickets
    def tickets(options = {})
      options["auth_token"] = api_token

      tickets = HTTParty.get("#{base_uri}/tickets", query: options,  headers: headers)
      JSON.parse(tickets.response.body)["tickets"]
    end
  end
end
