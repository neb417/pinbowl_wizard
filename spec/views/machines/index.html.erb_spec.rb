require 'rails_helper'

RSpec.describe "machines/index", type: :view do
  before(:each) do
    assign(:machines, [
      Machine.create!(
        name: "Name"
      ),
      Machine.create!(
        name: "Name"
      )
    ])
  end

  it "renders a list of machines" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
  end
end
