Rails.application.routes.draw do
  get 'sessions/new'
  post 'sessions/create'
  get 'photos/index'
  get 'photos/new'
  post 'photos/create'

  delete '/logout',  to: 'sessions#destroy'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
