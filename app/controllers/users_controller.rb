class UsersController < ApplicationController

  get '/signup' do
    if session[:user_id]
      redirect to '/shoes'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      redirect to '/signup'
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/shoes'
    end
  end

  get '/login' do
    if session[:user_id]
      redirect to '/shoes'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    if !!@user && !!@user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/shoes'
    else
      redirect to "/signup"
    end
  end

  get '/logout' do
    sessions.clear
    redirect '/login'
  end

end
