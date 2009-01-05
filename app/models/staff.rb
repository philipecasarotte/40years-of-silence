class Staff < ActiveRecord::Base
  has_attached_file :image,
                    :styles => {:thumb => "61x81#"},
                    :path => ":rails_root/public/uploads/:class/:id/:style_:basename.:extension",
                    :url => "/uploads/:class/:id/:style_:basename.:extension",
                    :default_url => ""
end
