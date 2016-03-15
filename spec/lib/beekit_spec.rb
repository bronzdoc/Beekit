RSpec.describe Beekit do
  describe Beekit::Client do
    let(:client) { Beekit::Client.new("company", "api_token")}

    it "should include the tickets module" do
      expect(Beekit::Client).to include(Beekit::Tickets)
    end

    describe "#new" do
      it "should set the api_token" do
        expect(client.api_token).to eq("api_token")
      end

      it "should set the company" do
        expect(client.company).to eq("company")
      end
    end

    describe "#company=" do
      it "should set new company" do
        client.company = "othercompany"
        expect(client.company).to eq("othercompany")
      end

      it "should modify the base_uri" do
        client.company = "othercompany"
        expect(client.base_uri).to eq("https://othercompany.supportbee.com")
      end
    end

    describe "#tickets" do
      before do
        VCR.insert_cassette 'tickets', :record => :new_episodes
      end

      after do
        VCR.eject_cassette
      end

      it "should return a hash" do
        expect(client.tickets.class).to eq(Array)
      end

      it "should return 5 tickets" do
        expect(client.tickets.count).to eq(5)
      end
    end

    describe "#search_tickets" do
      before do
        VCR.insert_cassette 'search_ticket', :record => :new_episodes
      end

      after do
        VCR.eject_cassette
      end

      it "returns tickets matching the search query" do
        expect(client.search_tickets("Henry").class).to eq(Array)
      end

      context "when query Henry" do
        it "should return just 1 record" do
          expect(client.search_tickets("Henry").count).to eq(1)
        end

        it "should have email equal to beast_boy@gmail.com" do
          tickets = client.search_tickets("Henry")
          expect(tickets.first["requester"]["email"]).to eq("beast_boy@gmail.com")
        end
      end
    end

    describe "#create_ticket" do
      before do
        VCR.insert_cassette 'create_ticket', :record => :new_episodes
      end

      after do
        VCR.eject_cassette
      end

      it "should create new ticket" do
        options = {
          subject: "Computer problem!",
          requester_name: "Francisco",
          requester_email: "panchito@gmail.com"
        }
        new_ticket = client.create_ticket("My computer is not working, please help me!", options)
        expect(new_ticket["requester"]["email"]).to eq("panchito@gmail.com")
      end
    end

    describe "#ticket" do
      before do
        VCR.insert_cassette 'ticket', :record => :new_episodes
      end

      after do
        VCR.eject_cassette
      end

      it "should get the ticket specified by the ticket_id argument" do
        expect(client.ticket(8379175)["requester"]["name"]).to eq("Erik Lehnsherr")
      end
    end

    describe "#delete_trashed_ticket!" do
      it "should delete a trashed ticket" do
        VCR.insert_cassette 'delete_trashed_ticket', :record => :new_episodes
        expect(client.delete_trashed_ticket!(8383796)["code"]).to eq("204")
      end
    end

    describe "#archive_ticket" do
      before do
        VCR.insert_cassette 'archived_ticket', :record => :new_episodes
      end

      after do
        VCR.eject_cassette
      end

      it "should return a 204 code when the ticket is archived successfully" do
        expect(client.archive_ticket(8379175)["code"]).to eq("204")
      end
    end

    describe "#unarchive_ticket" do
      before do
        VCR.insert_cassette 'unarchived_ticket', :record => :new_episodes
      end

      after do
        VCR.eject_cassette
      end

      it "should return a 204 code when the ticket is unarchived successfully" do
        expect(client.unarchive_ticket(8379175)["code"]).to eq("204")
      end
    end

    describe "#assign_ticket" do
      after do
        VCR.eject_cassette
      end

      it "should assign the ticket to a user correctly" do
        VCR.insert_cassette 'ticket_user_assign', :record => :new_episodes
        expect(client.assign_ticket(8379182, user_id: 2517806)["assignee"]["user"]["email"]).to eq("person4@example.com")
      end

      it "should assign the ticket to a group correctly" do
        VCR.insert_cassette 'ticket_group_assign', :record => :new_episodes
        expect(client.assign_ticket(8379182, group_id: 5470)["assignee"]["group"]["name"]).to eq("x-men")
      end
    end

    describe "star_ticket" do
      after { VCR.eject_cassette }

      it "should star the specified ticket" do
        VCR.insert_cassette 'star_ticket', :record => :new_episodes
        res = client.star_ticket(8379175)
        expect(res["code"]).to eq("201")
        expect(res["message"]).to eq("Created")
      end

      describe "#unstar_ticket" do
        after { VCR.eject_cassette }

        it "should unstar the specified ticket" do
          VCR.insert_cassette 'unstar_ticket', :record => :new_episodes
          res = client.unstar_ticket(8379175)
          expect(res["code"]).to eq("204")
          expect(res["message"]).to eq("No Content")
        end
      end

      describe "#spam_ticket" do
        after { VCR.eject_cassette }

        it "should mark as spam the specified ticket" do
          VCR.insert_cassette 'spam_ticket', :record => :new_episodes
          res = client.spam_ticket(8379182)
          expect(res["code"]).to eq("204")
          expect(res["message"]).to eq("No Content")
        end
      end

      describe "#unspam_ticket" do
        it "should unspam the specified ticket" do
          VCR.insert_cassette 'unspam_ticket', :record => :new_episodes
          res = client.unspam_ticket(8379182)
          expect(res["code"]).to eq("204")
          expect(res["message"]).to eq("No Content")
        end
      end

      describe "#trash_ticket" do
        it "should trash the specified ticket" do
          VCR.insert_cassette 'trash_ticket', :record => :new_episodes
          res = client.trash_ticket(8379182)
          expect(res["code"]).to eq("204")
          expect(res["message"]).to eq("No Content")
        end
      end

      describe "#untrash_ticket" do
        it "should trash the specified ticket" do
          VCR.insert_cassette 'untrash_ticket', :record => :new_episodes
          res = client.untrash_ticket(8379182)
          expect(res["code"]).to eq("204")
          expect(res["message"]).to eq("No Content")
        end
      end

      describe "#ticket_replies" do
        it "should get back ticket replies" do
          VCR.insert_cassette 'ticket_replies', :record => :new_episodes
          expect(client.ticket_replies(8379182)["replies"].count).to eq(1)
        end
      end

      describe "#create_ticket_reply" do
        it "should create a reply in the specified ticket" do
          VCR.insert_cassette 'create_ticket_reply', :record => :new_episodes
          res = client.create_ticket_reply(8379182, text: "Hey what's up! what's your problem?")
          expect(res["reply"]["content"]["text"]).to eq("Hey what's up! what's your problem?")
        end
      end

      describe "#ticket_comments" do
        it "should get the comments of the specified ticket" do
          VCR.insert_cassette 'ticket_comments', :record => :new_episodes
          res = client.ticket_comments(8379182)
          expect(res["comments"].count).to eq(3)
        end
      end

      describe "#create_ticket_comment" do
        it "should create a comment on the specified ticket" do
          VCR.insert_cassette 'create_ticket_comment', :record => :new_episodes
          res = client.create_ticket_comment(8383813, text: "Hey what's up! what's your problem?")
          expect(res["comment"]["ticket"]["comments_count"]).to eq(1)
        end
      end
    end
  end
end
