class HomesController < ApplicationController
  def show
    
    @posts = Post.most_recent
    
    render
  end
end