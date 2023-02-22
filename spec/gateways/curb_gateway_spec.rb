describe CurbGateway, type: :gateway do
  describe "#get_throw" do
    let(:url) { ENV.fetch("CURB_API_URL") + "/rps-stage/throw" }
    subject { described_class.new.get_throw }

    before do
      stub_request(:get, url).to_return(status: status_code, body: respond_body.to_json)
    end

    context "with good response" do
      let(:status_code) { 200 }
      let(:respond_body) { {
        "statusCode": 200,
        "body": throw
      } }
      let(:throw) { "rock" }

      it "returns throw" do
        expect(subject).to eq(throw)
      end
    end

    context "with bad response" do
      let(:status_code) { 500 }
      let(:respond_body) { {
        "message": "Internal server error"
      } }

      before { stub_const("CurbGateway::THROWS", ["scissors"]) }

      it "returns throw" do
        expect(subject).to eq("scissors")
      end
    end
  end
end