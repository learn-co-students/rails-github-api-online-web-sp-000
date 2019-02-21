class RepositoriesController < ApplicationController
  def index
    res = Faraday.get('https://api.github.com/user') do |req|
      req.headers = {
        'Accept': 'application/json',
        'Authorization': "token #{session[:token]}"
      }
    end
    @body = JSON.parse(res.body)
  end

end
