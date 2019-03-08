class RepositoriesController < ApplicationController
  
  def index
    user_resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
     end
    
    user_body = JSON.parse(user_resp.body)
    @user = user_body['login']

    repos_resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end

    @repos = JSON.parse(repos_resp.body)
  end

end
