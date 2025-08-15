class DashboardController < ApplicationController
  def index
    return redirect_to root_path unless authorize Current.user, policy_class: DashboardPolicy

    @organization = Organization.find(Current.user.current_organization_id)
  end
end
