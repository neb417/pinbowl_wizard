class HomeController < ApplicationController
  def index
    if Current.user.current_organization_id.present?
      render dashboard_path
    end
  end

  def dashboard
    authorize Current.user, policy_class: HomePolicy
    @organization = Organization.find(Current.user.current_organization_id)
  end
end
