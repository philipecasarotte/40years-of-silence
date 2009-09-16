class GalleriesController < ApplicationController
  def index
    first_gallery = Album.first
    if first_gallery
      redirect_to gallery_path(first_gallery.permalink)
    else
      redirect_to root_path
    end
  end
  
  def show
    @galleries = Album.with_images
    @gallery = Album.find_by_permalink(params[:id])
    @photos = @gallery.photos.all(:order => "position ASC, id DESC")
  end
end
