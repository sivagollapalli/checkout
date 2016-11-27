Rails.application.routes.draw do
  namespace :admin do
    resources :promocodes
    resources :items
  end
  resources :orders do
    collection do
      post 'add_items' 
      post 'checkout'
    end
  end

  resources :customers

  root 'orders#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
