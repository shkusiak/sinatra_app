class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do

  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do

  end

  get '/logout' do
    sessions.clear
    redirect '/login'
  end

end
