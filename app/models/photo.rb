class Photo < ActiveRecord::Base
  belongs_to :album, :counter_cache=>true
  acts_as_list :scope=>'album_id'
  
  has_attached_file :image, :styles => { :medium => "417x314>", 
                                         :thumb => "76x57#",
                                         :big => "410x315>" }
end
