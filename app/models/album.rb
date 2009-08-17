class Album < ActiveRecord::Base
  has_many :photos, 
           :order=>'position',
           :dependent=>:destroy
  
  acts_as_list
  
  has_permalink :title
  
  named_scope :with_images, :order=> "position", :conditions => ["photos_count > ?", "0"]
end
