require "httparty"

module Beekit
  module Tickets

    def tickets(options = {})
      options["auth_token"] = api_token

      tickets = HTTParty.get("#{base_uri}/tickets", query: options,  headers: headers)
      JSON.parse(tickets.response.body)
    end

    def search_tickets(query, options = {})
      options["auth_token"] = api_token
      options["query"] = query

      search = HTTParty.get("#{base_uri}/tickets/search", query: options,  headers: headers)
      JSON.parse(search.response.body)
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
      JSON.parse(ticket.response.body)
    end

    def ticket(ticket_id)
      ticket = HTTParty.get("#{base_uri}/tickets/#{ticket_id}", query: { auth_token: api_token },  headers: headers)
      JSON.parse(ticket.response.body)
    end

    def delete_trashed_ticket!(ticket_id)
      ticket = HTTParty.delete("#{base_uri}/tickets/#{ticket_id}?auth_token=#{api_token}", { headers: headers } )
      { "code" => ticket.response.code, "message" => ticket.response.msg }
    end

    def archive_ticket(ticket_id)
      ticket = HTTParty.post("#{base_uri}/tickets/#{ticket_id}/archive?auth_token=#{api_token}", { headers: headers } )
      { "code" => ticket.response.code, "message" => ticket.response.msg }
    end

    def unarchive_ticket(ticket_id)
      ticket = HTTParty.delete("#{base_uri}/tickets/#{ticket_id}/archive?auth_token=#{api_token}", { headers: headers } )
      { "code" => ticket.response.code, "message" => ticket.response.msg }
    end

    def assign_ticket(ticket_id, user_data = { user_id: nil, group_id: nil })
      post_data = {
        "assignment": {
          "user_id": user_data[:user_id],
          "group_id": user_data[:group_id]
        }
      }

      ticket = HTTParty.post("#{base_uri}/tickets/#{ticket_id}/assignments?auth_token=#{api_token}", { body: post_data.to_json, headers: headers } )
      JSON.parse(ticket.response.body)["assignment"]
    end

    def star_ticket(ticket_id)
      ticket = HTTParty.post("#{base_uri}/tickets/#{ticket_id}/star?auth_token=#{api_token}", { headers: headers } )
      { "code" => ticket.response.code, "message" => ticket.response.msg }
    end

    def unstar_ticket(ticket_id)
      ticket = HTTParty.delete("#{base_uri}/tickets/#{ticket_id}/star?auth_token=#{api_token}", { headers: headers } )
      { "code" => ticket.response.code, "message" => ticket.response.msg }
    end

    def spam_ticket(ticket_id)
      ticket = HTTParty.post("#{base_uri}/tickets/#{ticket_id}/spam?auth_token=#{api_token}", { headers: headers } )
      { "code" => ticket.response.code, "message" => ticket.response.msg }
    end

    def unspam_ticket(ticket_id)
      ticket = HTTParty.delete("#{base_uri}/tickets/#{ticket_id}/spam?auth_token=#{api_token}", { headers: headers } )
      { "code" => ticket.response.code, "message" => ticket.response.msg }
    end

    def trash_ticket(ticket_id)
      ticket = HTTParty.post("#{base_uri}/tickets/#{ticket_id}/trash?auth_token=#{api_token}", { headers: headers } )
      { "code" => ticket.response.code, "message" => ticket.response.msg }
    end

    def untrash_ticket(ticket_id)
      ticket = HTTParty.delete("#{base_uri}/tickets/#{ticket_id}/trash?auth_token=#{api_token}", { headers: headers } )
      { "code" => ticket.response.code, "message" => ticket.response.msg }
    end

    def ticket_replies(ticket_id)
      ticket = HTTParty.get("#{base_uri}/tickets/#{ticket_id}/replies", query: { auth_token: api_token },  headers: headers)
      JSON.parse(ticket.response.body)
    end

    def create_ticket_reply(ticket_id, content = {html: nil, text: nil}, attachment_ids = [])
      post_data = {
        "reply":{
          "content":{
            "html": content[:html],
            "text": content[:text]
          },
          "attachment_ids": attachment_ids
        }
      }

      ticket = HTTParty.post("#{base_uri}/tickets/#{ticket_id}/replies?auth_token=#{api_token}", { body: post_data.to_json, headers: headers } )
      JSON.parse(ticket.response.body)
    end

    def ticket_comments(ticket_id)
      ticket = HTTParty.get("#{base_uri}/tickets/#{ticket_id}/comments", query: { auth_token: api_token },  headers: headers)
      JSON.parse(ticket.response.body)
    end

    def create_ticket_comment(ticket_id, content = {html: "blank", text: "blank"}, attachment_ids = [])
      post_data = {
        "comment":{
          "content":{
            "html": content[:html],
            "text": content[:text]
          },
          "attachment_ids": attachment_ids
        }
      }

      ticket = HTTParty.post("#{base_uri}/tickets/#{ticket_id}/comments?auth_token=#{api_token}", { body: post_data.to_json, headers: headers } )
      JSON.parse(ticket.response.body)
    end
  end
end
