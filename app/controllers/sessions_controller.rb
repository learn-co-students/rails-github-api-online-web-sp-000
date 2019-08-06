class SessionsController < ApplicationController
  skip_before_action :authenticate_user, only: :create

  def create
    
#     client_id = ENV['GITHUB_CLIENT']
#     client_secret = ENV['GITHUB_SECRET']

#     response = Faraday.post "https://github.com/login/oauth/access_token" do |req|
#       req.params = { 'client_id': client_id, 'client_secret': client_secret, 'code': params[:code] },
#       { 'Accept' => 'application/json'}
#     end
# # binding.pry
#     body = JSON.parse(response.body)
#     session[:token] = body['access_token']

#     redirect_to root_path
      response = Faraday.post "https://github.com/login/oauth/access_token", {client_id: ENV["GITHUB_CLIENT"], client_secret: ENV["GITHUB_SECRET"],code: params[:code]}, {'Accept' => 'application/json'}
      access_hash = JSON.parse(response.body)
      session[:token] = access_hash["access_token"]

      user_response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
      user_json = JSON.parse(user_response.body)
      session[:username] = user_json["login"]

redirect_to '/'
  end
end
