require File.join(File.dirname(__FILE__), "../image_resize")

class ImageProcessor
	def initialize(file_attr, attribute, args)
		@file_attr = file_attr
		@attribute = attribute
		@images = []
		args.each_pair do |k, str|
			v = ImageResize.process_image_string(str)
			if v.nil?
				raise "Could not parse image resizing string #{str.inspect}  (defined for #{@file_attr.obj.class}.#{@attribute})"
			end
			v[:name] = k
			@images << v
			self.class.send(:define_method, "#{k}_width") do
				width = 0
				@images.each do |image|
					width = image[:width] if image[:name] == k
				end
				width
			end
			self.class.send(:define_method, "#{k}_height") do
				height = 0
				@images.each do |image|
					height = image[:height] if image[:name] == k
				end
				height
			end
			self.class.send(:define_method, "#{k}_remote_file_name") do
				args = @file_attr.args[:remote].dup
				args[:file] = "#{@attribute}_#{k}.jpg"
				FileAttribute.parse_file_name(@file_attr.obj, args, @attribute, nil)
			end
			self.class.send(:define_method, "#{k}_local_file_name") do
				args = @file_attr.args[:local].dup
				args[:file] = "#{@attribute}_#{k}.jpg"
				FileAttribute.parse_file_name(@file_attr.obj, args, @attribute, nil)
			end
			self.class.send(:alias_method, "#{k}_path", "#{k}_remote_file_name")
		end
	end
	
	def after_save
		o_file = @file_attr.local_file_name
		@images.each do |image|
			args = @file_attr.args[:local].dup
			args[:file] = "#{@attribute}_#{image[:name]}.jpg"
			file = FileAttribute.parse_file_name(@file_attr.obj, args, @attribute, nil)
			ImageResize.process_image(o_file, file, image)
		end
	end
end
