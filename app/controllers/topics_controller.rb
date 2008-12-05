class TopicsController < ApplicationController
  include Bagpipes::Controllers::TopicsController

  before_filter :store_location
  
  def index
    @topic = Topic.first
    render :action=>:show
  end
  
  layout 'application'
end