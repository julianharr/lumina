class InterestsController < ApplicationController

  def create
    @interest_array = params["interest"].split(",")
    # current_user.interest.add(@interest)
  end

end
