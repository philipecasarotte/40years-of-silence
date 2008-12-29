require File.dirname(__FILE__) + '/../test_helper'
require 'downloads_controller'

# Re-raise errors caught by the controller.
class DownloadsController; def rescue_action(e) raise e end; end

class DownloadsControllerTest < Test::Unit::TestCase
  def setup
    @controller           = DownloadsController.new
    @request              = ActionController::TestRequest.new
    @response             = ActionController::TestResponse.new
    @download = downloads :one
  end

  should_be_restful do |resource|
    resource.formats = [:html]
  end

end
