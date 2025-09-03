class ApplicationController < ActionController::Base
  helper_method :can_view_private_docs?

  ADMIN_EMAIL = "314cbt@gmail.com".freeze

  def can_view_private_docs?
    defined?(user_signed_in?) && user_signed_in? && current_user&.email == ADMIN_EMAIL
  end

  def require_owner
    return if can_view_private_docs?
    redirect_to root_path, alert: "Not authorized"
  end
end
