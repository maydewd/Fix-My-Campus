class Post < ApplicationRecord
    belongs_to :school
    belongs_to :user
    
    enum status: [:unreviewed, :in_progress, :completed, :declined]
    
    def self.search(query)
        if query && !query.empty?
            where("lower(message) LIKE ?", "%#{query.downcase}%")
        else
            all
        end
    end
    
    # statuses can be a single string or symbol, or any array of strings or symbols
    def self.filter_status(statuses)
        if statuses.nil?
            where(status: self.DEFAULT_STATUSES)
        else
            where(status: statuses)
        end
    end
    
    # Seems a bit odd, I know, but it is the best way to avoid code duplication and hidden dependency
    # between the model filter and the checkbox view layer
    def self.DEFAULT_STATUSES
        ['unreviewed', 'in_progress']
    end
end
