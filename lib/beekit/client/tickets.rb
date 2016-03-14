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

    def create_ticket(content, user_data = {
      subject: "No Subject",
      requester_name: nil,
      requester_email: nil,
      cc: []
    })
      post_data = {
        "ticket": {
          "subject": user_data[:subject],
          "requester_name": user_data[:requester_name],
          "requester_email": user_data[:requester_email],
          "cc": user_data[:cc],
          "content":{
            "text": content,
            "html": content
          }
        }
      }

      ticket = HTTParty.post("#{base_uri}/tickets?auth_token=#{api_token}", { body: post_data.to_json, headers: headers } )
      JSON.parse(ticket.response.body)["ticket"]
    end

    def ticket(ticket_id)
      ticket = HTTParty.get("#{base_uri}/tickets/#{ticket_id}", query: { auth_token: api_token },  headers: headers)
      JSON.parse(ticket.response.body)["ticket"]
    end
  end
end