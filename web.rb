require 'bundler/setup'
require 'sinatra'
require 'dotenv'

get '/' do
  'Hello world!'
end
