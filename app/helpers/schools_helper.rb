module SchoolsHelper
    
    # Given a status (enum in post model), returns the suffix for standard bootstrap css coloring
    def status_to_suffix (status)
        if status == 'unreviewed'
            return 'primary'
        elsif status == 'in_progress'
            return 'warning'
        elsif status == 'completed'
            return 'success'
        elsif status == 'declined'
            return 'danger'
        else    
            raise "Unexpected status #{status} given"
        end
    end
    
    # Given a set of status params, returns true if the given status checkbox should be checked and false otherwise
    def params_to_status_checked(statuses_params, status)
        if statuses_params.nil?
            Post.DEFAULT_STATUSES.include? status
        else
            statuses_params.include? status
        end
    end
end
