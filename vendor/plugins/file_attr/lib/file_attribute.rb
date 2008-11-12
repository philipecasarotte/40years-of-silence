require 'ftools'
require 'fileutils'

class Object
  def deep_clone
    Marshal::load(Marshal.dump(self))
  end
end

class FileAttribute < ActiveRecord::Base
	belongs_to :file_attributable, :polymorphic => true
	after_save :commit_file, :process!
	before_destroy :delete_file
	attr_reader :obj, :args, :processor
	
	DEFAULT_ARGS = {
		:local => {
			:root => File.join(RAILS_ROOT, 'public/uploads/:model'),
			:record => ':id',
			:file => ':attribute.:ext'
		}.freeze,
		:remote => {
			:root => '/uploads/:model',
			:record => ':id',
			:file => ':attribute.:ext'
		}.freeze
	}.freeze
	
	def self.delete_record_dir(obj)
		obj.class.file_attribute_args.each do |k, v|
			obj.send(k).destroy if obj.send(k)
			args = v[:local].dup
			args[:file] = nil
			FileUtils.rm_rf(parse_file_name(obj, args, k, '')) rescue nil
		end
	end
	
	def setup(*args)
		@obj = args[0]
		raise "Trying to setup for a nil object" if @obj.nil?
		write_attribute(:attribute_name, args[1].to_s)
		args = @obj.class.file_attribute_args[attribute_name.to_sym]
		@args = DEFAULT_ARGS.deep_clone
		args ||= {}
		@args[:local].merge!(args[:local]) if args[:local].is_a?(Hash)
		@args[:remote].merge!(args[:remote]) if args[:remote].is_a?(Hash)
		@args[:remote] = nil if args[:remote].nil?
		@args[:processor] = args[:processor] || nil
		@processor = nil
		logger.info ("[File Attribute #{sprintf('0x%08x', self.object_id)}] Setting up for #{@obj.class}##{attribute_name} with args #{@args.inspect}")
		if @args[:processor]
			processor, args = @args[:processor]
			processor = processor.to_s
			logger.info ("[File Attribute] Setting up processor #{processor} for #{@obj.class}##{attribute_name} with args #{args.inspect}")
			require File.join(File.dirname(__FILE__), "processors", processor)
			@processor = eval("#{processor.camelize}Processor").dup.new(self, attribute_name, args)
		end
	end
	
	def after_find
		setup(file_attributable, attribute_name)
	end
	
	def file= file
		@file = file
		write_attribute(:serial, serial + 1)
		write_attribute(:file_name, @file.original_filename)
		write_attribute(:file_size, @file.size)
		logger.info("[File Attribute #{sprintf('0x%08x', self.object_id)}] New file attached.")
	end
	
	# this function saves the attached file
	def commit_file
		logger.info("[File Attribute #{sprintf('0x%08x', self.object_id)}] Committing file for #{@obj.class}(#{@obj.id}).#{attribute_name} ...")
		if @file
			logger.info("[File Attribute] Saving file #{local_file_name} ...")
			@file.rewind if @file.respond_to?(:rewind)
			File.makedirs(File.dirname(local_file_name))
			File.open(local_file_name, "w") do |f|
				f.write(@file.read)
			end
			logger.info("[File Attribute] Done.")
		else
			logger.info("[File Attribute] Skipping file save of #{@file.inspect}.")
		end
		true
	end
	
	def process!
		@processor.after_save if @processor && @processor.respond_to?(:after_save)
		true
	end
	
	def delete_file
		logger.info("[File Attribute #{sprintf('0x%08x', self.object_id)}] Destroying self.")
		File.unlink(local_file_name) rescue nil
	end
	
	def local_file_name
		parse_file_name(@args[:local])
	end
	
	def remote_file_name
		raise "No remote path available" if @args[:remote].nil?
		parse_file_name(@args[:remote])
	end
	alias_method :path, :remote_file_name
		
	def parse_file_name(args)
		raise 'No file was given' if file_name.nil?
		FileAttribute.parse_file_name(@obj, args, attribute_name, file_name)
	end
	
	def method_missing(method, *args)
		if @processor #&& @processor.respond_to?(method)
			return @processor.send(method, *args)
		else
			super
		end
	end
	
	def self.parse_file_name(obj, args, attribute_name, file_name)
		args = args.dup
		args.delete(:file) unless args[:file]
		p = File.join(args[:root], args[:record])
		p = File.join(p, args[:file]) if args[:file]
		p.gsub(/\:([a-z0-9_]+)/) do
			case $1
				when 'model'
					obj.class.to_s.underscore
				when 'id'
					obj.id.to_s
				when 'attribute'
					attribute_name.to_s
				when 'basename'
					file_name.gsub(/\.[^\.]+$/, "")
				when 'ext'
					file_name.gsub(/^(.*?)(\.([^\.]+)){0,1}$/, "\\3")
				when 'filename'
					file_name
				else
					":#{$1}"
			end
		end
	end

end
