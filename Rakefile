ENV["SINATRA_ENV"] ||= "development"

require_relative './config/environment'
require 'sinatra/activerecord/rake'

desc "Allow console to have access to Models and Database"
task :console do
    Pry.start
end
