class PusherController < ApplicationController
  def auth
    id=cookies[:current_user]
    printa("auth")
    printa(id)
    response=Pusher[params[:channel_name]].authenticate(params[:socket_id], {
        :user_id => id , # => required
        :user_info=>{
          :name=> User.find(id).name
        }
    })
     render :json => response
  end 
end
