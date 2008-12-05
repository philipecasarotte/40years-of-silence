class TopicsController < ApplicationController
  include Bagpipes::Controllers::TopicsController

  before_filter :store_location
  
  layout 'application'
end