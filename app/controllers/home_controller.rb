class HomeController < ApplicationController
  def index
    authorize Current.session

    if Current.user.current_organization_id.present?
      redirect_to dashboard_path
    end
  end
end
