Rails.application.routes.draw do
  get 'sessions/new'
  post 'sessions/create'
  get 'photos/index'
  get 'photos/new'
  post 'photos/create'

  delete '/logout',  to: 'sessions#destroy'

  scope module: :link_accounts do
    get 'oauth/callback', to: 'my_tweet_apps#oauth_callback_for_my_tweet_app'
  end

  namespace :link_accounts do
    get 'authorize_my_tweet_app', to: 'my_tweet_apps#authorize_my_tweet_app'
    post 'post_tweet', to: 'my_tweet_apps#post_tweet'
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
