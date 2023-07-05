require 'rails_helper'

RSpec.describe "feeds/edit", type: :view do
  let(:feed) {
    Feed.create!()
  }

  before(:each) do
    assign(:feed, feed)
  end

  it "renders the edit feed form" do
    render

    assert_select "form[action=?][method=?]", feed_path(feed), "post" do
    end
  end
end
