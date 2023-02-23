class HandleAttempt
  RULES = {
    "rock" => "scissors",
    "paper" => "rock",
    "scissors" => "paper"
  }

  def initialize
    @curb_bot = CurbGateway.new
  end

  def call(user_throw)
    curb_throw = @curb_bot.get_throw
    if user_throw == curb_throw
      winner = "identical"
    else
      winner = RULES[user_throw] == curb_throw ? "user" : "curb"
    end
    {winner: winner, user_throw: user_throw, curb_throw: curb_throw}
  end
end