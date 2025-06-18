require 'rails_helper'

RSpec.describe "dashboard/index", type: :view do
  let(:org) { create(:organization) }
  let(:owner) { create(:owner_user, current_organization: org, organization: org) }

  before do
    sign_in_as(owner)
    assign(:organization, org)
  end

  it "renders index" do
    render
    cell_selector = 'h1'
    assert_select cell_selector, text: Regexp.new(org.name.to_s)
  end
end