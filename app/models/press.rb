class Press < ActiveRecord::Base                    
  has_attached_file :cover,
                    :styles => {:image => "200x180", :thumb => "76x58#"},
                    :path => ":rails_root/public/uploads/:class/:id/:style_:basename.:extension",
                    :url => "/uploads/:class/:id/:style_:basename.:extension"
end
