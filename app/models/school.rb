class School < ApplicationRecord
    has_many :users
    has_many :posts
    
    def admins
        users.where(:admin =>  true)
    end
    
    def to_param  # overridden
        nickname
    end
end
