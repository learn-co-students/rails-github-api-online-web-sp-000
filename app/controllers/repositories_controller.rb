class RepositoriesController < ApplicationController

  def index
    # resp_repositories = Faraday.get "https://api/github.com/user/repos" do |req|
    #   req.headers['Authorization'] = "token #{session[:token]}"
    #   req.headers['Accept'] = 'application/json'
    # end
    # @repositories = JSON.parse(resp_repositories.body)
    #
    # resp_user = Faraday.get "https://api/github.com/user" do |req|
    #   req.headers['Authorization'] = "token #{session[:token]}"
    #   req.headers['Accept'] = 'application/json'
    # end
    # user = JSON.parse(resp_user.body)
    # session[:login] = user["login"]
    resp = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos = JSON.parse(resp.body)
  end

end
