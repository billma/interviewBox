class UploadController < ApplicationController
  require 'aws/s3'
  
  def uploadImage
    AWS::S3::Base.establish_connection!(
      :access_key_id     => 'AKIAJRHPW4GS2XXBWQXA',
      :secret_access_key => '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'
    )
    File.open('temp.png',"wb") do |file|
      file.write(Base64.decode64(params[:imageData]))
    end
    AWS::S3::S3Object.store(params[:archiveId]+'.png', File.open('temp.png'), 'tradeDev',:access => :public_read)
    image=AWS::S3::S3Object.url_for(params[:archiveId]+'.png','tradeDev',:authenticated => false)
    if params[:imageFor]=="question"
      question=Question.find_by_archiveId(params[:archiveId])
      question.update_attributes({:image=>image})
      question.save
    else 
      response=Response.find_by_archiveId(params[:archiveId])
      response.update_attributes({:image=>image})
      response.save
    end 
    render :json=> {}
  end
  
  def removeImage
    
  end 
  
  def getImage
    image=AWS::S3::S3Object.url_for('testing.png','tradeDev')
    render :json => {:image=>image}
  end
end
