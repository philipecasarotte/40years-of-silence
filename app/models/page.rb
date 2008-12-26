class Page < ActiveRecord::Base
  
  before_create :make_permalink

  has_and_belongs_to_many :parents, :class_name => "Page", :join_table => "pages_parents", :association_foreign_key => "parent_id", :foreign_key => "page_id"
  has_and_belongs_to_many :children, :class_name => "Page", :join_table => "pages_parents", :association_foreign_key => "page_id", :foreign_key => "parent_id", :order => "title"
  has_meta_data
  
  validates_presence_of :title
  
  def validate
		parents.each do |parent|
			self.errors.add :parents, "#{parent.title} can't be a parent of #{self.title}" unless self.can_be_child_of?(parent)
		end
  end
  
	def make_permalink
		orig_permalink = self.title.downcase.gsub(/[^a-z0-9_]/, '-')
		self.permalink = orig_permalink
		p = Page.find_by_permalink(self.permalink)
		n = 0
		while p
			self.permalink = "#{orig_permalink}_#{n}"
			p = Page.find_by_permalink(self.permalink)
			n += 1
		end
	end
  
  
	def can_be_child_of?(p)
		if self == p
			return false
		elsif self.children.include?(p)
			return false
		else
			self.children.each do |child|
				if !child.can_be_child_of?(p)
					return false
					break
				end
			end
			return true
		end
	end

	def self.root_pages
		r = []
		Page.find(:all, :include => [:parents, :children]).each do |page|
			r << page if page.parents == []
		end
		r
	end
end
