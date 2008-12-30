class Press < ActiveRecord::Base                    
  has_attached_file :cover,
                    :styles => {:image => "200x", :thumb => "76x58#"},
                    :path => ":rails_root/public/uploads/:class/:id/:style_:basename.:extension",
                    :url => "/uploads/:class/:id/:style_:basename.:extension",
                    :default_url => ""
end
