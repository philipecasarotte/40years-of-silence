require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/pages_controller'
#require 'test_helper'

class Admin::PagesControllerTest < ActionController::TestCase

  context "on GET to show" do
    setup { login_as(:quentin); get :show, :id => 1; }

    should_respond_with :success
  end
  

end
