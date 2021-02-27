class InterestsController < ApplicationController

  def create
    @user = current_user
    @interest_array = params["interest"].split(",")
    @user.interest_list.add@interest_array
    if @user.save
      redirect_to feed_path
    else
      raise
    end
  end

end
