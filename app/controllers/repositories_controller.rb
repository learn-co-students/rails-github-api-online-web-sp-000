class RepositoriesController < ApplicationController
  def index
    @user = get_json("https://api.github.com/user")
    @repos = get_json("https://api.github.com/user/repos")
  end

  def get_json(url)
    resp = Faraday.get(url) do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
    end
    JSON.parse(resp.body)
  end
end