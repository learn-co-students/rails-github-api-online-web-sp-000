class RepositoriesController < ApplicationController
  
  def index
    client_id = ENV['GITHUB_CLIENT']
    client_secret = ENV['GITHUB_SECRET']

    response = Faraday.get "https://api.github.com/user" do |req|
      req.params = { 'access_token': session[:token] }
      req.headers['Accept'] = 'application/json'
    end

    body = JSON.parse(response.body)
     
    @user = body["login"]

    response = Faraday.get "https://api.github.com/user/repos" do |req|
      req.params = { 'access_token': session[:token] }
      req.headers['Accept'] = 'application/json'
    end
    
    @repos = JSON.parse(response.body)

    # binding.pry
  end
end
