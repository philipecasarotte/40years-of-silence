class PhotosController < ApplicationController
  def show
    photo = params[:id].gsub(/photo_/,'')
    
    @photo = Photo.find(photo)
    
    render :layout=>false
  end

end
