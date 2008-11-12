class MetaData < ActiveRecord::Base
	belongs_to :meta, :polymorphic => true
	
	def html_tags
		keys = []
		keys += SITE_META_KEYWORDS.split(",") unless SITE_META_KEYWORDS.blank?
		keys += keywords.split(",") unless keywords.blank?
		"<meta name='title' content='#{title}' />
		 <meta name='keywords' content='#{keys.join(',')}' />
		 <meta name='description' content='#{description}' />"
	end
end
