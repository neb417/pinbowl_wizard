require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, create_list(:user, 2))
  end

  it "renders a list of users" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: /First name:/, count: 2
    assert_select cell_selector, text: /Last name:/, count: 2
  end
end
