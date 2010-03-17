class ParentsController < ApplicationController

  before_filter :authenticate_user!

  layout 'admin', :except => "address_index"
  # layout 'verwaltung'
  
  def index
    @parents = Parent.all
  end
  
  def address_index 
    @parents = Parent.find_all_by_email("")
    @parents <<  Parent.find_all_by_email(nil)
    @parents = @parents.flatten
  end
  
  def show
    @parent = Parent.find(params[:id])
  end
  
  def new
    @parent = Parent.new
  end
  
  def create
    @parent = Parent.new(params[:parent], :status => "active")
    if @parent.save
      flash[:notice] = "Successfully created parent."
      redirect_to @parent
    else
      render :action => 'new'
    end
  end
  
  def edit
    @parent = Parent.find(params[:id])
  end
  
  def update
    @parent = Parent.find(params[:id])
    if @parent.update_attributes(params[:parent])
      flash[:notice] = "Successfully updated parent."
      redirect_to @parent
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @parent = Parent.find(params[:id])
    @parent.update_attribute(:status, "deleted")
    flash[:notice] = "Successfully destroyed parent."
    redirect_to parents_url
  end
end
