class ConsolesController < ApplicationController

  get '/consoles' do
    if logged_in?
    @consoles = Console.all
    @user = current_user
    erb :'/consoles/index'
  else
    redirect to '/login'
  end
  end

   get '/consoles/:slug' do
     @console = Console.find_by_slug(params[:slug])
     erb:'/consoles/show'
   end

end
