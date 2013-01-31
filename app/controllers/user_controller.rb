class UserController < ApplicationController

  def new
    @name=cookies[:name]
    @uid=cookies[:uid]
  end 
  # create a new user  
  def create
    object={
      :name=>params[:name],
      :email=>params[:email],
      :uid=>params[:uid]
    }
    newUser=User.create(object)
    cookies[:current_user]=newUser.id
    redirect_to "/home"
  end

  # find user by id 
  def user
    render :json=> User.find(params[:id])
  end 
  # find all user
  def users
    render :json=> User.all
  end
end
