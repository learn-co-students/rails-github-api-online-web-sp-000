class RepositoriesController < ApplicationController
  
  def index
    resp = Faraday.get("https://api.github.com/user") do |request|
      request.headers['Authorization'] = 'token ' + session[:token]
      request.headers['Accept'] = 'application/json'
    end
    @login = JSON.parse(resp.body)["login"]
    response = Faraday.get("https://api.github.com/user/repos") do |request|
  	   request.headers['Authorization'] = 'token ' + session[:token]
  	    request.headers['Accept'] = 'application/json'
  	end
    @repos = JSON.parse(response.body)
  end
end
