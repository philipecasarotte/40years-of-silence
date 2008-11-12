require 'test_helper'

class PageTest < ActiveSupport::TestCase

  fixtures :all

  should_require_attributes :title
  should_have_and_belong_to_many :parents, :children
  should_have_class_methods :root_pages
  
  context "Given a title" do

    context "(original)" do
      setup { @page = Page.create(:title => "My String"); @page.save! }

      should "generate permalink" do
        assert_equal "my-string", @page.permalink
      end  
    end
    
    context "(repeated)" do
      setup do
        @page = Page.create(:title => "MyString")
        @page.save!
        @page2 = Page.create(:title => "MyString")
        @page2.save!
      end

      should "generate permalink" do
        assert_equal "mystring_0", @page2.permalink
      end  
    end

  end

  should_eventually "validate parents and children" do
    
  end
  

end
