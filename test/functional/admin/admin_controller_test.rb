require File.dirname(__FILE__) + '/../../test_helper'
require 'admin/admin_controller'

class Admin::AdminControllerTest < ActionController::TestCase
  
  fixtures :users

  context "A user" do
    
    context "not logged in" do
      setup do
        logged_in = false
        get :index
      end

      should_respond_with :redirect
    end
    
  end

end
