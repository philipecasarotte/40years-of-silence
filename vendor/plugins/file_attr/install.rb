# Install hook code here
Dir.chdir(File.dirname(__FILE__)) do
  if (d = Dir.glob('../../../db/migrate/*create_file_attributes.rb')).size == 0
    puts "Copying migration"
    system("cp lib/migrations/create_file_attributes.rb ../../../db/migrate/#{Time.now.strftime("%Y%m%d%H%M%S")}_create_file_attributes.rb")
    puts "Done.\n\nPlease, run 'rake db:migrate' before using this plugin."
  else
    puts "Migration already exists: #{File.basename(d[0])}"
  end
end

