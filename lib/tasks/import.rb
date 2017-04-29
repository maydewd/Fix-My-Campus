# Import data from lib/assets/schools.json file
schools_filename = Rails.root.join('lib', 'assets', 'schools.json')
schools_file = File.read(schools_filename)
schools = JSON.parse(schools_file)

schools.each do |school| 
    # Create or update each school
    s = School.find_or_initialize_by(seed_id: school['seed_id'])
    s.name = school['name']
    s.nickname = school['nickname']
    s.email_suffix = school['email_suffix']
    s.background_color = school['background_color']
    s.text_color = school['text_color']
    unless s.save
        abort("Failed to save school #{s.inspect}")
    end
    # Clear existing admins for this school
    s.admins.each do |user|
        user.admin = false
        unless user.save
            abort("Failed to clear admin user #{user.inspect}")
        end
    end
    # Create or update each admin for this school
    school['admins'].each do |email|
        u = User.find_or_initialize_by(email: email)
        if u.new_record? 
            u.password = email
        end
        u.school = s
        u.admin = true
        unless u.save
            abort("Failed to save admin user #{u.inspect}")
        end
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
        unless data['message'].nil?
            p = Post.find_or_initialize_by(legacy_fbid: fbid)
            p.message = data['message']
            p.legacy_user_name = data['from_name']
            p.legacy_numlikes = data['numlikes']
            p.created_at = data['created_time']
            p.school = school
            p.legacy = true
            unless p.save
                abort("Failed to save post #{p.inspect}")
            end
        end
    end
end

puts "Done importing #{posts.sum {|k,v| v.length}} posts."

