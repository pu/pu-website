class KidsController < ApplicationController

  include CacheExpiryHelper

  before_filter :authenticate_user!

  layout 'admin'

  def index
    @page_title = "Alle Kinder"
    @kids = Kid.find(:all, :include => [:school, :school_visit, :parents, :letters_written], :order => 'name ASC')
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

      expire_view_cache_for_kid(@kid)

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

  def send_profile
    receiverlist = params[:email].split(",")
    @kid = Kid.find(params[:id])
    @kid.send_profile_to(receiverlist)

    flash[:notice] = "Kinderprofil wurde erfolgreich an #{receiverlist} verschickt."
    render :action => 'show'
  end

  def kids_without_letters
    @page_title = "Kinder ohne Brief"
    @kids = Kid.without_recent_letter
    render :action => 'index'
  end

  def kids_without_parents
    @page_title = "Kinder ohne Paten"
    @kids = Kid.without_parent
    render :action => 'index'
  end

end
