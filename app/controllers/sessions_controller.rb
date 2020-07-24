class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    # client_id = ENV["GITHUB_CLIENT"]
    # client_secret = ENV["GITHUB_SECRET"]
    #
    # resp = Faraday.post "https://github.com/login/oauth/access_token" do |req|
    #   req.body = { 'client_id': client_id, 'client_secret': client_secret, 'code': params["code"] }
    #   req.headers['Accept'] = 'application/json'
    # end
    #
    # body = JSON.parse(resp.body)
    # session[:token] = body["access_token"]
    # redirect_to root_path

    resp = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}

      body = JSON.parse(resp.body)
      session[:token] = body["access_token"]

    user_resp = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    user_json = JSON.parse(user_resp.body)
    session[:username] = user_json["login"]

    redirect_to '/'
  end
end
