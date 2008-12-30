class Download < ActiveRecord::Base
  has_attached_file :pdf,
                    :path => ":rails_root/public/uploads/:class/:id/:style_:basename.:extension",
                    :url => "/uploads/:class/:id/:style_:basename.:extension"
  validates_attachment_presence :pdf
  validates_attachment_content_type :pdf, :content_type => 'application/pdf'
end
