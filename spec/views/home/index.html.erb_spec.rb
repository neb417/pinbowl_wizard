require 'rails_helper'

RSpec.describe "home/index", type: :view do
  it "renders index" do
    render
    cell_selector = 'h1'
    assert_select cell_selector, text: Regexp.new("Pinbowl Wizard Home Page".to_s)
  end
end
