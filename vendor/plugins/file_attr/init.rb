require 'file_attribute'

module FileAttr
	class << self
		def included base
			base.extend ClassMethods
		end
	end
	
	module ClassMethods
		# User.methods
		attr_reader :file_attribute_args, :file_attribute_default_args

		def file_attribute_config(*args)
			@file_attribute_default_args ||= FileAttribute::DEFAULT_ARGS.dup
			args = args.last
			return unless args
			@file_attribute_default_args[:local].merge!(args[:local]) if args[:local]
			@file_attribute_default_args[:remote].merge!(args[:remote]) if args[:remote]
			if args.has_key(:remote) && args[:remote].nil?
				@file_attribute_default_args.delete(:remote)
			end
		end
		
		def file_attribute(attribute, *args)
			file_attribute_config # load default config
			logger.info("[File Attribute] Default args in #{base_class}: #{@file_attribute_default_args.inspect}")
			args = args.last
			args ||= {}
			filename = args[:file]
			has_one attribute, :as => :file_attributable, :class_name => 'FileAttribute', :conditions => {:attribute_name => attribute.to_s}
			@file_attribute_args ||= {}
			@file_attribute_args[attribute] ||= {}
			@file_attribute_args[attribute][:local] = @file_attribute_default_args[:local].dup
			@file_attribute_args[attribute][:remote] = @file_attribute_default_args[:remote].dup
			@file_attribute_args[attribute][:processor] = @file_attribute_default_args[:processor].dup if @file_attribute_default_args[:processor]
			if filename
				@file_attribute_args[attribute][:local].merge!(:file => filename)
				@file_attribute_args[attribute][:remote].merge!(:file => filename) if @file_attribute_args[attribute][:remote]
			end
			if args.has_key?(:processor)
				@file_attribute_args[attribute][:processor] = args[:processor]
			end
			logger.info("[File Attribute] Args for #{attribute}: #{@file_attribute_args[attribute].inspect}")
			alias_method "old_#{attribute}=", "#{attribute}="
			define_method("#{attribute}=") do |file|
				logger.info("[File Attribute] Attaching file(#{file.class}) #{file.inspect} to attribute #{attribute}")
				if !file.blank?
					self.send(attribute).destroy if self.send(attribute)
					f = FileAttribute.new
					logger.info ("[File Attribute] #{f.new_record? ? "Criado novo FileAttribute" : "Usando FileAttribute existente"}: #{sprintf('0x%08x', f.object_id)}")
					f.setup(self, attribute) if f.new_record?
					f.file = file
					self.send("old_#{attribute}=", f) if f.new_record?
				end
			end
			define_method("remove_file_attributes_folder") do
				FileAttribute.delete_record_dir(self)
			end
			before_destroy :remove_file_attributes_folder
		end
	end
end

class ActiveRecord::Base
	include FileAttr
end


