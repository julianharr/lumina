class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end


  # TODO
  # Define Feed and Dashboard in this controller

  def feed
    @user = current_user
    # authorize @user
  end

  def dashboard
    @user = current_user
    # authorize @user
  end

  def interests
    @user = current_user
  end

end
