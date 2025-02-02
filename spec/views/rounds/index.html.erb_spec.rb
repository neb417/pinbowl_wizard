require 'rails_helper'

RSpec.describe "rounds/index", type: :view do
  let(:season) { create(:season) }
  before(:each) do
    assign(:rounds, [
      Round.create!(
        season: season
      ),
      Round.create!(
        season: season
      )
    ])
  end

  xit "renders a list of rounds" do
    render
    cell_selector = 'div>p'
    assert_select cell_selector, text: Regexp.new(nil.to_s), count: 2
  end
end
