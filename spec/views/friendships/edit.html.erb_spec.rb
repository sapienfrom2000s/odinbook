# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'friendships/edit', type: :view do
  let(:friendship) do
    Friendship.create!
  end

  before(:each) do
    assign(:friendship, friendship)
  end

  it 'renders the edit friendship form' do
    render

    assert_select 'form[action=?][method=?]', friendship_path(friendship), 'post' do
    end
  end
end
