class School < ApplicationRecord
    has_many :users
    has_many :posts
    
    def admins
        users.where(:admin =>  true)
    end
end
