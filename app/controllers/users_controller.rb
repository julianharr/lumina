class UsersController < ApplicationController

  # Below code is from Taggable Gem
  # def user_params
  #   params.require(:user).permit(:name, :tag_list) ## Rails 4 strong params usage
  # end

  def show
    @user = User.find(params[:id])
    @wishlist = Wishlist.where(user_id: @user.id)
  end
end
