describe "Attempt" do
  describe "POST /attempts" do
    let(:user_throw) { "rock" }
    let(:winner) { "user" }
    let(:result) { {winner: winner, user_throw: user_throw, curb_throw: "scissors"} }

    before do
      allow_any_instance_of(HandleAttempt).to receive(:call)
        .with(user_throw)
        .and_return(result)
    end

    it "returns to result page" do
      make_request(user_throw)
      expect(response).to redirect_to("/games/user?curb_throw=scissors&user_throw=rock")
    end

    context "with bad request" do
      it "returns to page with error" do
        make_request("wrong")
        expect(response).to redirect_to("/games/bad_throw")
      end
    end

    def make_request(throw)
      post "/attempts", params: {user_throw: throw}
    end
  end
end