Rails.application.routes.draw do
  root 'welcome#index'
  
  resources :schools, param: :nickname, only: :show, :path => '' do
    resources :posts, shallow: true, except: :index
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
