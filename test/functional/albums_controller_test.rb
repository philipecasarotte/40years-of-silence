require File.dirname(__FILE__) + '/../test_helper'
require 'albums_controller'

# Re-raise errors caught by the controller.
class AlbumsController; def rescue_action(e) raise e end; end

class AlbumsControllerTest < Test::Unit::TestCase
  def setup
    @controller           = AlbumsController.new
    @request              = ActionController::TestRequest.new
    @response             = ActionController::TestResponse.new
    @album = albums :one
  end

  should_be_restful do |resource|
    resource.formats = [:html]
  end

end
