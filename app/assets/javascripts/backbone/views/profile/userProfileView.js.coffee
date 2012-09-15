class InterviewBox.Views.UserProfileView extends Backbone.View
  template : JST["backbone/templates/profile/userProfile"]
  tagName:'div'
  attributes:
    class:'profileContainer'
  events:
    'click #newQuestion':'activateRecorder'
  
  initialize:->
  render:->
    self=@
    @model.fetch success:->
      self.loadTemplate()
    return this
  loadTemplate:->
    $(@el).html(@template(@model.toJSON()))
  
  activateRecorder:->
    recorder=new InterviewBox.Views.Recorder()
    $('html').append(recorder.renderQuestionRecorder().el)
