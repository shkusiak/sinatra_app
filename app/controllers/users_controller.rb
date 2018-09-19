class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect to '/signup'
    elsif user_exists?(params)
      redirect to '/login'
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/shoes'
    end
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
