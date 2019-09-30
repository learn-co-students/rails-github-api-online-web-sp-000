class RepositoriesController < ApplicationController
  
  def index
    @user = get_user
    #@resp = Faraday.get "https://api.github.com/users/#{@user}/repos" do |req|
    #binding.pry
    @resp = Faraday.get "https://api.github.com/user/repos" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.headers['Accept'] = "application/json"
    end

    body = JSON.parse(@resp.body)
    if @resp.success?
      @repositories = body
    else
      @error = "Failed"
    end
    render 'index'
  end

end
