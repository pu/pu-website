class PagesController < ApplicationController

  caches_page :show
  
  def show
    page = params[:id].capitalize
    @page = Page.find_by_title(page)
  end
end
