class Comment < ApplicationRecord
  has_closure_tree
  belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
  belongs_to :original_post, foreign_key: 'post_id', class_name: 'Post'

  validates :body, presence: true
end
