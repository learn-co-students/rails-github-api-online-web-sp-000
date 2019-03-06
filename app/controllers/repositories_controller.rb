class RepositoriesController < ApplicationController
  def index
    user_resp = Faraday.get('https://api.github.com/user') do |req|
      req.headers = {
        'Accept': 'application/json',
        'Authorization': "token #{session[:token]}"
      }
    end
    @login = JSON.parse(user_resp.body)['login']
    repos_resp = Faraday.get('https://api.github.com/user/repos') do |req|
      req.headers = {
        'Accept': 'application/json',
        'Authorization': "token #{session[:token]}"
      }
    end
    # binding.pry
    @repos = JSON.parse(repos_resp.body)
  end

end
