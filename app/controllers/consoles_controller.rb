class ConsolesController < ApplicationController

  get '/consoles' do
    if logged_in?
    @user = current_user
    @consoles = @user.consoles
    erb :'/consoles/index'
  else
    redirect to '/login'
  end
  end

   get '/consoles/:slug' do
     @console = Console.find_by_slug(params[:slug])
     @games = @console.games.where(user_id: current_user.id)
     erb:'/consoles/show'
   end

end
