class OrganizationCreator
  include Callable

  def initialize(user:, org_params:)
    @user = user
    @org_params = org_params
  end

  def call
    organization = Organization.new(@org_params)
    if organization.save
      @user.add_role(:account, organization)
      @user.add_role(:owner, organization)
      @user.update(current_organization: organization)
    end
    organization
  end
end
