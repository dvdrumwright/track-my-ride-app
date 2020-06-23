class RidesController < ApplicationController



  get '/rides' do
    if logged_in?
      @rides = Ride.all
      erb :'rides/index'
    else
      redirect '/login'
    end
  end

    get '/rides/new' do
      if logged_in?
        erb :'rides/new'
      else
        erb '/login'
      end
    end


      post '/rides' do
      @ride = Ride.create(description: params[:description])
      if @ride.errors.any?
          erb :"/rides/new"
        else
          erb :"rides/show"
        end
      end

      get '/rides/:id' do
          @ride = Ride.find_by_id(params[:id])
          redirect '/rides' if @ride.nil?
          erb :'/rides/show'
        end

        delete '/rides/:id' do
          if logged_in?
              ride = Ride.find_by(id: params[:id])
              u = current_user
              if ride
                ride.destroy
                  redirect "/cyclists/#{u.id}"
              end
          end

          get '/rides/:id/edit' do
              @ride = Ride.find_by(id: params[:id])
              if logged_in? && current_user.rides.include?(@rides)
              erb :'rides/edit'
            else
              flash[:error] = "You must be logged in to edit your ride"
              redirect '/login'
            end
          end

          patch '/rides/:id' do
            @ride = Ride.find_by(id: params[:id])
            if params.empty?
              redirect "/rides/#{@rides.id}/edit"

            elsif logged_in? && !params.empty? && current_user.rides.include?(@rides)
              @ride.update(description: params[:description], ride_distance: params[:ride_distance])
              redirect "/rides/#{@ride.id}"
            else
              flash[:error] = "You must be logged in."
              redirect '/login'
              end
            end
          end

  end
