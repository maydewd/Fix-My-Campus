class Post < ApplicationRecord
    belongs_to :school
    belongs_to :user
    
    def self.search(query)
        if query
            where("lower(message) LIKE ?", "%#{query.downcase}%")
        else
            all
        end
    end
end
