class ShoesController < ApplicationController

  get '/shoes' do
    if !logged_in?
      redirect to '/login'
    else
      @shoes = Shoe.all
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
      @shoe = Shoe.find_by_id(params[:id])
      @poster = User.find_by_id(@shoe.user_id)
      erb :'/shoes/show_shoe'
    end
  end

  get '/shoes/:id/edit' do
    if !logged_in?
      redirect to '/login'
    else
      @shoe = Shoe.find_by_id(params[:id])
      if @shoe && @shoe.user == current_user
        erb :'/shoes/edit_shoe'
      else
        redirect to '/shoes'
      end
    end
  end

  post '/shoes' do
    if !logged_in?
      redirect to '/login'
    else
      if params[:name] == ""
        redirect to '/shoes/new'
      else
        @shoe = current_user.shoes.build(name: params[:name], manufacturer: params[:manufacturer], description: params[:description], color: params[:color], cost: params[:cost])
        if @shoe.save
          redirect to "/shoes/#{@shoe.id}"
        else
          redirect to "/shoes/new"
        end
      end
    end
  end

  patch '/shoes/:id' do
    if logged_in?
      if params[:name] == ""
        redirect to "/shoes/#{params[:id]}/edit"
      else
        @shoe = Shoe.find_by_id(params[:id])
        if @shoe && @shoe.user == current_user
          if @shoe.update(name: params[:name], manufacturer: params[:manufacturer], description: params[:description], color: params[:color], cost: params[:cost])
            redirect to "/shoes/#{@shoe.id}"
          else
            redirect to "/shoes/#{@shoe.id}/edit"
          end
        else
          redirect to '/shoes'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/shoes/:id/delete' do
    if logged_in?
      @shoe = Shoe.find_by_id(params[:id])
      if @shoe && @shoe.user == current_user
        @shoe.delete
      end
      redirect to '/shoes'
    else
      redirect to '/login'
    end
  end

end
