class InterviewBox.Views.Recorder extends Backbone.View
  template: JST["backbone/templates/lib/video/responseRecorder"]
  a_template: JST["backbone/templates/lib/video/questionRecorder"]
  events:
    'click .closeRecorder':'removeRecorder'
    'click #createQuestion .submit':'createQuestion'
  initialize:(option)->
    $('html').css("overflow", "hidden")
    @currentUser=option['currentUser']
    console.log @model
  initialize:->
    $('html').css("overflow", "hidden")
    
  renderResponseRecorder:->
    $(@el).html(@template())
    @setupVideoRecorder()
    return this
  
  renderQuestionRecorder:->
    $(@el).html(@a_template())
    @setupVideoRecorder()
    return this
  
  setupVideoRecorder:->
    self=@
    $.post '/generateToken',{},(data)->
      self.setupRecorderManager(data['apiKey'],data['token'])
  
  setupRecorderManager:(apiKey, token)->
      self=@
      recorderManager=TB.initRecorderManager apiKey
      template='<div id="recorderElement"></div>'  
      self.$('.player').html Mustache.to_html(template,{})
      @recorder=recorderManager.displayRecorder token, "recorderElement", {width:400, height:300}
      # commentForm=new InterviewBox.Views.Comment()
      # $('#commentForm').append commentForm.renderForm().el
      @recorder.addEventListener 'recordingStarted', (e)->
        self.recStartedHandler(e)
      @recorder.addEventListener 'archiveSaved', (e)->
        self.archiveSavedHandler(e)

      
  recStartedHandler:(event)->
      @recImgData=@recorder.getImgData()
        
  archiveSavedHandler:(event)->
    self=@
    archiveId=event.archives[0].archiveId
    if @model is undefined
      # recording a questions 
      self.archiveId_question=archiveId
    else 
      # recording a response
      $.post '/newResponse',{
        archiveId:archiveId,
        question_id:self.model.get('id')
      },(data)->
        console.log data
        self.uploadImage(self.recImgData,archiveId,'response')
        self.removeRecorder()
        self.trigger('finishedRecording')
  
  
  uploadImage:(data,id,imageFor)->
    $.post '/uploadImage', {
      imageData:data,
      archiveId:id,
      imageFor:imageFor
    },()->
    
  createQuestion:(e)->
    e.preventDefault()
    self=@
    if @archiveId_question is undefined 
      # please recorder video
      alert("please record a video")
    else 
      # check for all other input
      $.post '/createQuestion', {
        title:$('.title').val(),
        archiveId:self.archiveId_question,
        description:$('.description').val(),  
        questionType:$('.type').val()
      },(newQuestion)->
        self.removeRecorder()
        self.uploadImage(self.recImgData, newQuestion['archiveId'],'question')
   
  removeRecorder:->
    $('html').css("overflow", "auto")
    @remove()


  
