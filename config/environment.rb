ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])

ActiveRecord::Base.establish_connection(
  :adapter => "sqlite3",
  :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
)



require_relative '../constants'
require_relative '../errors/post_site_error'


require_all 'errors'
require './app/controllers/application_controller'
require_all 'app'
