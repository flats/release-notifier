require 'bundler/setup'
Bundler.require

require_relative 'github_pull_request'

Dotenv.load

get '/' do
  'Hello world!'
end

post '/ci-post-deploy' do
  webhook_json = JSON.parse(request.env["rack.input"].read)
  @pr_number = webhook_json['commit']['message'].match(/request #(\d+) /)[1]
  logger.info "ci post-deploy webhook received for maji PR #{pr_number}"
end

get '/testing-gh-api/:pr_number' do
  github = GithubPullRequest.new params['pr_number']
  github.retrieve_details.body.to_s
end
