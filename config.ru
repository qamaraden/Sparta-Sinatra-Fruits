require 'sinatra'
require 'sinatra/contrib'
require 'sinatra/reloader' if development?
require_relative './controller/post_controller'

use Rack::MethodOverride

run PostController
