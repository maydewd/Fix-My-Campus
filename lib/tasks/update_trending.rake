desc "This task is called by the Heroku scheduler add-on"
task :update_trending => :environment do
  puts "Updating trending like counts..."
  Like.counter_culture_fix_counts
  puts "done."
end
