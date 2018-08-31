class ShoesController < ApplicationController

  get '/shoes' do
    if !logged_in?
      redirect to '/login'
    else
      erb :'/shoes/shoes'
    end
  end

  get '/shoes/new' do
    if !logged_in?
      redirect to '/login'
    else
      erb :'shoes/create_shoe'
    end
  end

  get '/shoes/:id' do
    if !logged_in?
      redirect to '/login'
    else
      erb :'/shoes/show_shoe'
    end
  end

  get '/shoes/:id/edit' do
    if !logged_in?
      redirect to '/login'
    else
      erb :'/shoes/edit_shoe'
    end
  end

  post '/shoes' do

  end

  patch '/shoes/:id' do

  end

  delete '/shoes/:id/delete' do

  end

end
