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
      @game = Game.find_by_slug(params[:slug])
      erb:'/games/show'
    end

  post '/games' do
  @game = Game.create(name: params["Name"])
  @game.console = Console.find_or_create_by(name: params["Console Name"])
  @game.save
  current_user.games << @game
  current_user.consoles << @game.console
  flash[:message] = "Successfully created game."
  redirect("/games/#{@game.slug}")
  end


  get '/games/:slug/edit' do
      @game = Game.find_by_slug(params[:slug])
      erb :'games/edit'
    end

    patch '/games/:slug' do
      @game = Game.find_by_slug(params[:slug])
      @game.update(params[:game])
      @game.console = Console.find_or_create_by(name: params[:console][:name])
      @game.save
      flash[:message] = "Successfully updated game."
      redirect("/games/#{@game.slug}")
    end

end
