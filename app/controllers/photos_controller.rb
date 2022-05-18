class PhotosController < ApplicationController
  before_action :authenticate_user

  def index
    @photos = Photo.where(user_id: current_user.id).order(created_at: :desc)
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(photo_params.merge(user_id: current_user.id))
    if @photo.valid?
      @photo.save_photo!
      @photo.save!
      redirect_to photos_index_path
    else
      render 'new'
    end
  end

  private

  def photo_params
    params.require(:photo).permit(:title, :updated_file)
  end
end