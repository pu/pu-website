class PagesController < ApplicationController
  
  def show
    @page = Page.find_by_seo_title(params[:id])
    
    render
  end
end
