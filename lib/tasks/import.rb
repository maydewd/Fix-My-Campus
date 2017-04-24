# Import data from lib/assets/schools.json file
schools_filename = Rails.root.join('lib', 'assets', 'schools.json')
schools_file = File.read(schools_filename)
schools = JSON.parse(schools_file)

schools.each do |school| 
    # Create or update each school
    s = School.find_or_initialize_by(seed_id: school['seed_id'])
    s.name = school['name']
    s.nickname = school['nickname']
    s.email_prefix = school['email_prefix']
    s.save
    # Clear existing admins for this school
    s.admins.each do |user|
        user.admin = false
        user.save
    end
    # Create or update each admin for this school
    school['admins'].each do |email|
        u = User.find_or_initialize_by(email: email)
        if u.new_record? 
            u.password = email
        end
        u.school = s
        u.admin = true
        u.save
    end
end

puts "Done importing #{schools.length} schools."

# Import data from lib/assets/posts.json file
posts_filename = Rails.root.join('lib', 'assets', 'posts.json')
posts_file = File.read(posts_filename)
posts = JSON.parse(posts_file)

# Add posts for each school
posts.each do |school_seed_id, school_posts|
    school = School.find_by!(seed_id: school_seed_id)
    # Create or update each post
    school_posts.each do |fbid, data|
        p = Post.find_or_initialize_by(legacy_fbid: fbid)
        p.message = data['message']
        p.legacy_user_name = data['from_name']
        p.legacy_numlikes = data['numlikes']
        p.created_at = data['created_time']
        p.school = school
        p.legacy = true
        p.save
    end
end

puts "Done importing #{posts.sum {|k,v| v.length}} posts."

