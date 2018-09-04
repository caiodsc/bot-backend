Rails.application.routes.draw do
  resources :messages, only: [:index, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/login', to: 'login#login'
  mount ActionCable.server => '/cable'
end
