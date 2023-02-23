describe HandleAttempt do
  describe "#call" do
    subject { described_class.new.call(user_throw) }

    before do
      allow_any_instance_of(CurbGateway).to receive(:get_throw).and_return(curb_throw)
    end

    context "when throw identical" do
      let(:curb_throw) { "rock" }
      let(:user_throw) { "rock" }

      it "returns `identical`" do
        expect(subject[:winner]).to eq("identical")
      end
    end

    context "when user will win" do
      shared_examples "user win" do
        it "returns `user`" do
          expect(subject[:winner]).to eq("user")
        end
      end

      context "with `scissors`" do
        let(:user_throw) { "scissors" }
        let(:curb_throw) { "paper" }

        it_behaves_like "user win"
      end

      context "with `paper`" do
        let(:user_throw) { "paper" }
        let(:curb_throw) { "rock" }

        it_behaves_like "user win"
      end

      context "with `rock`" do
        let(:user_throw) { "rock" }
        let(:curb_throw) { "scissors" }

        it_behaves_like "user win"
      end
    end

    context "when user will lose" do
      let(:curb_throw) { "scissors" }
      let(:user_throw) { "paper" }

      it "returns `curb`" do
        expect(subject[:winner]).to eq("curb")
      end
    end
  end
end