require 'rack-flash'

class GamesController < ApplicationController
  use Rack::Flash

  get '/games' do
    if logged_in?
    @user = current_user
    @games = @user.games
    erb :'/games/index'
  else
    redirect to '/login'
  end
  end

  get '/games/new' do
      erb :'/games/new'
    end

    get '/games/:slug' do
      @game = current_user.games.find_by_slug(params[:slug])
      erb:'/games/show'
    end

  post '/games' do
    if params[:name].empty? || params[:console_name].empty?
      flash[:message] = "Please make sure to enter both a Game and a Console."
        redirect to '/games/new'
      elsif
        current_user.games.find_by(:name => params[:name])
        flash[:message] = "Game already exists for one console in your collection."
        redirect to '/games/new'
      else
      @game = Game.create(name: params[:name])
      @game.console = Console.find_or_create_by(name: params[:console_name])
      @game.save
      current_user.games << @game
      current_user.consoles << @game.console
        redirect("/games/#{@game.slug}")
      end
  end


  get '/games/:slug/edit' do
      @game = current_user.games.find_by_slug(params[:slug])
      erb :'games/edit'
    end

    patch '/games/:slug' do
      if params["game"]["name"].empty? || params["console"]["name"].empty?
        flash[:message] = "Unable to edit game.  Please do not leave any form fields empty."
          redirect to "/games/#{params[:slug]}/edit"
        else
      @game = current_user.games.find_by_slug(params[:slug])
      @game.update(params[:game])
      @game.console = Console.find_or_create_by(name: params[:console][:name])
      @game.save
      redirect("/games/#{@game.slug}")
    end
    end

    delete '/games/:id/delete' do
             if logged_in?
               @game = Game.find_by_id(params[:id])
               @game.delete
                redirect to '/games'
             else
               redirect to '/login'
             end
           end

end
