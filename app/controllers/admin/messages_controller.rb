class Admin::MessagesController < Admin::AdminController
  update.wants.html { redirect_to :action=>:index }
  
  def approve
    @message = Message.find(params[:id])
    @message.approve!
    redirect_to :action => :index  
  end
  
  def collection
    @collection = Message.pending
  end
end