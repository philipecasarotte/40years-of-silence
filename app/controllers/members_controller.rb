class MembersController < ApplicationController
  include Bagpipes::Controllers::MembersController
  
  before_filter :store_location
  
  layout 'application'
end