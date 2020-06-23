class RidesController < ApplicationController

  get '/rides' do
    if logged_in?
      @rides = Ride.all
      erb :'rides/index'
    else
      erb :'cyclists/login'
    end
  end

    get '/rides/new' do
      if logged_in?
        erb :'rides/new'
      else
        erb 'cyclists/login'
      end
    end

    post '/rides' do
     if params.values.any? {|value| value == ""}
      erb :'rides/new', locals: {message: "Your missing information!"}
    elsif logged_in? && !params.empty?
      @ride = Ride.create(ride_distance: params[:ride_distance], description: params[:description])
      if @ride.save
        redirect to '/rides'
      else
        flash[:error] = "Your project could not be saved. Try again!"
        redirect '/rides/new'
      end 
    end
  end


delete '/rides/:id' do
        ride = Ride.find_by(id: params[:id])
        authorize_user(ride)
        u = current_user
        if ride
          ride.destroy
            redirect "/cyclists/#{u.id}"
        end
    end

    get '/rides/:id/edit' do
        @ride = Ride.find_by(id: params[:id])
        authorize_user(  @ride )
        erb :'rides/edit'
    end

    patch '/rides/:id' do
        u = current_user
        @ride = Ride.find_by(id: params[:id])
        authorize_user(@ride)
        @ride.update(description: params[:description], ride_distance: params[:ride_distance])
        redirect "/cyclists/#{u.id}"
    end
end
