Rails.application.routes.draw do
  mount ActionCable.server => '/cable'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post '/signin', to: 'authentication#signin'
  delete '/logout', to: 'authentication#logout'
  root to: 'home#index'
end
