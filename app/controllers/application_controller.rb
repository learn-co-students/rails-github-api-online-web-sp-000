class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :authenticate_user

  private

  def get_user
    resp = Faraday.get "https://api.github.com/user" do |req|
      req.headers['Authorization'] = "token #{session[:token]}"
      req.body = {
        'client_id': ENV['GITHUB_CLIENT'],
        'client_secret': ENV['GITHUB_SECRET']
      }
    end
    if resp.success?
      the_user = JSON.parse(resp.body)
      return the_user['login']
    else
      nil
    end
  end

  def authenticate_user
    client_id = ENV['GITHUB_CLIENT']
    redirect_uri = CGI.escape("http://localhost:3000/auth")
    github_url = "https://github.com/login/oauth/authorize?client_id=#{client_id}&redirect_uri=#{redirect_uri}"
    redirect_to github_url unless logged_in?
  end

  def logged_in?
    !!session[:token]
  end
end
