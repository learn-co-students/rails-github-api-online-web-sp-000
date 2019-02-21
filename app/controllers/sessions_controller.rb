class SessionsController < ApplicationController
  skip_before_action :authenticate_user

  def create
    res = Faraday.post('https://github.com/login/oauth/access_token') do |req|
      code = params[:code]
      client_id = ENV['GITHUB_CLIENT_ID']
      client_secret = ENV['GITHUB_CLIENT_SECRET']
      req.body = {
        'code': code, 
        'client_id': client_id,
        'client_secret': client_secret }
      req.headers['Aceept'] = 'application/json'
    end
    body = JSON.parse(res.body)
    binding.pry if !body['access_token']
    session[:token] = body['access_token']
    redirect_to root_path
  end
end
