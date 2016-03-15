# Beekit
API wrapper for SupportBee

## Installation(this is a demo gem)

```
$ git clone https://github.com/bronzdoc/Beekit.git
$ cd Beekit
$ gem build beekit.gemspec
$ gem install beekit.gem
```

## Usage

```ruby
client = Beekit::Client.new("company", "API_TOKEN")

```

# Fetching tickets

```ruby

# Retrieve the default set of tickets
client.tickets

# Or pass an options hash, visit for the complete list of options (https://developers.supportbee.com/api#fetching_tickets)
client.tickets({label: "important", per_page: 10})

# Get a single ticket
client.ticket(ticket_id)
```

# Creating tickets

```ruby
# Create a ticket
client.create_ticket("ticket content", {
    subject: "Subject",
    requester_name: "Charles xavier",
    requester_email: "charles@gmail.com",
    cc: ["hank_maccoy@gmail.com"],
})

```

# Deleting tickets

```ruby
client.delete_trashed_ticket!(ticket_id)
```

# Actions on Tickets

```ruby
# Archives an unarchived ticket
client.archive_ticket(ticket_id)

# Un-archives an archived ticket
client.unarchive_ticket(ticket_id)

# Assign a ticket to a User/Group
client.assign_ticket(ticket_id, user_id: 1)
client.assign_ticket(ticket_id, group_id: 1)

# Star a ticket
client.star_ticket(ticket_id)

# Mark a ticket as spam
client.spam_ticket(ticket_id)

# Remove spam lavel to a ticket
client.unspam_ticket(ticket_id)

# Un-Star tickets
client.unstar_ticket(ticket_id)

# Trash ticket
client.trash_ticket(ticket_id)

# Un-Trash ticket
client.untrash_ticket(ticket_id)

# Fetching ticket replies
client.ticket_replies(ticket_id)

# Reply to a ticket with text/html and with an  optional array of attachments
client.create_ticket_reply(ticket_id, {text: "hello", html: "hello"}, [])

# Get comments of a ticket
client.ticket_comments(ticket_id)

# Create a comment of a ticket
client.create_ticket_comment(ticket_id)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[bronzdoc]/beekit.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
