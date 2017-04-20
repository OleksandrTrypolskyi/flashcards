desc "This task is called by the Heroku scheduler add-on"
task :send_notification => :environment do
  puts "Sending notifications..."
  User.cards_notification_email
  puts "done."
end
