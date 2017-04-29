SCHOOL_SEED_ID = 2 # 1 is DUKE, 2 is UNC, 3 is NCSU ...
ADMINS_TO_MAKE = 2
NORMAL_USERS_TO_MAKE = 100
POSTS_TO_MAKE = 100
STATUS_WEIGHTS = {
    unreviewed: 0.18,
    in_progress: 0.47,
    completed: 0.26,
    declined: 0.09,
}
PROB_OF_LIKING = 0.5
PROB_OF_COMMENTING = 0.15


if (school = School.find_by(seed_id: SCHOOL_SEED_ID)).nil?
    abort("Couldn't find school with seed_id #{SCHOOL_SEED_ID}")
end

puts 'Making admin users'
new_admin_users = (1..ADMINS_TO_MAKE).collect do |i|
    user = User.new
    user.name = Faker::Name.name
    user.email = Faker::Lorem.unique.characters(20) + '@' + school.email_suffix
    user.password = Devise.friendly_token
    user.school = school
    user.admin = true
    unless user.save
        abort("Failed to save user #{user.inspect}")
    end
    user
end

puts 'Making normal users'
new_normal_users = (1..NORMAL_USERS_TO_MAKE).collect do |i|
    user = User.new
    user.name = Faker::Name.name
    user.email = Faker::Lorem.unique.characters(20) + '@' + school.email_suffix
    user.password = Devise.friendly_token
    user.school = school
    unless user.save
        abort("Failed to save user #{user.inspect}")
    end
    user
end

new_users = new_admin_users + new_normal_users

puts 'Making posts'
new_posts = (1..POSTS_TO_MAKE).collect do |i|
    post = Post.new
    post.user = new_users.sample # random new user for each post
    post.school = school
    post.message = Faker::Lorem.paragraph(2, true, 4) 
    post.created_at = Faker::Time.backward(365)
    post.status = STATUS_WEIGHTS.max_by { |_, weight| rand ** (1.0 / weight) }.first # weighted random choice
    unless post.save
        abort("Failed to save post #{post.inspect}")
    end
    post
end

puts 'Making likes and comments'
new_users.each do |user|
    # Randomly choose posts to like
    new_posts.sample(PROB_OF_LIKING * POSTS_TO_MAKE).each do |post|
        like = Like.new
        like.user = user
        like.post = post
        like.created_at = Faker::Time.backward(365)
        like.save
    end
    
    # Randomly choose comments to like
    new_posts.sample(PROB_OF_COMMENTING * POSTS_TO_MAKE).each do |post|
        comment = Comment.new
        comment.user = user
        comment.post = post
        comment.message = Faker::Lorem.paragraph(1, true, 2)
        comment.created_at = Faker::Time.backward(365)
        comment.save
    end
end

puts "Successfully added #{POSTS_TO_MAKE} posts"