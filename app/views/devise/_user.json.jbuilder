if user
    json.extract! user, :id, :name
    json.school do json.partial! 'schools/school', school: user.school, include_url: false end
    
    json.url posts_for_user_url(user, format: :json) if include_url
else 
    json.null!
end