class Admin::PostsController < ApplicationController

  before_filter :require_user
  
  layout 'admin'

  def index
    @posts = Post.find(:all, :order => 'category_id DESC, position')

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
    
    unless params[:data].blank?
      image = @post.images.build
      image.data = params[:data]
    end
    
    respond_to do |format|
      if @post.valid? and ( image ? image.valid? : true )
        
        if ( image ? image.save : true ) and @post.save
          flash[:success] = 'Artikel wurde erfolgreich erstellt.'
          
          format.html { redirect_to edit_admin_post_path(@post) }          
        else
          format.html { render :action => "new" }
        end
      else
        logger.debug "***** !!!!! Errors: " + @post.errors.inspect
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @post = Post.find(params[:id])
    @post.attributes = params[:post]
    
    unless params[:data].blank?
      image = @post.images.build
      image.data = params[:data]
    end
    
    respond_to do |format|
      if @post.valid? and ( image ? image.valid? : true )
        
        if ( image ? image.save : true ) and @post.save
          flash[:success] = 'Artikel wurde erfolgreich bearbeitet.'
          format.html { redirect_to edit_admin_post_path(@post) }
        else
          format.html { render :action => "new" }
        end
      else
        logger.debug "***** !!!!! Errors: " + @post.errors.inspect
        format.html { render :action => "new" }
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
  
  def sort
    _posts = params[:sortable_posts]
    _posts.delete_if {|key, value| key.blank? }
    
    @posts = Post.find(_posts)
    @posts.each do |post|
      post.position = _posts.index(post.id.to_s) + 1
      post.save
    end
    
    respond_to do |format|
      format.js { render :nothing => true }
    end
  end
end
