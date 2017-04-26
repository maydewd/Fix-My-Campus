class Like < ApplicationRecord
    belongs_to :user
    belongs_to :post
    
    counter_culture :post
    counter_culture :post, column_name: proc {|like| like.created_at >= 24.hours.ago ? 'recent_likes_count' : nil }
end
