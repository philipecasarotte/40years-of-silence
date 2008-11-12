class Admin::PhotosController < Admin::AdminController
  belongs_to :album
  include Order
  
  create.wants.html { redirect_to :action=>:index }
  update.wants.html { redirect_to :action=>:index }
end
