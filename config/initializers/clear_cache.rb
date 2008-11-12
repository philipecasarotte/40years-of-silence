require 'active_record'

module ClearCacheHelper
	def clear_all_caches
		# DO NOT CHANGE THIS FUNCTION TO SELECTIVELY
		# CLEAR THE CACHE - this function must exist
		# and clear the WHOLE cache
		Dir.chdir(File.join(RAILS_ROOT, "public")) do
			Dir.glob(File.join('**', '*.html')) do |dir|
				begin
					if ! dir.match(/(^[0-9]{3}\.html$|^javascripts)/)
						yield(dir) if block_given?
						File.unlink(dir)
					end
				rescue
					logger.warn "Could not delete cached file #{dir}"
				end
			end
		end
	end
end

ActiveRecord::Base.class_eval do
	include ClearCacheHelper
	alias_method :old_create_or_update, :create_or_update

	def create_or_update
		# should use a smarter way instead of clearing the whole cache
		# for every update
		clear_all_caches
		old_create_or_update
	end
end
