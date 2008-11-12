require File.dirname(__FILE__) + '/../test_helper'
require 'photos_controller'

# Re-raise errors caught by the controller.
class PhotosController; def rescue_action(e) raise e end; end

class PhotosControllerTest < Test::Unit::TestCase
  def setup
    @controller           = PhotosController.new
    @request              = ActionController::TestRequest.new
    @response             = ActionController::TestResponse.new
    @photo = photos :one
  end

  should_be_restful do |resource|
    resource.formats = [:html]
  end

end
