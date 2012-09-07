class InterviewBox.Views.ResponseList extends Backbone.View
  template: JST["backbone/templates/lib/response/responseList"]

  initialize:(option)->
    @responses=option['collection']
    @current_user=option['currentUser']
    @clear='<div style="clear:both;"></div>'
  
  
  render:->
    $(@el).html(@template())
    @List_a()
    return this
    
  render_b:->
    $(@el).html(@template())
    @list_b()
    return this
  # list response with an user icon and commentbox
  List_a:->
    self=@

    @responses.fetch success:()->
      self.responses.each (response)->
        console.log 'ResponseList -> list_a...'
        console.log self.current_user
        responseView=new InterviewBox.Views.ArchiveLinkView({
          model:response,
          current_user:self.current_user
        })
        self.$('.RlistContainer').append responseView.render_b().el
      self.$('.RlistContainer').append self.clear
  
  # list respoinse without an user icon
  list_b:->
    self=@
    @responses.fetch success:()->
      self.responses.each (response)->
        responseView=new InterviewBox.Views.ArchiveLinkView({model:response})
        self.$('.RlistContainer').append responseView.render_c().el
      self.$('.RlistContainer').append self.clear
    
    
        