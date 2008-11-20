class Admin::AdminController < ResourceController::Base
  
  include AuthenticatedSystem

	layout 'admin'
	before_filter :login_required, :is_administrator?
	
	def access_denied
		redirect_to new_admin_session_path
	end
	
	def is_administrator?
	  access_denied unless current_user && current_user.administrator?
	end
	
end
