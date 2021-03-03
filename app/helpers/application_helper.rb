module ApplicationHelper
  ## Image methods bikes on index page with map
  def cloudinary_imgs(key, instance)
    cl_image_tag(key, height: 250, width: 350, fetch_format: :auto, crop: "fill", class: "card-i.namg-top img-fluid mx-auto rounded", alt: instance.name.to_s)
  end
end
