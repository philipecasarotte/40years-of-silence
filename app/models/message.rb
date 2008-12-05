class Message < ActiveRecord::Base
  include Bagpipes::Models::Message
  validates_presence_of :title
end