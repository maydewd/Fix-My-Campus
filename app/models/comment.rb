class Comment < ApplicationRecord
    validates :message, presence: true, length: { maximum: 10000 }
    belongs_to :user
    belongs_to :post
    
    counter_culture :post
end
