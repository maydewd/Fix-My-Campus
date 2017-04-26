Rails.application.routes.draw do
  root 'welcome#index'
  
  resources :schools, param: :nickname, only: [:index, :show]
  resources :posts, except: :index do
      post 'like', action: :like, on: :member
      post 'unlike', action: :unlike, on: :member
      resources :comments, shallow: true, only: [:create, :destroy]
    end
  
  # Add custom routes for posts
  # resources :posts do
  #   post 'like', action: :like, on: :member
  #   post 'unlike', action: :unlike, on: :member
  #   # get 'my', :action => :my, :on => :collection
  # end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
