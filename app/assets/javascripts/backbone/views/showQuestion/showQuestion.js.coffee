class InterviewBox.Views.ShowQuestionView extends Backbone.View
  template: JST["backbone/templates/showQuestion/showQuestion"]
  events:
    'click .leaveResponse':'leaveResponse'
  
  initialize:(option)->
    @model=new InterviewBox.Models.Question({id:option['id']})
    @allUsers=option['allUsers']
  
  render:->
    @setupPage()
    return this
    
  setupPage:->
    self=@
    @model.fetch success:()->
      self.loadVideo()
      self.getAllUserVideo()
      self.getAllResponse()
      
  loadVideo:->
    $(@el).html(@template(@model.toJSON()))
    video=new InterviewBox.Views.VideoPlayer({model:@model})
    $('.playerContainer').append video.renderVideo().el
  
  getAllUserVideo:->
    self=@
    @allVideo=new InterviewBox.Collections.UserQuestionsCollection({userId:@model.get('user_id')})
    @allVideo.fetch success:()->
      current=self.allVideo.get(self.model.get('id'))
      self.allVideo.remove(current)
      self.allVideo.each (question)->
         videoLink=new InterviewBox.Views.ArchiveLinkView({model:question})
         $('.moreQuestions').append videoLink.render().el
         
  getAllResponse:->
    responses=new InterviewBox.Collections.QResponsesCollection({
      questionId:@model.get('id')
    })
    responseList=new InterviewBox.Views.ResponseList({collection:responses})
    $('#comment_and_responses').append responseList.render().el
  
    # commentForm=new InterviewBox.Views.Comment()
    # $('#commentForm').append commentForm.renderForm().el     

  leaveResponse:->
    recorder=new InterviewBox.Views.Recorder({model:@model})
    $('html').prepend(recorder.renderResponseRecorder().el)
    
        