require File.join(RAILS_ROOT, 'lib/meta_data.rb')

class ActiveRecord::Base
	include MetaData::Model
end

