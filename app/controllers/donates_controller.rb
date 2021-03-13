class DonatesController < ApplicationController

  def create
    @donate = Donate.new(donate_params)
    @donate.user = current_user
    @donate.save!

  end

  def donate_params
    params.permit(:amount, :charity_id)
  end

end
