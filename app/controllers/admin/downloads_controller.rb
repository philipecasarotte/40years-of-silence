class Admin::DownloadsController < Admin::AdminController
  include Order
  
  create.wants.html { redirect_to :action=>:index }
  update.wants.html { redirect_to :action=>:index }
end
