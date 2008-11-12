class Album < ActiveRecord::Base
  has_many :photos, 
           :order=>'position',
           :dependent=>:destroy
  
  acts_as_list
  
  has_permalink :title
end
