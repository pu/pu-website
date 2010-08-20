ActionController::Routing::Routes.draw do |map|

  map.resources :parentships, :path_prefix => "verwaltung", :as => "patenschaften"
  map.resources :kids, :path_prefix => "verwaltung", :as => "kinder", :member => {:send_profile => :post}

  map.kids_without_letter '/verwaltung/kinder_ohne_brief', :controller => 'kids', :action => 'kids_without_letters'
  map.kids_without_parent '/verwaltung/kinder_ohne_paten', :controller => 'kids', :action => 'kids_without_parents'

  map.resources :parents, :path_prefix => "verwaltung", :as => "paten", :collection => {:address_index => :get}
  map.resources :schools, :path_prefix => "verwaltung", :as => "schulen"
  map.resources :letters, :path_prefix => "verwaltung", :as => "kinderbriefe"
  map.resources :newsletters, :path_prefix => "verwaltung", :as => "newsletter", :member => {:send_to_all_parents => :post, :send_test => :post}

  map.letter_received "/verwaltung/kinder/brief_erhalten/:letter_id", :controller => 'letters', :action => "toggle_letter_received", :method => :put

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
    # admin.resources :users

    admin.root :controller => "admin/dashboards", :action => 'show'
  end

  map.root :controller => "homes", :action => 'show'

end
