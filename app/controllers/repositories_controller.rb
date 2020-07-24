class RepositoriesController < ApplicationController

  def index
    resp_repos = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    @repos = JSON.parse(resp_repos.body)

    resp_user = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = 'application/json'
    end
    json_user = JSON.parse(resp_user.body)
    session[:login] = json_user["login"]
  end

end
