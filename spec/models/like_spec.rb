require 'rails_helper'

RSpec.describe Like, type: :model do
  before do 
    user = create(:user)
    post = Post.new(title:'this is more than 10 chars', body:'this is....................................
      .................more than 30 chars')
    post.creator = user
    post.save
  end
  context 'when a post is liked' do
    it 'creates association bw user and the post' do
      expect{Like.create(user_id:User.first.id, post_id: Post.first.id)}.to change{Like.count}
    end
  end

  context 'when a like already exists' do
    it 'rolls back the transaction' do
      Like.create(user_id:User.first.id, post_id: Post.first.id)
      expect{Like.create(user_id:User.first.id, post_id: Post.first.id)}.to_not change{Like.count}      
    end
  end
  
  context 'when a post is unliked' do
    it 'destroys the association between user and the post' do 
      Like.create(user_id:User.first.id, post_id: Post.first.id)
      expect{Like.first.destroy}.to change{Like.count}.by(-1)            
    end
  end
end
