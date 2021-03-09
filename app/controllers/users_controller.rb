class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  # Below code is from Taggable Gem
  def user_params
    params.require(:user).permit(:name, :tag_list) ## Rails 4 strong params usage
  end
end
