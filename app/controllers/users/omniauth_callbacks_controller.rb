class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :set_service
  before_action :set_user

  attr_reader :service, :user

  def facebook
    handle_auth "Facebook"
  end

  def twitter
    handle_auth "Twitter"
  end

  def meetup
    handle_auth "Meetup"
  end

  private

  def handle_auth(kind)
    if service.present?
      service.update(service_attrs)
    else
      user.services.create(service_attrs)
    end

    if user_signed_in?
      flash[:notice] = "Your #{kind} account was connected."
      redirect_to edit_user_registration_path
    else
      sign_in_and_redirect user, event: :authentication
      set_flash_message :notice, :success, kind: kind
    end
  end

  def auth
    p request.env['omniauth.auth']
  end

  def set_service
    @service = Service.where(provider: auth.provider, uid: auth.uid).first
  end

  def set_user
    if user_signed_in?
      @user = current_user
    elsif service.present?
      @user = service.user
    elsif User.where(email: auth.info.email).any?
      # 5. User is logged out and they login to a new account which doesn't match their old one
      flash[:alert] = "An account with this email already exists. Please sign in with that account before connecting your #{auth.provider.titleize} account."
      redirect_to new_user_session_path
    else
      @user = create_user
    end
  end

  def service_attrs
    expires_at = auth.credentials.expires_at.present? ? Time.at(auth.credentials.expires_at) : nil
    refresh_token = auth.credentials.refresh_token.present? ? auth.credentials.refresh_token : nil
    {
      provider: auth.provider,
      uid: auth.uid,
      expires_at: expires_at,
      access_token: auth.credentials.token,
      access_token_secret: auth.credentials.secret,
      refresh_token: refresh_token
    }
  end

  def create_user
    ## check that name exist ?
    email = auth.info.email.present? ? auth.info.email : "no_email@gmail.com"
    first_name = auth.info.name.present? ? auth.info.name.split.first.capitalize : user["login"].capitalize
    last_name = auth.info.name.present? ? auth.info.name.split[1]&.capitalize : ""

    User.create!(
      email: email,
      first_name: first_name,
      last_name: last_name,
      password: Devise.friendly_token[0, 20]
    )
  end
end

## FACIE
# <OmniAuth::AuthHash raw_info=#<OmniAuth::AuthHash email="chris@wadespace.net" id="10157692609587077" name="Chris Wade">> info=#<OmniAuth::AuthHash::InfoHash email="chris@wadespace.net" image="http://graph.facebook.com/v4.0/10157692609587077/picture?access_token=EAANEb8pz2O0BAD89uL2ccQDsdr04VxLePvP7S8huBGu3nVUR2Xd9r1w6I0VNxomwI59HEj9EoJin6kkn0fnU7jZBf1TftbmCmbjvo9LXdC1eO3LI7K0e5N6ULRUiZC0g5rlAXhAiNSwktOCvioPTMKYJTSCDiZCfYATpV67viyBhhKTehwA" name="Chris Wade"> provider="facebook" uid="10157692609587077">
