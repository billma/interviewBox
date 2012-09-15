class PagesController < ApplicationController
  
  def login
    if cookies[:current_user]!=""
      redirect_to '/home'
    end 
  end

  def profile
    printa(cookies[:current_user])
    if cookies[:current_user]!=""
      @apiKey='16740792'
      location = 'localhost'
      @session_id = TBO.create_session(location).to_s
      @token= TBO.generate_token :session_id=> @session_id, :role=> OpenTok::RoleConstants::MODERATOR, :api_url => 'https://api.opentok.com/hl'
    else 
      redirect_to '/'
    end 
  end
  
  def home
  end
  
  
  
  

   
end
