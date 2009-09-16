class Photo < ActiveRecord::Base
  belongs_to :album, :counter_cache => true
  acts_as_list :scope => 'album_id'
  
  has_attached_file :image,
                    :styles => { :medium => "417x314>", :thumb => "81x61 #", :big => "482x3655>" },
                    :path => ":rails_root/public/uploads/images/:id/:style/:basename.:extension",
                    :url => "/uploads/images/:id/:style/:basename.:extension"
end
