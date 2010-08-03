class LettersController < ApplicationController

  before_filter :authenticate_user!

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

  def toggle_letter_received
     @letter_id = params[:letter_id]
     if @letter = LettersWritten.find(@letter_id)
       @letter.update_attribute(:received, !@letter.received)

       self.expire_view_cache_for(@letter)
     end

     respond_to do |format|
       format.js {
         render :update do |page|
           page.replace_html "letter_status_#{@letter_id}", render(:partial => 'letters/letter_received', :locals => { :letter => @letter, :redirect_action => params[:redirect_action]})
         end
       }
       format.html{
         if params[:redirect_action] == 'show'
           redirect_to @letter.kid
         else
           redirect_to :action => params[:redirect_action] || :index
         end
       }
     end

   end


end


def expire_view_cache_for(letter)
  kid = letter.kid

  # we should refactor this to a helper.
  expire_fragment(:key => "kids_row#{kid.id}")
  kid.parentships.each{|p| expire_fragment(:key => "parentships_row_#{p.id}")}
  kid.parents.each{|p| expire_fragment(:key => "parents_row_#{p.id}")}
end