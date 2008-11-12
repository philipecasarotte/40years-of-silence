task :update_images => :environment do
  Photo.all.each do |photo|
    photo.update_attribute(:updated_at, Time.now)
  end
end