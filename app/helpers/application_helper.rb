module ApplicationHelper
  def devise_error_messages!
    resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
  end

  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def create_acivity target, action
    activity = Activity.new target: target, action: action, user_id: current_user.id
    unless activity.save
      flash_error activity
      redirect_to root_url
    end
  end

  def destroy_activity target, action
    activity = Activity.where(target: target).where(action: action).find_by user_id: current_user.id
    unless activity.destroy
      flash_error activity
      redirect_to :back
    end
  end

  def index_continue object, index, per_page
    (object.to_i - 1) * per_page.to_i + index + 1
  end

  def flash_error object
    flash[:danger] = object.errors.full_messages
  end

  def admin_verify
    unless current_user.role == "admin"
      flash[:danger] = t("require_admin")
      redirect_to root_url
    end
  end

  def manager_verify
    user = UserClub.find_by user_id: current_user.id
    unless user.is_manager == true
      flash[:danger] = t("require_manager")
      redirect_to root_url
    end
  end

  def is_management? club
    club = UserClub.club_scope(current_user).find_by(club_id: club.id)
    club.is_manager if club
  end

  def admin
    User.find_by role: 1
  end

  def attribute_object_array object, attribute
    arr = []
    attribute = attribute.to_sym
    object.each_with_index do |ob, index|
      arr[index] = ob[attribute]
    end
    arr
  end
end
