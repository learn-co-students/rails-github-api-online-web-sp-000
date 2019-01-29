class RepositoriesController < ApplicationController
  before_action :authenticate_user

  def index
    response = Faraday.get 'https://api.github.com/user' do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end
    body = JSON.parse(response.body)
    @login = body["login"]

    repos = Faraday.get 'https://api.github.com/user/repos' do |req|
      req.headers['Authorization'] = 'token ' + session[:token]
      req.headers['Accept'] = 'application/json'
    end
    @repo_list = JSON.parse(repos.body)
  end

end
