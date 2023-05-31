class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sent_requests, foreign_key: :sender, class_name: "FriendRequest"
  has_many :received_requests, foreign_key: :receiver, class_name: "FriendRequest"

  attr_writer :login

  def login
    @login || self.username || self.email
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if (login = conditions.delete(:login))
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      if conditions[:username].nil?
        where(conditions).first
      else
        where(username: conditions[:username]).first
      end
    end
  end

  def self.find_friends(current_user)
    nonpotential_friends = User.first.sent_requests.pluck(:receiver_id)+User.first.received_requests.pluck(:sender_id)+[current_user.id]
    potential_friends = User.where.not(id:nonpotential_friends)
  end

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates_format_of :username, with: /^[a-zA-Z0-9_\.]*$/, :multiline => true

end