Rails.application.routes.draw do
  namespace :admin do
    resources :promocodes
    resources :items
  end

  root 'orders#new'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
