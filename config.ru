require './config/environment'



use Rack::MethodOverride
use RidesController
use UsersController
run ApplicationController
