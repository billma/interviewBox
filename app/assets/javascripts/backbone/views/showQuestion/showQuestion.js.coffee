class InterviewBox.Views.ShowQuestionView extends Backbone.View
  template: JST["backbone/templates/showQuestion/showQuestion"]
  events:
    'click .leaveResponse':'leaveResponse'
    'click .up_vote':'upVote'
    'click .down_vote':'undoVote'
  
  initialize:(option)->
    @model=new InterviewBox.Models.Question({id:option['id']})
    @allUsers=option['allUsers']
    @currentUser=option['currentUser']
    @.on('changeVote',@.refreshVote)
  render:->
    @setupPage()
    return this
    
  setupPage:->
    self=@
    @model.fetch success:()->
      user=new InterviewBox.Models.User({id:self.model.get('user_id')})
      user.fetch success:->
        $.post '/getVoteCount',{question_id:self.model.get('id')},(data)->
          self.setupTemplate(data,user)
          self.setupVoteBotton()
          self.loadVideo(data)
          self.getAllUserVideo()
          self.getAllResponse()

  setupTemplate:(data,user)->
    @model.set({
      up_vote:data,
      userName:user.get('name')
    })
    $(@el).html(@template(@model.toJSON()))
    @$('.questionInfo .timeago').timeago()
  loadVideo:(data)->
    self=@
    video=new InterviewBox.Views.VideoPlayer({model:self.model})
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
    console.log 'getAllResponse...'
    console.log @currentUser
    responseList=new InterviewBox.Views.ResponseList({
      collection:responses,
      currentUser:@currentUser
    })
    $('#comment_and_responses').html responseList.render().el

  leaveResponse:->
    self=@
    recorder=new InterviewBox.Views.Recorder({model:@model})
    recorder.on 'finishedRecording',()->
       self.getAllResponse()
    $('html').prepend(recorder.renderResponseRecorder().el)

  setupVoteBotton:->
    self=@
    $.post '/checkVote',{
      question_id:@model.get('id')
    },(hasBeenRated)->
      if hasBeenRated is true
        self.$('.vote .up_vote').hide()
        self.$('.vote .down_vote').show()
      else 
        self.$('.vote .up_vote').show()
        self.$('.vote .down_vote').hide()
    
  upVote:->
    # save vote
    self=@
    $.post '/upVote',{
      question_id:@model.get('id')
    },(data)->
      self.trigger('changeVote')
      self.toggleVoteButton()
    
  undoVote:->
    # delete vote
    self=@
    $.post '/downVote',{
      question_id:@model.get('id')
    },(data)->
      self.trigger('changeVote')
      self.toggleVoteButton()
      
  refreshVote:->
    self=@
    $.post '/getVoteCount',{question_id:@model.get('id')},(data)->
      self.$('.voteInfo span').text(data)
      
  toggleVoteButton:->
     @$('.vote .up_vote').toggle()
     @$('.vote .down_vote').toggle()
    