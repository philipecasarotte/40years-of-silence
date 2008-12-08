class Admin::UsersController < Admin::AdminController
  
  protected
  def collection
    @collection = User.all :conditions=>["type is null"]
  end
end
