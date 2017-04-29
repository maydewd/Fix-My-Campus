class School < ApplicationRecord
    has_many :users
    has_many :posts
    
    validates_presence_of :name, :nickname, :email_suffix
    
    def admins
        users.where(:admin =>  true)
    end
    
    def to_param  # overridden
        nickname
    end
end
