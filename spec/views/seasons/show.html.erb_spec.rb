require 'rails_helper'

RSpec.describe "seasons/show", type: :view do
  before(:each) do
    assign(:season, create(:season))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
  end
end
