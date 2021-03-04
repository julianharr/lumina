module UsersHelper
  def user_id(user)
    user.id if user && current_user.id.present?
  end

  def username(user)
    user.nickname if user && current_user.name.present?
  end

  def signupdate(user)
    user.created_at if user && current_user.created_at.present?
  end
end
