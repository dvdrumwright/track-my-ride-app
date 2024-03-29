class RidesController < ApplicationController

  get '/rides' do
        authorize
        @rides = Ride.all
        erb :'rides/index'
    end

    get '/rides/new' do
        authorize
        erb :'rides/new'
    end

    post '/rides' do
        u = current_user
        u.rides.create(distance: params[:distance], time: params[:time], mood: params[:mood])
        u.save
        redirect '/rides'
    end

    delete '/rides/:id' do
        @ride = Ride.find_by(id: params[:id])
        authorize_user(@ride)
        u = current_user
        if @ride
            @ride.destroy
            redirect "/users/#{u.id}"
        end
    end

    get '/rides/:id/edit' do
        @ride = Ride.find_by(id: params[:id])
        erb :'rides/edit'
    end

    patch '/rides/:id/edit' do
        u = current_user
        @ride = Ride.find_by(id: params[:id])
         @ride.update(distance: params[:distance], time: params[:time], mood: params[:mood])
        # redirect "/users/#{u.id}"
        redirect '/rides'
    end
end
