module ApplicationHelper
  ## Image methods bikes on index page with map
  def cloudinary_imgs(key, instance)
    cl_image_tag(key, height: 250, width: 350, fetch_format: :auto, crop: "fill", class: "card-i.namg-top img-fluid mx-auto rounded", alt: instance.first_name)
  end

  def cloudinary_avatar_nav(key)
    cl_image_tag(key, height: 50, width: 50, fetch_format: :auto, crop: "fill", class: "avatar rounded-circle")
  end

  ## has_friendship Helpers
  def pending_friendship(user)
    # gives back an arr of IDS of peeps
    # trying to friend user
    # binding.pry
    user.requested_friends
  end

  def users_friends(user)
    user.friends
  end
end
