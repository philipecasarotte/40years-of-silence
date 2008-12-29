class PressesController < ApplicationController
  def index
    @presses = Press.all
  end
  
  def show
    @press = Press.find(params[:id])
  end
end
