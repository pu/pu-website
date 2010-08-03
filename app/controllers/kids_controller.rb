class KidsController < ApplicationController

  before_filter :authenticate_user!

  layout 'admin'

  def index
    @kids = Kid.find(:all, :include => [:school, :school_visit, :parents, :letters_written], :order => 'name ASC'ss)
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

      self.expire_view_cache_for(kid)

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
end

private

def expire_view_cache_for(kid)
  # This chould be model code, but conceptually it copes with views and caching
  expire_fragement(:key => "kids_row#{kid.id}")
  kid.parentships.each{|p| expire_fragment(:key => "parentships_row_#{p.id}")}
  kid.parents.each{|p| expire_fragment(:key => "parents_row_#{p.id}")}
end