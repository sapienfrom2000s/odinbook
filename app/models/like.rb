require 'pry-byebug'

class Like < ApplicationRecord
    belongs_to :user
    belongs_to :post
    validate :absence_of_duplicate_record

    def absence_of_duplicate_record
        errors.add :base, :invalid, message: "The post has already been liked by the user" if Like\
        .where(post_id:post_id,user_id:user_id).exists?
    end
end
