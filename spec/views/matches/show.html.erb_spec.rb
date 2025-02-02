require 'rails_helper'

RSpec.describe "matches/show", type: :view do
  let(:match_played) { create(:match) }

  before(:each) do
    assign(:match, match_played)
  end

  it "renders attributes in <p>" do
    render

    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/2/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
