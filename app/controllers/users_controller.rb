require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    if logged_in?
      redirect to 'games'
    else
        erb :'users/signup'
      end
    end

    post '/signup' do
       if params[:username] == "" || params[:email] == "" || params[:password] == ""
         redirect to '/signup'
       elsif
         User.find_by(:username => params[:username])
         redirect to '/signup'
       else
         @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
         session[:user_id] = @user.id
         redirect to '/games'
       end
     end

     get '/login' do
         if !logged_in?
           erb :'users/login'
         else
           redirect to '/games'
         end
       end

       post '/login' do
       user = User.find_by(:username => params[:username])
       if user && user.authenticate(params[:password])
         session[:user_id] = user.id
         redirect to '/games'
       else
         redirect to '/users/login'
       end
     end

     get '/logout' do
         if logged_in?
           session.destroy
           redirect to '/login'
         else
           redirect to '/'
         end
       end
     end
