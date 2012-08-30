class QuestionController < ApplicationController

  def create 
    printa(params)
    printa(cookies[:current_user])
    newQuestion=Question.create({
      :title=>params[:title],
      :description=>params[:description],
      :archiveId=>params[:archiveId],
      :user_id=>cookies[:current_user],
      :questionType=>params[:questionType]
    })
    render :json=> newQuestion
  end 
  def show
    @id=params[:id]
  end
  def getModel
    render :json=> Question.find(params[:id])
  end 

  # get all questions from a given user
  def questions
    user=User.find(params[:userId])
    data=user.question
    printa "----"
    printa data
    render :json=> data
  end 
  # get all questions regardless of user
  def all
    render :json=> Question.all
  end
end
