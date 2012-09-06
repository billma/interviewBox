class InterviewBox.Views.QuestionList extends Backbone.View
  template: JST["backbone/templates/lib/question/questionList"]
  a_template: JST["backbone/templates/lib/question/questionList_a"]
  b_template : JST["backbone/templates/lib/question/questionList_b"]

  initialize:(option)->
    @questions= option['collection']
    @clear='<div style="clear:both;"></div>'
    
  # renderAll
  render:->
    $(@el).html(@template())
    @loadByTime()
    return this
  
  # renderByType
  render_a:->
    $(@el).html(@a_template())
    @loadByType()
    return this
    
  # render questions for a user (page profile)
  render_b:->
    $(@el).html(@b_template())
    @loadByUser()
    return this
  

  loadByTime:->
    self=@
    @questions.fetch success:->
      self.questions.each (question)->
        linkView=new InterviewBox.Views.ArchiveLinkView({model:question})
        $('#listByTime').append(linkView.render_a().el)
      $('#listByTime').append(self.clear)

    
  loadByType:->
    self=@
    @questions.fetch success:->
      self.questions.each (question)->
        linkView=new InterviewBox.Views.ArchiveLinkView({model:question})
        type= question.get('questionType')
        selector=$('#byType').find("."+type).find('.content')
        selector.append linkView.render_a().el
      $('#byType .algorithm .content').append(self.clear)
      $('#byType .technical .content').append(self.clear)
     

  loadByUser:->
    self=@
    @questions.fetch success:()->
      self.questions.each (question)->
        newLink=new InterviewBox.Views.ArchiveLinkView({model:question})
        $('#QlistContainer').append newLink.render_d().el
      $('#QlistContainer').append self.clear
    error:()->
      console.log "error"

    
      

          
        
        
    