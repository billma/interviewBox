class InterviewBox.Views.ResponseList extends Backbone.View
  template: JST["backbone/templates/lib/response/responseList"]
  b_template: JST["backbone/templates/lib/response/responseList_b"]
  initialize:(option)->
    @responses=option['collection']
    @clear='<div style="clear:both;"></div>'
  render:->
    $(@el).html(@template())
    @List_a()
    return this
  render_b:->
    $(@el).html(@b_template())
    @list_b()
    return this

  List_a:->
    self=@
    @responses.fetch success:()->
      self.responses.each (response)->
        responseView=new InterviewBox.Views.ArchiveLinkView({model:response})
        self.$('.RlistContainer').append responseView.render_b().el
      self.$('.RlistContainer').append self.clear
      
  list_b:->
    self=@
    @responses.fetch success:()->
      self.responses.each (response)->
        responseView=new InterviewBox.Views.ArchiveLinkView({model:response})
        self.$('.RlistContainer').append responseView.render_c().el
      self.$('.RlistContainer').append self.clear
    
    
        