class LettersController < ApplicationController

  before_filter :require_user

  layout 'admin'
  # layout 'verwaltung'
  
  def index
    @letters = Letter.all
  end
  
  def show
    @letter = Letter.find(params[:id])
  end
  
  def new
    @letter = Letter.new
  end
  
  def create
    @letter = Letter.new(params[:letter])
    if @letter.save
      flash[:notice] = "Successfully created letter."
      redirect_to @letter
    else
      render :action => 'new'
    end
  end
  
  def edit
    @letter = Letter.find(params[:id])
  end
  
  def update
    @letter = Letter.find(params[:id])
    if @letter.update_attributes(params[:letter])
      flash[:notice] = "Successfully updated letter."
      redirect_to @letter
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @letter = Letter.find(params[:id])
    @letter.destroy
    flash[:notice] = "Successfully destroyed letter."
    redirect_to letters_url
  end
end
