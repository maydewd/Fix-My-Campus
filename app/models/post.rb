class Post < ApplicationRecord
    belongs_to :school
    belongs_to :user, optional: true
    has_many :likes
    has_many :comments
    
    enum status: [:unreviewed, :in_progress, :completed, :declined]
    
    # Adds a where sql condition so the post message contains the query string (case insensitive)
    def self.search(query)
        if query && !query.empty?
            where("lower(message) LIKE ?", "%#{query.downcase}%")
        else
            all
        end
    end
    
    # Adds a where sql condition so only posts with any of the given statuses are returned
    # statuses can be a single string or symbol, or any array of strings or symbols
    def self.filter_status(statuses)
        if statuses.nil?
            where(status: self.DEFAULT_STATUSES)
        else
            where(status: statuses)
        end
    end
    
    def self.complex_order(sort)
        if sort == 'newest'
            order("created_at DESC")
        elsif sort == 'trending'
            order("recent_likes_count DESC, created_at DESC")
        elsif sort == 'top'
            order("likes_count + legacy_numlikes DESC, created_at DESC")
        else # Default behavior is sort by created time
            order("created_at DESC")
        end
    end
    
    # Seems a bit odd, I know, but it is the best way to avoid code duplication and hidden dependency
    # between the model filter and the checkbox view layer
    def self.DEFAULT_STATUSES
        ['unreviewed', 'in_progress']
    end
end
