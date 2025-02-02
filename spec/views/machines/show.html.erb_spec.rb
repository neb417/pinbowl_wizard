require 'rails_helper'

RSpec.describe "machines/show", type: :view do
  before(:each) do
    assign(:machine, Machine.create!(
      name: "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
