if post
    json.extract! post, :id, :message, :status, :likes_count, :comments_count, :created_at
    if post.legacy?
        json.user name: post.legacy_user_name
    else
        json.user do json.partial! 'devise/user', user: post.user, include_url: true end
    end
    json.likes_count post.likes_count+post.legacy_numlikes
    
    json.url post_url(post, format: :json) if include_url
else
    json.null!
end