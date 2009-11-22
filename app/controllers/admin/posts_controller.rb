class Admin::PostsController < ApplicationController

  before_filter :require_user
  
  layout 'admin'

  def index
    @posts = Post.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def create
    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to admin_posts_path }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to admin_posts_path }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @post = Post.find(params[:id])
    
    if @post.destroy
      flash[:success] = "Post was successfully deleted."
    else
      flash[:error] = "Post was not deleted."
    end

    respond_to do |format|
      format.html { redirect_to admin_posts_path }
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
