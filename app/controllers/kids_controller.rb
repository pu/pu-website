class KidsController < ApplicationController
  
  before_filter :authenticate_user!
  
  layout 'admin'
  # layout 'verwaltung'

  def index
    @kids = Kid.paginate :page => params[:page], :per_page => 100 #all
  end
  
  def show
    @kid = Kid.find(params[:id])
  end
  
  def new
    @kid = Kid.new
    @kid.number = (Kid.maximum(:number) || 0) + 1
  end
  
  def create
    @kid = Kid.new(params[:kid], :status => "active")
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
    @kid.update_attribute(:status, "deleted")
    flash[:notice] = "Successfully destroyed kid."
    redirect_to kids_url
  end
  
  def toggle_letter_received
    letter_id = params[:letter_id]
    if letter = LettersWritten.find(letter_id)
      letter.update_attribute(:received, !letter.received)
    end
    
    redirect_to :action => "index"
  end
end
