require 'pry-byebug'

class Like < ApplicationRecord
  belongs_to :user
  belongs_to :post
  validate :presence_of_duplicate_record

  def presence_of_duplicate_record
    errors.add :base, :invalid, message: 'The post has already been liked by the user' if Like\
                                                                                          .where(post_id:, user_id:).exists?
  end

  def self.submission_url(post, current_user)
    like = like_on_post(post, current_user)
    return "#{post.creator.username}/posts/#{post.id}/likes" unless like.exists?

    "#{post.creator.username}/posts/#{post.id}/likes/#{like.first.id}"
  end

  def self.like_dislike_button(post, current_user)
    return 'Like' unless like_on_post(post, current_user).exists?

    'Unlike'
  end

  def self.like_on_post(post, current_user)
    Like.where(post_id: post.id, user_id: current_user.id)
  end
end
