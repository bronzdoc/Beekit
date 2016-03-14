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
# Return 15 tickets of the company in the order of their last activity
client.tickets

# Pass an options hash for specific tickets
client.tickets({label: "important", per_page: 10})

# Get a single ticket
client.ticket(ticket_id)
```

# Creating tickets

```ruby
client.create_ticket("ticket content", {
    subject: "Subject",
    requester_name: "Charles xavier",
    requester_email: "charles@gmail.com",
    cc: ["hank_maccoy@gmail.com"],
})

```

# Deleting tickets

```ruby
client.delete_ticket!(ticket_id)
```

# Actions on Tickets

```ruby
# Archives an unarchived ticket
client.archive_ticket(ticket_id)

# Un-archives an archived ticket
client.unarchive_ticket(ticket_id)

# Marks the ticket with a label
client.mark_ticket(ticket_id, :label)

# Assign a ticket to a user/group
client.assign_ticket(ticket_id, user_id)
client.assign_ticket(ticket_id, group_id)

# Star a ticket
client.star_ticket(ticket_id)

# Un-Star tickets
client.unstar_ticket(ticket_id)

# Trash ticket
client.trash_ticket(ticket_id)

# Un-Trash ticket
client.untrash_ticket(ticket_id)

# Fetching ticket replies
client.ticket_replies(ticket_id)

# Reply to a ticket
client.ticket_reply(ticket_id, "reply content")
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[bronzdoc]/beekit.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

