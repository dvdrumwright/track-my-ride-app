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

  post '/rides/new' do
         if params[:description] == "" || params[:ride_distance] == ""
            flash[:error] = "All fields must be filled"
            redirect to '/rides/new'
          elsif logged_in? && !params.empty?
              @rides= current_user.create( description: params[:description], ride_distance: params[:ride_distance])
              if @rides.save
                 redirect '/home'
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
