class Admin::ImagesController < ApplicationController
  
  before_filter :require_user
    
  # def index
  #   @search = {}
  #   @search[:objects] = Image.descend_by_created_at
  #   @search[:pagination] = @search[:objects].paginate(:page => params[:page], :per_page => 50)
  #   @search[:count] = @search[:objects].count
  #   
  #   respond_to do |format|
  #     format.html { render }
  #   end
  # end
  
  def sort
    @images = Image.find(params[:image_image])
    
    @images.each do |image|
      image.position = params[:image_image].index(image.id.to_s) + 1
      image.save
    end
    render :nothing => true
  end
  
  def destroy
    @image = Image.find(params[:id])
    @image_id = @image.id
    
    @image.destroy
  
    respond_to do |format|
      format.html
      format.js { render :layout => false }
    end
  end
  
  def delete
    @asset = Image.find(params[:id])
    
    if !@asset.account.nil? and (@asset.account.profile_image.to_i == @asset.id.to_i)
      @asset.account.update_attribute( :profile_image, nil )
    end
    
    if @asset.destroy
      flash[:success] = 'Bild wurde gelöscht.'
    else
      flash[:error] = 'Bild konnte nicht gelöscht werden.'
    end
    
    redirect_to assets_path(:params => { :search => params[:search] })
  end
  
end
