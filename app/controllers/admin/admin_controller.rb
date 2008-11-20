class Admin::AdminController < ResourceController::Base
  
  include AuthenticatedSystem

	layout 'admin'
	before_filter :login_required
	
	def access_denied
		redirect_to new_admin_session_path
	end
	
end
