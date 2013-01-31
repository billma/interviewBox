

# name: responselist
# purpose:  handles all rendering tasks
#           related to response listing

class InterviewBox.Views.ResponseList extends Backbone.View
  template: JST["backbone/templates/lib/response/responseList"]

  initialize:(option)->
    @responses=option['collection']
    @current_user=option['currentUser']
    @clear='<div style="clear:both;"></div>'
  
  
  # list response with an user icon and commentbox
  render:->
    $(@el).html(@template())
    @List_a()
    return this
    
  # list response without an user icon
  render_b:->
    $(@el).html(@template())
    @list_b()
    return this
  #-----------------
  # private methods
  # ----------------
  List_a:=>
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
  
  list_b:=>
    self=@
    @responses.fetch success:()->
      self.responses.each (response)->
        responseView=new InterviewBox.Views.ArchiveLinkView({model:response})
        self.$('.RlistContainer').append responseView.render_c().el
      self.$('.RlistContainer').append self.clear
    
    
        
