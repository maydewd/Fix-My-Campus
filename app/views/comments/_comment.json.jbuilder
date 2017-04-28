if comment
    json.extract! comment, :message, :created_at
    
    json.user do json.partial! 'devise/user', user: comment.user, include_url: true end 
else
    json.null!
end