require 'bundler/setup'
require 'sinatra'
require 'dotenv'

get '/' do
  'Hello world!'
end

post '/ci-post-deploy' do
  webhook_json = JSON.parse(request.env["rack.input"].read)
  pr_number = webhook_json['commit']['message'].match(/request #(\d+) /)[1]
  logger.info "ci post-deploy webhook received for maji PR #{pr_number}"
  commit_url = webhook_json['commit']['url']
end
