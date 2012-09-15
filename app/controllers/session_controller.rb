
class SessionController < ApplicationController
  
  
  def create
    auth=request.env["omniauth.auth"]
    if(auth!=nil)
      uid=auth['uid']
      user=User.find_by_uid(uid)
      if user==nil
        cookies[:name]=auth['info']['name']
        cookies[:uid]=uid
        redirect_to '/new_user'
      else 
        cookies[:current_user]=user.id
        redirect_to '/home'
      end 
    end 
  end
  
  def destroy
    cookies[:current_user]=""
    redirect_to root_path
  end
  
  def generateToken
      printa "generating token..."
     apiKey='16740792'
     location = 'localhost'
     session_id = TBO.create_session(location).to_s
     token= TBO.generate_token :session_id=> session_id, :role=> OpenTok::RoleConstants::MODERATOR, :api_url => 'https://api.opentok.com/hl'
     render :json=>{
       :token=>token,
       :apiKey=>apiKey
     }
  end 
  
  def getDownloadLink
    apiKey='16740792'
    location = 'localhost'
    session_id = TBO.create_session(location).to_s
    token= TBO.generate_token :session_id=> session_id, :role=> OpenTok::RoleConstants::MODERATOR, :api_url => 'https://api.opentok.com/hl'
    toArchive=TBO.get_archive_manifest(params[:archiveId],token)
    videoId=params[:videoId]
    url = toArchive.downloadArchiveURL(videoId, token)
    printa 'getDownloadLink'
    printa url
    render :json=> {:url=>url}
  end 
  

end
