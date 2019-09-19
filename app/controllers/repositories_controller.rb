class RepositoriesController < ApplicationController
  before_action :authenticate_user

  def index
    @username = session[:username]
    user = Faraday.get "https://api.github.com/user/repos", {}, {'Authorization' => "token #{session[:token]}", 'Accept' => 'application/json'}
    @repos = JSON.parse(user.body)
    
  end

end
