class TestController < ApplicationController
  def index
    fixVideo
  end
  
  
  def fixVideo
      @apiKey='16740792'
      location = 'localhost'
      @session_id = TBO.create_session(location).to_s
      @token= TBO.generate_token :session_id=> @session_id, :role=> OpenTok::RoleConstants::MODERATOR, :api_url => 'https://api.opentok.com/hl'
      @allQuestions=Question.all
      @allResponses=Response.all
      @allQuestions.each do |question|
        archiveId=question.archiveId
        toArchive=TBO.get_archive_manifest(archiveId,@token)
        toVideoResource=toArchive.resources[0]
        videoId=toVideoResource.getId()
        url = toArchive.downloadArchiveURL(videoId, @token)
        question.update_attributes({
          :videoId=>videoId,
          :downloadUrl=>url})
        question.save()
      end
      @allResponses.each do |response|
        archiveId=response.archiveId
        toArchive=TBO.get_archive_manifest(archiveId,@token)
        toVideoResource=toArchive.resources[0]
        videoId=toVideoResource.getId()
        url = toArchive.downloadArchiveURL(videoId, @token)
        response.update_attributes({
          :videoId=>videoId,
          :downloadUrl=>url})
        response.save()
      end 
  end 
end
