class KidsController < ApplicationController
  
  layout 'verwaltung'

  def index
    @kids = Kid.all
  end
  
  def show
    @kid = Kid.find(params[:id])
  end
  
  def new
    @kid = Kid.new
  end
  
  def create
    @kid = Kid.new(params[:kid])
    if @kid.save
      flash[:notice] = "Successfully created kid."
      redirect_to @kid
    else
      render :action => 'new'
    end
  end
  
  def edit
    @kid = Kid.find(params[:id])
  end
  
  def update
    @kid = Kid.find(params[:id])
    if @kid.update_attributes(params[:kid])
      flash[:notice] = "Successfully updated kid."
      redirect_to @kid
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @kid = Kid.find(params[:id])
    @kid.destroy
    flash[:notice] = "Successfully destroyed kid."
    redirect_to kids_url
  end
end
