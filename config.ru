require './config/environment'



use Rack::MethodOverride
use SessionController
use RidesController
use UsersController
run ApplicationController
