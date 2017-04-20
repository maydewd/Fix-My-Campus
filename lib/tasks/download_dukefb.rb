require 'net/http'
require 'uri'

# Facebook Group ID for Duke Fix My Campus group (open to all Duke students)
GROUP_ID = 347519535355326
LIMIT = 250
FIELDS = 'message,from,created_time,likes.limit(1).summary(true)'
POSTS_FILENAME = 'posts.json'
DUKE_SEEDID = 1 # As defined in the schools.json file

puts '*YOU MUST BE A MEMBER OF THE DUKE FIX MY CAMPUS FACEBOOK PAGE TO COMPLETE THE FOLLOWING STEPS!*'
puts '1. Navigate to https://developers.facebook.com/tools/explorer/'
puts '2. Click "Get Token" then "Get User Access Token". Check the box named "user_managed_groups" then click "Get Access Token"'
puts '3. Copy the resulting Access Token to your clipboard, and paste it below:'

# Read in API Key from user terminal
user_key = gets.chomp

uri = URI("https://graph.facebook.com/v2.9/#{GROUP_ID}/feed")
params = { :access_token => user_key, :limit => LIMIT, :fields => FIELDS }
uri.query = URI.encode_www_form(params)

res = Net::HTTP.get_response(uri)
# Save API results to file
if res.is_a?(Net::HTTPSuccess)
    posts_filepath = Rails.root.join('lib', 'assets', POSTS_FILENAME)
    # Check if there is already existing post data, and if so, add to it
    if File.exist?(posts_filepath)
        posts = JSON.parse(File.read(posts_filepath))
    else
        posts = Hash.new
    end
    duke_posts = posts[DUKE_SEEDID] || Hash.new
    # Add or update each post for this school
    JSON.parse(res.body)['data'].each do |post|
        cleaned_post = {
            :message => post['message'],
            :created_time => post['created_time'],
            :from_name => post['from']['name'],
            :numlikes => post['likes']['summary']['total_count']
        }
        duke_posts[post['id']] = cleaned_post
    end
    posts[DUKE_SEEDID.to_s] = duke_posts
    # Write out updated post data
    puts posts.size
    File.write(posts_filepath, JSON.pretty_generate(posts))
    puts "Successfully wrote to posts file. # schools= #{posts.size}, # total posts = #{posts.sum {|k,v| v.length}}"
else
    puts 'Error retreiving posts from Facebook API'
end
