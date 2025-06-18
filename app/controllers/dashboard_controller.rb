class DashboardController < ApplicationController
  def index
    authorize Current.user, policy_class: HomePolicy

    @organization = Organization.find(Current.user.current_organization_id)
  end
end
