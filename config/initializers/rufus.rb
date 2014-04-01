require 'rufus/scheduler'

scheduler = Rufus::Scheduler.new
scheduler.every '1h' do 
  puts 'Updating database'
  websites = Website.where('updated_at < ?', 2.hours.from_now)
  websites.each do |website|
    centroids = website.centroids
    centroid_jsons = centroids.map do |centroid|
      [centroid.color,centroid.background_color, centroid.width, centroid.height, 
        centroid.text_decoration, centroid.font_style, centroid.left_alignment, 
        centroid.top_alignment, centroid.z_index]
    end
    centroid_jsons.map(&:to_json).each_with_index do |centroid_json, index|
      directory = Rails.root + 'public/jsons' + website.url
      File.open(directory + (centroids[index].label + '.json'), 'w') { |file| file.write(centroid_json) }
    end
  end
end