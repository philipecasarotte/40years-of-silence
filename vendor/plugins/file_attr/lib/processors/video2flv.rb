require File.join(File.dirname(__FILE__), "../image_resize")
require 'rvideo'

class Video2flvProcessor
	def initialize(file_attr, attribute, args)
		@file_attr = file_attr
		@attribute = attribute
		@args = args
		@images = []
		self.class.send(:define_method, "video_remote_file_name") do
			args = @file_attr.args[:remote].dup
			args[:file] = "#{@attribute}_video.flv"
			FileAttribute.parse_file_name(@file_attr.obj, args, @attribute, nil)
		end
		self.class.send(:define_method, "video_local_file_name") do
			args = @file_attr.args[:local].dup
			args[:file] = "#{@attribute}_video.flv"
			FileAttribute.parse_file_name(@file_attr.obj, args, @attribute, nil)
		end
		self.class.send(:alias_method, "video_path", "video_remote_file_name")
		self.class.send(:define_method, "status_file") do
			args = @file_attr.args[:local].dup
			args[:file] = "#{@attribute}_video_status.txt"
			FileAttribute.parse_file_name(@file_attr.obj, args, @attribute, nil)
		end
		self.class.send(:define_method, "status") do
			File.read(status_file) rescue 'Not available'
		end
		self.class.send(:define_method, "ready?") do
			status == 'Ready'
		end
		if args[:images]
			self.class.send(:define_method, "local_screenshot") do
				args = @file_attr.args[:local].dup
				args[:file] = "#{@attribute}_screenshot.jpg"
				FileAttribute.parse_file_name(@file_attr.obj, args, @attribute, nil)
			end
			self.class.send(:define_method, "remote_screenshot") do
				args = @file_attr.args[:remote].dup
				args[:file] = "#{@attribute}_screenshot.jpg"
				FileAttribute.parse_file_name(@file_attr.obj, args, @attribute, nil)
			end
			args[:images].each_pair do |k, str|
				v = ImageResize.process_image_string(str)
				if v.nil?
					raise "Could not parse image resizing string #{str.inspect}  (defined for #{@file_attr.obj.class}.#{@attribute})"
				end
				v[:name] = "image_#{k}".to_sym
				@images << v
				self.class.send(:define_method, "#{v[:name]}_width") do
					width = 0
					@images.each do |image|
						width = image[:width] if image[:name] == v[:name]
					end
					width
				end
				self.class.send(:define_method, "#{v[:name]}_height") do
					height = 0
					@images.each do |image|
						height = image[:height] if image[:name] == v[:name]
					end
					height
				end
				self.class.send(:define_method, "#{v[:name]}_remote_file_name") do
					args = @file_attr.args[:remote].dup
					args[:file] = "#{@attribute}_#{v[:name]}.jpg"
					FileAttribute.parse_file_name(@file_attr.obj, args, @attribute, nil)
				end
				self.class.send(:define_method, "#{v[:name]}_local_file_name") do
					args = @file_attr.args[:local].dup
					args[:file] = "#{@attribute}_#{v[:name]}.jpg"
					FileAttribute.parse_file_name(@file_attr.obj, args, @attribute, nil)
				end
				self.class.send(:alias_method, "#{v[:name]}_path", "#{v[:name]}_remote_file_name")
			end
		end
		self.class.send(:attr_reader, :args)
	end
	
	def after_save
		args = @file_attr.args[:local].dup
		args[:file] = "#{@attribute}_video_status.txt"
		f = FileAttribute.parse_file_name(@file_attr.obj, args, @attribute, nil)
		File.open(f, 'w') do |file|
			file.write('On Queue')
		end
		MiddleMan.worker(:process_videos_worker).async_process(:arg => @file_attr.id)
	end
	
	def process_images!
		args = @file_attr.args[:local].dup
		args[:file] = "#{@attribute}_screenshot.jpg"
		o_file = FileAttribute.parse_file_name(@file_attr.obj, args, @attribute, nil)
		@images.each do |image|
			args = @file_attr.args[:local].dup
			args[:file] = "#{@attribute}_#{image[:name]}.jpg"
			file = FileAttribute.parse_file_name(@file_attr.obj, args, @attribute, nil)
			ImageResize.process_image(o_file, file, image)
		end
	end
end
