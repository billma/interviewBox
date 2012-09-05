class CommentController < ApplicationController
  
  def new
    newComment=Comment.create({
      :content=>params[:content],
      :user_id=>params[:current_user],
      :response_id=>params[:response_id]
    })
    render :json=> newComment
  end 
  def getCommentByResponse
    responseId=params[:responseId]
    comments=Response.find(responseId).comment
    render :json=> comments
  end 
end
