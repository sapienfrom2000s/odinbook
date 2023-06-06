require 'pry-byebug'

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validate :presence_of_duplicate_record

  def presence_of_duplicate_record
    errors.add :base, :invalid, message: 'The post has already been liked by the user' if Like\
                                                                                          .where(post_id:, user_id:).exists?
  end

  def self.metadata(post, current_user)
    Like.where(post_id: post.id, user_id: current_user.id)
  end
end
