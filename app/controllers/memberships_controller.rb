class MembershipsController < ApplicationController
  def new
    @membership = Membership.new
  end

  def create
    organization = Organization.find_by(code: membership_params[:organization_code])

    if organization.present?
      MembershipCreator.call(user: Current.user, organization: organization)
      redirect_to dashboard_path, notice: "Joined organization!"
    else
      @membership = Membership.new
      @membership.errors.add(:base, "Organization not found.")
      render :new, status: :unprocessable_content
    end
  end

  private

  def membership_params
    params.expect(membership: [ :organization_code ])
  end
end
