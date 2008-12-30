class Message < ActiveRecord::Base
  include Bagpipes::Models::Message
  validates_presence_of :title, :if=>Proc.new { |m| m.parent_id.nil? }
  
  named_scope :active, :conditions => {:active => true}
  named_scope :pending, :conditions => {:active => false}, :order => 'parent_id'
  
  def approve!
    update_attribute(:active, true)
  end
end