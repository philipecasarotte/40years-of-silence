class Press < ActiveRecord::Base
  has_attached_file :pdf
  has_attached_file :cover, :styles=>{ :thumb=>"76x58" }
end
