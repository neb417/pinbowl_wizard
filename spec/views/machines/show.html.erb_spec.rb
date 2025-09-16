require 'rails_helper'

RSpec.describe "machines/show", type: :view do
  let(:organization) { FactoryBot.create(:organization)  }

  before(:each) do
    assign(:machine, Machine.create!(
      name: "Name",
      organization: organization
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
