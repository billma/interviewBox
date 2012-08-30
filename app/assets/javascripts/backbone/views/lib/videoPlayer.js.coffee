class InterviewBox.Views.VideoPlayer extends Backbone.View
  template: JST["backbone/templates/lib/video/videoPlayer"]
  a_template: JST["backbone/templates/lib/video/simpleVideo"]

  events:
    'click .closePlayer':"closePlayer"
      
  initialize:->
    @player=null
    
  # render with dim background 
  render:->
    $(@el).html(@template())
    $('html').css("overflow", "hidden")
    @loadArchive('regular')
    return this
  # render without dim background
  renderVideo:->
    $(@el).html(@a_template())
    @loadArchive('simple')
    return this
  closePlayer:->
    $('html').css("overflow", "auto")
    @.remove()

  loadArchive:(mode)->
    archiveId=@model.get 'archiveId'
    self=@
    $.post '/generateToken',{},(data)->
      # console.log data
      recorderManager= TB.initRecorderManager(data['apiKey']) 
      if self.player is null
        if mode is 'regular'
          template='<div id="playerElement"></div>'  
          $('#videoPlayer .player').html Mustache.to_html(template,{})
          self.player=self.setupPlayer recorderManager, archiveId, data['token'], 'playerElement', true 
        if mode is 'simple'
          simple_template='<div id="simplePlayerElement"></div>'  
          $('#simplePlayer').html Mustache.to_html(simple_template,{})
          self.player= self.setupPlayer recorderManager, archiveId, data['token'], 'simplePlayerElement', false 
          
      else 
        self.player.loadArchive archiveId 

  setupPlayer:(recorderManager, archiveId, token,divId, autoPlay)->
    player= recorderManager.displayPlayer archiveId, token, divId, {
      width:400,
      height:300,
      autoPlay:autoPlay
    }
    return player
    
    

        
        