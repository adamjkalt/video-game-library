class ConsolesController < ApplicationController

  get '/consoles' do
    @consoles = Console.all.sort_by!{ |console| console.name.downcase }
     erb :'/consoles/index'
   end

   get '/consoles/:slug' do
     @console = Console.find_by_slug(params[:slug])
     erb:'/consoles/show'
   end

end
