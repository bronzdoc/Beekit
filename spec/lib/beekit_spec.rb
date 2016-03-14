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
  end
end
