class StaffsController < ApplicationController
  def show
    @staff = Staff.find(params[:id])
    render :partial => 'body'
  end

end
