require 'rails_helper'

RSpec.describe "users/show", type: :view do
  let(:user) { create(:user) }
  before(:each) do
    assign(:user, user)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/First name:/)
    expect(rendered).to match(/Last name:/)
    expect(rendered).to match(/Email:/)
  end
end
