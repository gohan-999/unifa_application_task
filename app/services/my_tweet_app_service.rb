class MyTweetAppService
  require 'net/http'
  HOST = 'https://arcane-ravine-29792.herokuapp.com'.freeze
  CLIENT_ID = Rails.application.credentials.config[Rails.env.to_sym][:my_tweet_app][:client_id].freeze
  CLIENT_SECRET = Rails.application.credentials.config[Rails.env.to_sym][:my_tweet_app][:client_secret].freeze
  REDIRECT_URI = 'http://localhost:3000/oauth/callback'.freeze
  PHOTO_URL_PATH = 'http://localhost:3000/uploaded_photos/'.freeze

  class << self
    def build_authorize_uri
      uri = build_uri('/oauth/authorize')
      uri.query = {
        response_type: 'code',
        redirect_uri: REDIRECT_URI,
        client_id: CLIENT_ID
      }.to_param
      uri.to_s
    end

    def request_authorization_code(code)
      uri = build_uri('/oauth/token')
      params = {
        code: code,
        client_id: CLIENT_ID,
        client_secret: CLIENT_SECRET,
        redirect_uri: REDIRECT_URI,
        grant_type: 'authorization_code'
      }.to_param

      post(uri, params)
    end

    def post_tweet(photo, access_token)
      uri = build_uri('/api/tweets')
      params = {
          text: photo.title,
          url: "#{PHOTO_URL_PATH}#{photo.name}"
      }.to_json
      headers = {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{access_token}"
      }

      post(uri, params, headers)
    end

    private

    def build_uri(path = '')
      URI("#{HOST}#{path}")
    end

    def post(uri, params = {}, headers = {})
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = uri.scheme == 'https'
      res = http.post(uri.path, params, headers)
    end
  end
end



