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

  def user_has_status?(user)
    user.status.present?
  end

  def user_has_meetup?(user)
    user.services.each do |element|
      return true if element.provider == 'meetup'
    end
  end

  def event_has_no_questions?(event)
    return true if event.group_quest_required == false
  end
end
