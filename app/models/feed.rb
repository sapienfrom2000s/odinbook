class Feed
  #there has to be a way to remove the current_user nuisance
  def self.posts(current_user)
    friends_posts(current_user).order('updated_at DESC') + non_friend_public_posts(current_user).order('updated_at DESC')
  end

  def self.friends_posts(current_user)
    Post.includes(:creator).where(user_id: friends_ids(current_user))
  end

  def self.non_friend_public_posts(current_user)
    Post.includes(:creator).where.not(user_id: friends_ids(current_user)+[current_user.id])
  end

  private

  def self.friends_ids(current_user)
    User.friends(current_user).pluck(:id)
  end
end