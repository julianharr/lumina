class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home ]

  def home
  end

  # TODO
  # Define Feed and Dashboard in this controller
end
