class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    "/interests" # Or :prefix_to_your_route
  end


private

  def sign_up_params
    params.require(:user).permit(:email, :password, :first_name, :last_name, :birthday, :avatar)
  end

end
