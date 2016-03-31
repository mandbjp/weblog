require 'bundler/setup'
require 'sinatra'

require 'haml'
require 'sass'
require 'coffee-script'

require 'google/apis/drive_v2'
require 'google/api_client/client_secrets'

# set client_secrets.json on root directory
client_secrets = Google::APIClient::ClientSecrets.load
auth_client = client_secrets.to_authorization
auth_client.update!(
  :scope => 'https://www.googleapis.com/auth/drive.readonly',
  :redirect_uri => 'https://____your_heroku_app____.herokuapp.com/oauth2callback'
)

get '/' do
  auth_uri = auth_client.authorization_uri.to_s
  @url = auth_uri
  haml :index
end


get '/oauth2callback' do
  auth_code = params['code']
  auth_client.code = auth_code
  auth_client.fetch_access_token!
  p auth_client

  @code = auth_code

  service = Google::Apis::DriveV2::DriveService.new
  service.authorization = auth_client
  response = service.list_files
  @files = response

  haml :oauth2callback
end