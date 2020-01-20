class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    resp = Faraday.post("https://github.com/login/oauth/access_token" do |req|
      req.body = { client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"], code: params[:code] }
      req.headers['Accept'] = 'application/json'
      access_hash = JSON.parse(resp.body)
      session[:token] = access_hash["access_token"]
    end 
  end
end
