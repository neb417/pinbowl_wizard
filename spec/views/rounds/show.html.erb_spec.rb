require 'rails_helper'

RSpec.describe "rounds/show", type: :view do
  before(:each) do
    assign(:round, Round.create!(
      season: nil
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
  end
end
