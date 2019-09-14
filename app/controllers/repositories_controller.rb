class RepositoriesController < ApplicationController
  
  def index
    #Authorization: token OAUTH-TOKEN
    #GET https://api.github.com/user

    resp = Faraday.get("https://api.github.com/user") do |request|
      request.headers['Authorization'] = 'token ' + session[:token]
      request.headers['Accept'] = 'application/json'
    end
    @login = JSON.parse(resp.body)["login"]
    session[:username] = @login

    response = Faraday.get("https://api.github.com/user/repos") do |request|
  	   request.headers['Authorization'] = 'token ' + session[:token]
  	    request.headers['Accept'] = 'application/json'
  	end
    @repos = JSON.parse(response.body)
  end


  

end
