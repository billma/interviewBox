class ResponseController < ApplicationController

  # create a new response
  def new
    apiKey='16740792'
    location = 'localhost'
    session_id = TBO.create_session(location).to_s
    token= TBO.generate_token :session_id=> session_id, :role=> OpenTok::RoleConstants::MODERATOR, :api_url => 'https://api.opentok.com/hl'
    response=Response.create({
      :archiveId=>params[:archiveId],
      :user_id=>cookies[:current_user],
      :question_id=>params[:question_id]
    })
    toArchive=TBO.get_archive_manifest(params[:archiveId],token)
    toVideoResource=toArchive.resources[0]
    videoId=toVideoResource.getId()

    response.update_attributes({
      :videoId=>videoId,
    })
    response.save
    render :json=>response
  end 
  
  # get all response
  def all
  end  
  
  # get all user's responses
  def userReponses
    user=User.find(params[:userId])
    render :json=> user.response
  end 

  # get all responses that belongs to 
  # a qeustion
  def responses
    question=Question.find(params[:questionId])
    render :json=> question.response
  end 
end
