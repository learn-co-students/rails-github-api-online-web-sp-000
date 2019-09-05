class RepositoriesController < ApplicationController
  
  def index
    token = 'token ' + session[:token]
    login_resp = Faraday.get("https://api.github.com/user") do |req|
      req.headers['Accept'] = 'application/json'
      req.headers["Authorization"] = token
    end

    login_body = JSON.parse(login_resp.body)
    @username = login_body['login']

    resp = Faraday.get("https://api.github.com/user/repos") do |req|
      req.headers['Accept'] = 'application/json'
      req.headers["Authorization"] = token
    end

    body = JSON.parse(resp.body)
    @repos = body
  end

end
