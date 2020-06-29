require 'bcrypt'
require 'sinatra'
require 'pry'


class UsersController < ApplicationController

  configure do
		set :views, "app/views"
		enable :sessions
		set :session_secret, "password_security"
	end

  get '/users' do
      @user = User.all
      erb :'users/index'
    end

  get '/signup' do
    if !logged_in?
    erb :'/users/new'
  else
      redirect to '/rides'
   end
  end

  post '/signup' do
   if params[:username] == "" || params[:password] == ""
     flash[:signup_page_message] = "Sorry, can you make sure to fill out all three fields: Name, Email, and Password?"
     redirect to '/signup'
   end

   if !User.new(:username => params[:username], :password => params[:password]).valid?
     flash[:signup_page_message] ="Oops, sorry but that name is already taken!"
     redirect to '/signup'

   elsif
     @user = User.new(:username => params[:username], :password => params[:password])
     @user.save
     session[:user_id] = @user.id
     redirect to '/home'
   end
 end

 get '/login' do
     if !logged_in?
       erb :'users/login'
     else
       redirect to '/rides'
     end
   end

   post '/login' do
     user = User.find_by(:username => params[:username])
     if user && user.authenticate(params[:password])
       session[:user_id] = user.id
       redirect to '/home'
     else
       flash[:message_for_login_page] = "Oops, your username & password combo is incorrect; pleaset try again !"
        redirect to '/login'
     end
   end

   get '/users/:id' do
     @user = User.find_by(id: params[:id])
     erb :'users/show'
   end

   get '/logout' do
     if logged_in?
       session.destroy
       redirect to '/login'
     else
       redirect to '/'
     end


   end
 end
