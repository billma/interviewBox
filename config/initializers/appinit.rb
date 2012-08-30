api_key='16740792'
api_secret ="23aa4de4fe184a941b5e9b2ee336aa3102929d0d"
TBO = OpenTok::OpenTokSDK.new api_key, api_secret, true


Pusher.app_id = '24664'
Pusher.key = 'd6a43f6964492a09120c'
Pusher.secret = '8b8ec80dbfc222b8a337'

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, 'DKvYwZsq7m4ZrkmitxGOQ','LSbTi7X8FfFLAwguMhhOF6DdktAYwyS24CxdJF7c'
                                               
end