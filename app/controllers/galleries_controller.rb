class GalleriesController < ApplicationController
  def show
    begin
      @gallery = Album.find(params[:id])
    rescue
      @gallery = Album.first
    end
    
    @photo = @gallery.photos.first
    
    @photos = @gallery.photos.paginate :per_page=>8, :page=>params[:page], :conditions=>["id != ?", @photo]
    
    @galleries = Album.all
  end
end
