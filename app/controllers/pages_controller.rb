class PagesController < ApplicationController

  caches_page :show
  
  def show
    # page = params[:id].capitalize
    # @page = Page.find_by_title(page)
    
    @page = Page.find(params[:id])
    page_title(@page.title) if @page    
    
    
  end
end
