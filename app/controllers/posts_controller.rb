class PostsController < ApplicationController
  
  def show
    @post = Post.find(params[:id])
    page_title(@post.title) if @post
    
    render
  end
  
  def index
    
    case request.request_uri
    when '/projekte'
      category = 'Projekte'
    else
      category = 'Aktuelles'
    end
    
    page_title category
    @posts = Post.category_name_is(category)
    
    render
  end
  
end
