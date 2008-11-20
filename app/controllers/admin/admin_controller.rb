class Admin::AdminController < ResourceController::Base
  
  include AuthenticatedSystem

	layout 'admin'
	before_filter :login_required, :is_admin?
	
	def access_denied
		redirect_to new_admin_session_path
	end
	
	def is_admin?
    access_denied unless current_user && current_user.administrator?
	end
	
end
