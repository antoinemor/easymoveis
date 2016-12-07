module ApplicationHelper
  def avatar_image(user)
    if user.facebook_picture_url
      return user.facebook_picture_url
    elsif user.photo
      return user.photo.path
    else
      return "http://placehold.it/150x150"
    end
  end
end
