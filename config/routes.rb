Rails.application.routes.draw do
  root 'welcome#index'
  
  resources :schools, param: :nickname, only: [:index, :show] do
      get 'stats', action: :stats, on: :member
  end
  
  resources :posts, except: :index do
      post 'like', action: :like, on: :member
      post 'unlike', action: :unlike, on: :member
      post 'status/:status_name', action: :status, on: :member, as: 'set_status'
      resources :comments, shallow: true, only: [:create, :destroy]
  end
  
  get 'users/:user_id/posts', to: 'posts#user', as: 'posts_for_user'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
