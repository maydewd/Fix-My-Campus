# Final Project: Fix My Campus

### David Maydew

## Use of Application

My updated version of Fix My Campus is useful because it incorporates the existing basic functionality provided by the Facebook group and extends it with features specific to Fix My Campus. In my experience with the Fix My Campus Facebook group, there are three main shortcomings: the ability to identify which posts are important over time, tracking the status of posts, and identifying the administrators. My FMC application fixes these by allowing users to sort posts by 'trending' or 'top' based on likes, attaching a status label to each post that admins can change as appropriate, and visually highlighting admin comments. My application also provides some additional features, such as the ability to see general statistics about Fix My Campus at a given school. It also allows users (logged in or not) to **view** all posts and comments from any school. On top of all this, it presents a unified Fix My Campus experience for any partnered school. Overall, these features make the Fix My Campus experience more pleasant for students and more effective for adminstrators.

## Install instructions

The server runs on Rails 5. Installing and deploying is as usual, but there are a few additional steps to mimic the setup running on heroku.

To populate the database with initial posts (and other data), there are two separate processes

### Download and Import Duke FMC Facebook Data

As a first step, manually verify or edit the lib/assets/schools.json to contain the information of all schools to be used on the platform. Next, run `rails r lib/tasks/download_dukefb.rb` and follow the prompts to download the current posts from the Duke Fix My Campus Facebook page. **The API key to download the facebook posts is not in secrets.yml** . This was discussed with Professor Duvall, and is because the Facebook API requires personal API tokens to access group posts, and those personal API tokens expire after an hour.
Next, run `rails r lib/tasks/import.rb`. This takes all the school and post data generated in the previous steps and imports it into the database. **Note: the initial password of each admin account is its email address**. Clearly this would be changed in a secure environment with actual clients. Lastly, it should be noted that both these scripts are idempotent.

### Seed UNC fake posts

As I noted above, my FMC application provides more functionality than the Facebook group. As a result, the Duke FMC Facebook posts don't necessarily do the best job of demonstrating all the features of this website. Rather than augmenting the Duke posts with fake information, I chose to make a script that will populate a school with users, posts, likes, and comments using the Faker gem. It can be run by executing `rails r lib/tasks/seed_school.rb` (currently set to add to UNC). This script takes a while to run (~5 minutes) as it is generating a lot of randomized data and writing it to the database. An example of its output is the UNC page.

### Trending

To efficiently track the 'trending' posts, I chose to make a rake script that, when run hourly, will update the trending posts appropriately. It can be run manually at any time with `rake update_trending`. However, I also configured a [heroku scheduler add-on](https://elements.heroku.com/addons/scheduler) that runs the task on the production server every hour. 


**Warnings in command line (e.g. rails routes) from slightly outdated gem**

## Testing

103 tests covering all controllers and models. Include standard route access, actions, permissions, and validations
`rails test`

## API

Every GET route has an associated .json path, some of which require authentication. The JSON data is custom formatted for each route to ensure only the relevant fields are shown (albeit using partials to maintain DRY). I chose not to implement JSON paths for the non-GET routes since (standard) Devise doesn't support token-based, so even if a user were to fire up a HTTP Client they wouldn't be able to authenticate themselves easily.
e.g. schools.json or posts/4.json