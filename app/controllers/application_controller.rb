require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :session_secret, "SESSION_SECRET"
    enable :sessions
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get "/" do
    erb :index
  end

  helpers do

  def current_user
      @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    current_user != nil
  end

end

end
