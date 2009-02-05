class PressesController < ApplicationController
  def index
    @presses = Press.all
    @downloads = Download.all
  end
  
  def show
    begin 
      @press = Press.find(params[:id])
    rescue
      redirect_to :action=>"index"
    end
  end
end
