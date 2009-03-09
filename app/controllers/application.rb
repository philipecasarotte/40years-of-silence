# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

old_verbose = $VERBOSE
$VERBOSE = nil

SITE_NAME = '40 Years of Silence | Elemental Productions'
SITE_DOMAIN = '40yearsofsilence.com'
SITE_URL = "http://www.#{SITE_DOMAIN}/"
SITE_EMAIL = "contact@#{SITE_DOMAIN}"
SITE_META_KEYWORDS = ""

$VERBOSE = old_verbose

class ApplicationController < ActionController::Base
  # include AuthenticatedSystem

  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  # protect_from_forgery  :secret => '4f3aa09464759b950e3f6e1e141a4df7'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
end
