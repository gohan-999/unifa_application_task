module LinkAccounts
  class MyTweetAppsController < ApplicationController
    before_action :authenticate_user

    def authorize_my_tweet_app
      redirect_to MyTweetAppService.build_authorize_uri()
    end

    def oauth_callback_for_my_tweet_app
      if request.params['code'].present?
        response = MyTweetAppService.request_authorization_code(request.params['code'])
        parse_body = JSON.parse(response.body)
        session[:access_token] = parse_body['access_token'] if parse_body['access_token'].present?
      end
      redirect_to photos_index_path
    end

    def post_tweet
      photo = Photo.find_by(id: request.params[:id], user_id: current_user.id)
      response = MyTweetAppService.post_tweet(photo, session[:access_token]) if photo.present?
      redirect_to photos_index_path
    end
  end
end