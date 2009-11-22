ActionController::Routing::Routes.draw do |map|

  map.resources :posts, :as => 'aktuelles'
  map.resources :projects, :as => "projekte", :controller => 'posts'
  map.resources :pages
  map.resource :home
  map.devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout' }
  
  map.admin '/admin', :controller => 'admin/dashboards', :action => 'show'
  map.namespace :admin do |admin|
    
    admin.preview_new_page '/pages/preview', :controller => 'pages', :action => 'preview'
    admin.resources :pages, :member => { :preview => :post }

    admin.preview_new_post '/posts/preview', :controller => 'posts', :action => 'preview'
    admin.resources :posts, :member => { :preview => :post }
    
    admin.resource :dashboard
    
    admin.root :controller => "admin/dashboards", :action => 'show'
  end
  
  map.root :controller => "homes", :action => 'show'
  
end
