# handles all pusher activity

class PusherController < ApplicationController

  # push authentication
  def auth
    id=cookies[:current_user]
    # create session for current user
    response=Pusher[params[:channel_name]].authenticate(params[:socket_id], {
        :user_id => id , # => required
        :user_info=>{
          :name=> User.find(id).name
        }
    })
    render :json => response
  end 
end
