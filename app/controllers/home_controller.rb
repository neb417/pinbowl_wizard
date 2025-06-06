class HomeController < ApplicationController
  def index
    if Current.user.current_organization_id.present?
      redirect_to dashboard_path
    end
  end

  def dashboard
    authorize Current.user, policy_class: HomePolicy

    @organization = Organization.find(Current.user.current_organization_id)
  rescue
    flash.now[:notice] = "You are unauthorized for this action"
    redirect_to root_path
  end
end
