Rails.application.routes.draw do
  namespace :admin do
    resources :promocodes
    resources :items
  end
  resources :orders do
    collection do
      post 'add_items' 
      post 'checkout'
      post 'apply_promocode'
      post 'select_item'
    end

    member do
      delete 'remove_item'
      match 'payment', via: [:get, :post]
    end
  end

  resources :customers

  root 'orders#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
