require './config/environment'
require 'sinatra/base'
require 'rack-flash'
require 'json'
require 'open-uri'
require 'pry'






class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
        set :views, 'app/views'
        set :public_folder, 'public'
        enable :sessions
        set :session_secret, "secret"

    end


    get '/' do
        erb :root
    end

    get '/home' do
        authorize
        erb :home
    end

    get '/logout' do
        session.clear
        redirect '/'
    end

    helpers do

        def logged_in?
            !!User.find_by(id: session[:user_id])
        end

        def current_user
            user = User.find_by(id: session[:user_id])
            user
        end

        def authenticate(username)
            user = User.find_by(username: username)
            session[:user_id] = user.id
            user
        end

        def authorize
            current_user
        end


    end
  end
