class RepositoriesController < ApplicationController

  def index
    resp = Faraday.get "https://api.github.com/user" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @info = JSON.parse(resp.body)
    resp = Faraday.get "https://api.github.com/user/repos" do |req|
      # "https://api.github.com/user/repos?page=1&per_page=100"
      req.body = { "{'name': 'a-new-repo'}" => true }
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    @repos = JSON.parse(resp.body)
  end

  def create
    resp = Faraday.post "https://api.github.com/user/repos" do |req|
      req.body = { 'name': params["name"] }
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    body = JSON.parse(resp.body)
    redirect_to '/'
    # binding.pry
  end

  # private
  #
  # def repo_params
  #
  # end




end
