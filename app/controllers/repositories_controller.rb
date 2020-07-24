class RepositoriesController < ApplicationController
  
  def index
    # resp = Faraday.get("https://api.github.com/user/repos") do |req|
    response = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
      # req.params['oauth_token'] = session[:token]
    #  end
   
    @repositories = JSON.parse(response.body)


    response = Faraday.get "https://api.github.com/user", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}

    @username = JSON.parse(response.body)["login"]
  end

end
