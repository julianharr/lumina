class UsersController < ApplicationController

  # Below code is from Taggable Gem
  def user_params
    params.require(:user).permit(:name, :tag_list) ## Rails 4 strong params usage
  end
end
