class AttemptsController < ApplicationController
  before_action :check_throw

  def create
    result = HandleAttempt.new.call(params[:user_throw].downcase)
    redirect_to game_path({id: result.delete(:winner)}.merge(result))
  end

  private

  def check_throw
    unless params[:user_throw].downcase.in?(%w[rock paper scissors])
      redirect_to "/games/bad_throw"
    end
  end
end