
class RepositoriesController < ApplicationController
  def index
    response = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers = {'Authorization': "token #{session[:token]}", 'Accept': 'application/json'}
    end
    @repos_array = JSON.parse(response.body)
  end

  def create
    response = Faraday.post "https://api.github.com/user/repos" do |req|
       req.body = {name: params[:name]}
       req.headers = {'Authorization': "token #{session[:token]}", 'Accept': 'application/json'}
    end
    redirect_to '/'
  end
end
