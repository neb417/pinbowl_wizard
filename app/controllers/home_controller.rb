class HomeController < ApplicationController
  def index
    authorize Current.user, policy_class: HomePolicy

    if Current.user.current_organization_id.present?
      redirect_to dashboard_path
    end
  end
end
