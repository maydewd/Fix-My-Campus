class Comment < ApplicationRecord
    belongs_to :user
    belongs_to :post
    
    counter_culture :post
end
