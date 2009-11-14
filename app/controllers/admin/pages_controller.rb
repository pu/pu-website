class Admin::PagesController < ApplicationController
  
  before_filter :require_user
  
  layout 'admin'
  
  filter_access_to :all, :require => :manage
  #filter_access_to :preview, :require => :create
    
  def index
    @pages = Page.find(:all)

    respond_to do |format|
      format.html
      format.xml  { render :xml => @pages }
    end
  end

  def new
    @page = Page.new

    respond_to do |format|
      format.html
      format.xml  { render :xml => @page }
    end
  end

  def edit
    @page = Page.find(params[:id])
  end

  def create
    @page = Page.new(params[:page])

    respond_to do |format|
      if @page.save
        flash[:success] = 'Page was successfully created.'
        format.html { redirect_to admin_pages_path }
        format.xml  { render :xml => @page, :status => :created, :location => @page }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @page = Page.find(params[:id])
    
    respond_to do |format|
      if @page.update_attributes(params[:page])
        flash[:success] = 'Page was successfully updated.'
        format.html { redirect_to admin_pages_path }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @page.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @page = Page.find(params[:id])
    @page.destroy

    respond_to do |format|
      format.html { redirect_to admin_pages_path }
      format.xml  { head :ok }
    end
  end
  
  def preview
    @preview = params[:data]
    
    respond_to do |format|
      format.js { render :layout => false }
    end
  end
end
