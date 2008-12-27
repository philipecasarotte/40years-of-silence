class GalleriesController < ApplicationController
  def show
    @gallery = Album.find_by_permalink(params[:permalink])
    @photos = @gallery.photos.all
  end
end
