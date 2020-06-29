
ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'



desc 'start up the console'
namespace :db do
  task :console do
    Pry.start
  end
end 
