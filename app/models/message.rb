class Message < ActiveRecord::Base
  include Bagpipes::Models::Message
  validates_presence_of :title, :if=>Proc.new { |m| m.parent_id.nil? }
end