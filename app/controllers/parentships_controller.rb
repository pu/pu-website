class ParentshipsController < ApplicationController

  include CacheExpiryHelper

  before_filter :authenticate_user!

  layout 'admin'
  # layout 'verwaltung'

  def index
    @parentships = Parentship.find(:all)
  end

  def show
    @parentship = Parentship.find(params[:id])
  end

  def new
    @parentship = Parentship.new
    @kid = Kid.new
    @parent = Parent.new
  end

  def create
    @parentship = Parentship.new(params[:parentships])
    if @parentship.save
      flash[:notice] = "Successfully created parentship."
      redirect_to @parentship
    else
      render :action => 'new'
    end
  end

  # def new_batched
  #   @kid = Kid.new
  #   @parent = Parent.new
  #   @parentship = Parentship.new(:kid => @kid, :parent => @parent)
  # end

  def create_batched
    @kid = Kid.new(params[:kid])
    @parent = Parent.new(params[:parent])
    @parentship = Parentship.new(:kid => @kid, :parent => @parent)

    if @kid.valid? && @parent.valid? && @parentship.valid?
      @kid.save
      @parent.save
      @parentship = Parentship.create!(:kid_id => @kid.id, :parent_id => @parent.id)
      render :action => 'show', :id => @parentship.id
    else
      render :action => 'new'
    end
  end

  def edit
    @parentship = Parentship.find(params[:id])
  end

  def update
    @parentship = Parentship.find(params[:id])
    if @parentship.update_attributes(params[:parentships])
      flash[:notice] = "Successfully updated parentship."
      expire_view_cache_for_parentship(@parentship)
      redirect_to @parentship
    else
      render :action => 'edit'
    end
  end

  def destroy
    @parentship = Parentship.find(params[:id])
    @parentship.destroy
    flash[:notice] = "Successfully destroyed parentship."
    redirect_to parentships_url
  end

  def search
    @search_text = params[:search_text]
    kids = Kid.name_or_firstname_like(@search_text)
    parents = Parent.name_or_firstname_like(@search_text)

    @parentships = kids.collect{|k| k.parentships } << parents.collect{|p| p.parentships}
    @parentships.flatten!
    render :action => 'index'
  end

end
