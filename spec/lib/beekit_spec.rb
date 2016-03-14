RSpec.describe Beekit do
  describe Beekit::Client do
    let(:client) { Beekit::Client.new("company", "api_token")}

    describe "#new" do
      it "should set the api_token correctly" do
        expect(client.api_token).to eq("api_token")
      end
    end
  end
end
