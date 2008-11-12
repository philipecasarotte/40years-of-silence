require 'RMagick'

class ImageResize
	def self.process_image_string(string)
		case string
			when /^letterbox\(([A-Za-z0-9\#]+)\)\:([0-9]+)x([0-9]+)$/
				{:method => :letterbox, :color => $1, :width => $2.to_i, :height => $3.to_i}
			when /^crop\:([0-9]+)x([0-9]+)$/
				{:method => :crop, :width => $1.to_i, :height => $2.to_i}
			else
				nil
		end
	end
	# source_image and destination_image speak for themselves
	# args is a hash with at least the :method key, which can be:
	# * :letterbox - inserts the whole image into a image with
	#                the specified :width and :height, resizing and
	#                inserting bars above and below OR on both sides
	#                of the image so as to make it fit the 'canvas'.
	#                The default bar color is black, but can be set
	#                with the :color parameter.
	# * :crop - the contrary of letterbox. While letterbox will make the
	#           image fit in its larger dimension, crop will make it fit
	#           in its smaller dimension, cropping at the larger to make
	#           the image fit the specified :width and :height.
	# Note: The image will be saved by default as a JPG with a quality of 80.
	#       Currently there is no way to set the format or the quality besides
	#       editing the code below.
	def self.process_image(source_image, destination_image, *args)
		args = args.last
		img = Magick::ImageList.new(source_image)[0]
		case args[:method]
			when :letterbox
				canvas = Magick::ImageList.new
				canvas.new_image(args[:width], args[:height]) do
					self.background_color = args[:color] || 'black'
				end
				canvas = canvas[0]
				img.resize_to_fit!(args[:width], args[:height])
				canvas.composite!(img, Magick::CenterGravity, Magick::CopyCompositeOp)
				img.destroy!
				img = canvas
			when :crop
				img.crop_resized!(args[:width], args[:height])
			else
				raise "Unknown image processing method #{args[:method]}"
		end
		img.write(destination_image) do
			self.format = 'jpg'
			self.quality = 80
		end
		img.destroy!
	end
end
