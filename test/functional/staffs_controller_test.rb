require File.dirname(__FILE__) + '/../test_helper'
require 'staffs_controller'

# Re-raise errors caught by the controller.
class StaffsController; def rescue_action(e) raise e end; end

class StaffsControllerTest < Test::Unit::TestCase
  def setup
    @controller           = StaffsController.new
    @request              = ActionController::TestRequest.new
    @response             = ActionController::TestResponse.new
    @staff = staffs :one
  end

  should_be_restful do |resource|
    resource.formats = [:html]
  end

end
