class HomesController < ApplicationController
  
  def show
    
    @posts = Post.featured
    
    render
  end
end