class Like < ApplicationRecord
    belongs_to :user
    belongs_to :post
    
    counter_culture :post
    counter_culture :post, 
                column_name: proc {|like| like.created_at >= 1.hour.ago ? 'recent_likes_count' : nil },
                column_names: {
                      ["likes.created_at >= ?", 1.hour.ago] => 'recent_likes_count'
                  }
end
