# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sent_requests, foreign_key: :sender, class_name: 'FriendRequest'
  has_many :received_requests, foreign_key: :receiver, class_name: 'FriendRequest'
  has_many :posts
  has_many :likes
  has_many :liked_posts, through: :likes, source: :post
  has_many :comments

  has_many :sent_messages, foreign_key: :sender, class_name: 'Message'
  has_many :received_messages, foreign_key: :receiver, class_name: 'Message'

  has_many :notifications, class_name: 'Notification', foreign_key: :user

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :username, format: { with: /^[a-zA-Z0-9_.]*$/, multiline: true }

  attr_writer :login

  def login
    @login || username || email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions).where(['lower(username) = :value OR lower(email) = :value', { value: login.downcase }]).first
    elsif conditions[:username].nil?
      where(conditions).first
    else
      where(username: conditions[:username]).first
    end
  end

  #there has to be a way to remove the current_user nuisance

  def self.find_friends(current_user)
    nonpotential_friends = current_user.sent_requests.pluck(:receiver_id) + current_user.received_requests.pluck(:sender_id) + [current_user.id]
    User.where.not(id: nonpotential_friends)
  end

  def self.sent_friendrequests(current_user)
    anti_join = FriendRequest.joins('LEFT JOIN friendships ON friend_requests.id = friendships.metadata_id').where('friendships.metadata_id IS NULL')
    anti_join.where(sender_id: current_user.id)
  end

  def self.friends(current_user)
    connections = Friendship.connections(current_user)
    connections.map do |connection|
      next connection.receiver unless connection.receiver.id == current_user.id
      connection.sender
    end
  end
end
