class PostsController < ApplicationController
  
  def show
    @post = Post.visible.find(params[:id])
    
    render
  end
  
  def index
    
    case request.request_uri
    when '/projekte'
      category = 'Projekte'
    else
      category = 'Aktuelles'
    end
    
    @posts = Post.category_name_is(category).visible.ordered
    
    render
  end
  
end
