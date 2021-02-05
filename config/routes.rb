Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'posts#index'
  resources :posts do
    resources :comments, shallow: true, only: [:create, :destroy]
  end
  resources :users, only:[:new, :create]
  resource :session, only:[:new, :create, :destroy]
end
