require "httparty"

module Beekit
  module Tickets
    def tickets(options = {})
      options["auth_token"] = api_token

      tickets = HTTParty.get("#{base_uri}/tickets", query: options,  headers: headers)
      JSON.parse(tickets.response.body)["tickets"]
    end

    def search_tickets(query, options = {})
      options["auth_token"] = api_token
      options["query"] = query

      search = HTTParty.get("#{base_uri}/tickets/search", query: options,  headers: headers)
      JSON.parse(search.response.body)["tickets"]
    end
  end
end
