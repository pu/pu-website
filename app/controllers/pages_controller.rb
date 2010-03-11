class PagesController < ApplicationController
  
  def show
    # page = params[:id].capitalize
    # @page = Page.find_by_title(page)
    # raise "id raise: #{params[:id]}"
    @page = Page.find_by_title(params[:id])
    page_title(@page.title) if @page
  end
end
