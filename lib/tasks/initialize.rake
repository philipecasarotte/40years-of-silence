def ask_user(question, default = nil, hide_typing = false)
	$stdout.sync = true
	$stdout.write("#{question}: #{"[#{default}]" if default}")
	`stty -echo` if hide_typing
	ret = $stdin.gets.chomp
	if hide_typing
		`stty echo`
		puts ''
	end
	return ret == '' ? default : ret
end

namespace :db do
	desc 'Creates a default user and the default infopages'
	task :populate => :environment do
		$stdout.sync = true
		
		user = ask_user('Default Admin Username')
		if user
			pass = pass2 = nil
			while (pass.nil? || pass == '' || pass != pass2)
				pass = ask_user('Default Admin\'s Password', nil, true)
				pass2 = ask_user('Confirm Admin\'s Password', nil, true)
				puts "Passwords don't match" if pass != pass2
			end
			email = ask_user('Default Admin\'s E-mail', 'abc@def.com')
			if User.find_by_login(user)
				puts "Warn: User #{user} already exists"
			else
				User.create!(:login => user, :password => pass, :password_confirmation => pass, :email => email, :admin => true)
			end
		else
			puts "Skipping creation of Admin User"
		end
		
		[
			Page.new(:title => 'Page Not Found', :permalink => 'page-not-found', :body => 'The page you are looking for was not found: %params[old_permalink]%.'),
			Page.new(:title => 'Contact', :permalink => 'contact', :body => 'Send a message to %const[SITE_NAME]%\'s staff.'),
			Page.new(:title => 'Message Sent', :permalink => 'message-sent', :body => 'Your message was sent and we will reply soon. Thanks for the contact.'),
		].each do |page|
			if Page.find_by_permalink(page.permalink)
				puts "Warn: Page #{page.title} (#{page.permalink}) already exists."
			else
				page.save!
			end
		end
		puts "Database populated."
	end
	
end
