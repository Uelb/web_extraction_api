require 'rufus/scheduler'

scheduler = Rufus::Scheduler.new
scheduler.every '1h' do 
  Website.update_items
  Item.generate_links
end