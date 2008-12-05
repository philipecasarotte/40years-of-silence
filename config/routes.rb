ActionController::Routing::Routes.draw do |map|
  map.resources :topics, :has_many => [:messages]
  map.new_reply 'topics/:topic_id/parent/:parent_id', :controller => 'messages', :action => 'new'

  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.register '/register', :controller => 'users', :action => 'create'
  map.signup '/signup', :controller => 'users', :action => 'new'

  map.resources :presses
  map.resources :users
  
  map.namespace :admin do |admin|
    admin.logout '/logout', :controller => 'sessions', :action => 'destroy'
    admin.login '/login', :controller => 'sessions', :action => 'new'
    admin.register '/register', :controller => 'users', :action => 'create'
    admin.signup '/signup', :controller => 'users', :action => 'new'
    admin.resources :users
    admin.resources :pages
    admin.resource :session
    admin.resources :presses, :collection=>{ :order=>:post, :reorder=>:get }
    admin.resources :albums, :collection=>{ :order=>:post, :reorder=>:get } do |albums|
      albums.resources :photos, :collection=>{ :order=>:post, :reorder=>:get }
    end
    admin.root :controller => 'pages'
  end

  map.resources :photos
  map.resource :session

  map.gallery '/gallery/:id', :controller => 'galleries', :action => 'show'
  map.gallery '/press/:id', :controller => 'presses', :action => 'show'
  map.page '/page/:permalink', :controller => 'pages', :action => 'show'
  map.root :controller => 'pages', :action => 'show', :permalink => 'home'

  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end
