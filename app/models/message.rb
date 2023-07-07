class Message < ApplicationRecord
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User'
  belongs_to :receiver, foreign_key: :receiver_id, class_name: 'User'

  validates :body, presence: true

  def self.chats_between(current_user, friend)
    friend_id = User.find_by(username: friend)
    (self.where(sender_id:current_user.id, receiver_id:friend_id)\
    .or(self.where(sender_id:friend_id, receiver_id:current_user.id)))\
    .order(created_at: :desc)
  end
end
