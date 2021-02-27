class ApplicationController < ActionController::Base
  before_action :authenticate_user!


  # def after_sign_up_path_for(resource)
  #   interest_path(resource) # <- Path you want to redirect the user to.
  # end
end
