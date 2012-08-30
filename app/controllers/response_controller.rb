class ResponseController < ApplicationController
  def new
    printa "new reponse..."
    printa params 
    response=Response.create({
      :archiveId=>params[:archiveId],
      :user_id=>cookies[:current_user],
      :question_id=>params[:question_id]
    })
    render :json=>response
  end 
  def all
    
    
  end
  def userReponses
    user=User.find(params[:userId])
    render :json=> user.response
  end 
  def responses
    question=Question.find(params[:questionId])
    render :json=> question.response
  end 
end
