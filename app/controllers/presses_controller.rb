class PressesController < ApplicationController
  def show
    @presses = Press.all
  end
end
