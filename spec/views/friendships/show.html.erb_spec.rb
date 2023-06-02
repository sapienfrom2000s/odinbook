# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'friendships/show', type: :view do
  before(:each) do
    assign(:friendship, Friendship.create!)
  end

  it 'renders attributes in <p>' do
    render
  end
end
