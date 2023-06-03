# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  validates :title, length: { minimum: 10 }
  validates :body, length: { minimum: 30 }
end
