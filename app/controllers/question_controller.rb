class QuestionController < ApplicationController

  def create 
    apiKey='16740792'
    location = 'localhost'
    session_id = TBO.create_session(location).to_s
    token= TBO.generate_token :session_id=> session_id, :role=> OpenTok::RoleConstants::MODERATOR, :api_url => 'https://api.opentok.com/hl'
    newQuestion=Question.create({
      :title=>params[:title],
      :description=>params[:description],
      :archiveId=>params[:archiveId],
      :user_id=>cookies[:current_user],
      :questionType=>params[:questionType],
      :up_vote=>0
    })
    toArchive=TBO.get_archive_manifest(params[:archiveId],token)
    toVideoResource=toArchive.resources[0]
    videoId=toVideoResource.getId()
    url = toArchive.downloadArchiveURL(videoId, token)
    newQuestion.update_attributes({
      :videoId=>videoId,
      :downloadUrl=>url
    })
    newQuestion.save
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
