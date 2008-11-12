module MetaData::Model

	class << self
		def included base
			base.extend ClassMethods
		end
	end

	module ClassMethods
		def has_meta_data
			has_one :meta_data, :as => :meta, :dependent => :destroy
			before_save :make_meta_data
			after_save :save_meta_data
			# setup the metadata record
			define_method(:make_meta_data) do
				m = self.meta_data
				if m.nil?
					m = MetaData.new
					self.meta_data = m
				end
				m.attributes = {:title => @meta_title, :keywords => @meta_keywords, :description => @meta_description}
			end
			define_method(:save_meta_data) do
				self.meta_data.save!
			end
			# need virtual attributes since there is no column for them in this model's table
			attr_writer :meta_title, :meta_keywords, :meta_description
			%w(title keywords description).each do |k|
				eval("define_method(:meta_#{k}) do ; self.meta_data.nil? ? '' : self.meta_data.#{k} ; end")
			end
		end
	end
end

