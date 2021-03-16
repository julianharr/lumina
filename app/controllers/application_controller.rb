class ApplicationController < ActionController::Base
  before_action :store_user_location!, if: :storable_location?
  # The callback which stores the current location must be added before you authenticate the user
  # as `authenticate_user!` (or whatever your resource is) will halt the filter chain and redirect
  # before the location can be stored.
  before_action :authenticate_user!

  # Redirect back to current page after sign in
  # ref: https://github.com/heartcombo/devise/wiki/How-To:-Redirect-back-to-current-page-after-sign-in,-sign-out,-sign-up,-update
  def storable_location?
    request.get? && is_navigational_format? && !devise_controller? && !request.xhr?
  end

  def store_user_location!
    # :user is the scope we are authenticating
    store_location_for(:user, request.fullpath)
  end

  def after_sign_in_path_for(_resource)
    feed_path
  end

  # def after_sign_up_path_for(resource)
  #   stored_location_for(resource) || feed_path
  # end
end
