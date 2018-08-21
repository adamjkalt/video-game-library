require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get '/signup' do
    @duck = "quack"
    if logged_in?
      redirect to 'games'
    else
        erb :'users/signup'
      end
    end

    post '/signup' do
       if params[:username] == "" || params[:email] == "" || params[:password] == ""
         flash[:message] = "Please fill out all form fields."
         redirect to '/signup'
       elsif
         User.find_by(:username => params[:username])
         flash[:message] = "Username already exists.  Please enter a different Username."
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
         flash[:message] = "Username and/or password incorrect. Please try again."
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
