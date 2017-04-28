json.school do json.partial! @school, include_url: true end
json.num_posts @school.posts.count
json.statuses @school.posts.group(:status).order(:status).count
json.most_liked_post do json.partial! 'posts/post', post: @most_liked_post, include_url: true end if @most_liked_post
json.most_commented_post do json.partial! 'posts/post', post: @most_commented_post, include_url: true end if @most_commented_post
json.average_post_likes @average_post_likes
json.average_post_comments @average_post_comments