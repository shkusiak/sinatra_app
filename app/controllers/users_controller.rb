class UsersController < ApplicationController
  register Sinatra::ActiveRecordExtension

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end

  get '/signup' do
    if session[:user_id]
      redirect to '/shoes'
    else
      erb :'/users/create_user'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
      session[:message] = "Sign up failed, try again."
      redirect to '/signup'
    elsif User.find_by(username: params[:username])
      session[:message] = "username already exists, please login or try again."
      redirect to '/signup'
    elsif User.find_by(email: params[:email])
      session[:message] = "Email already exists, login or try again."
      redirect to '/signup'
    else
      @user = User.new(username: params[:username], email: params[:email], password: params[:password])
      @user.save
      session[:user_id] = @user.id
      redirect to '/shoes'
    end
  end

  get '/login' do
    if logged_in? &&session[:user_id]
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
      session[:message] = "Login failed, try again."
      redirect to '/login'
    end
  end

  get '/failure' do
    erb :'/users/failure'
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

end
