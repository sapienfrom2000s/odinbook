# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  validates :title, length: { minimum: 10 }
  validates :body, length: { minimum: 30 }

  has_many :likes
  has_many :users_who_liked, through: :likes, source: :user
  has_many :comments
end
