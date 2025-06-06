class MembershipCreator
  include Callable

  def initialize(user:, organization:)
    @user = user
    @organization = organization
  end

  def call
    Membership.create(user: @user, organization: @organization)
    @user.add_role(:account, @organization)
    @user.update(current_organization: @organization)
  end
end
