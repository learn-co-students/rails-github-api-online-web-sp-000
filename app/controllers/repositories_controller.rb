class RepositoriesController < ApplicationController
  
  def index
    @user = get_user
    @resp = Faraday.get "https://api.github.com/users/#{@user}/repos" do |req|
      req.params['client_id'] = ENV['GITHUB_CLIENT_ID']
      req.params['client_secret'] = ENV['GITHUB_SECRET']
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
