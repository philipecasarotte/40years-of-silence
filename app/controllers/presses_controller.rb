class PressesController < ApplicationController
  def index
    @presses = Press.all
    @downloads = Download.all
  end
  
  def show
    @press = Press.find(params[:id])
  end
end
