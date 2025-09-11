class ApplicationController < ActionController::Base
  include Authentication
  include Pundit::Authorization
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def pundit_user
    Current.user
  end

  def format_respond_to
    respond_to do |format|
      format.turbo_stream
      format.html
    end
  end

  private

  def user_not_authorized
    flash.now[:alert] = "You are not authorized to perform this action."
    redirect_back_or_to(root_path)
  end
end
