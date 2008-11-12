# Checks if the database is populated - except for testing enviroment
unless $0.include?('rake') || RAILS_ENV=='test'
	raise "No admin user was found! Please, run 'rake db:populate'. " if !User.first(:conditions => {:admin => true})
	raise "The 'Page Not Found' page was not found (no, not kidding)! Please, run 'rake db:populate'. " if !Page.find_by_permalink('page-not-found')
end
