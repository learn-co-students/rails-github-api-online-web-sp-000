class SessionsController < ApplicationController
  skip_before_action :authenticate_user

    def create
      client_id = ENV['GITHUB_CLIENT']
      client_secret= ENV['GITHUB_SECRET']
      response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
        req.body = { 'client_id': client_id, 'client_secret': client_secret, 'code': params[:code] }
        req.headers['Accept'] = 'application/json'
      end
       
        body = JSON.parse(response.body)
        session[:token] = body["access_token"]

        resp = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
        resp_json = JSON.parse(resp.body)
        session[:username] = resp_json["login"]
        redirect_to root_path

    end
end
