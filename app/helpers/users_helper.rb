module UsersHelper
  def avatar_img
    current_user.img_url || "/assets/temp/default_user.jpg"
  end
end
