class InterviewBox.Views.ArchiveLinkView extends Backbone.View
  template: JST["backbone/templates/lib/question/eachQuestion"]
  a_template: JST["backbone/templates/lib/question/eachQuestion_preview"]
  b_template: JST["backbone/templates/lib/response/eachResponse_a"]
  c_template: JST["backbone/templates/lib/response/eachResponse_b"]
  
  tagName:'li'

      
  events:
    'click .q_preview':'previewVideo'
    'click .r_play':'previewVideo'
    
  initialize:->    
  # render a simple view for a video link
  # without preview link
  render:->
    $(@el).html(@template(@model.toJSON()))
    return this
  # with preview link
  render_a:->
    $(@el).html(@a_template(@model.toJSON()))
    return this
  render_b:->
    self=@
    user=new InterviewBox.Models.User({id:@model.get('user_id')})
    user.fetch success:()->
      self.model.set({twitterId:user.get('uid')})
      $(self.el).html(self.b_template(self.model.toJSON()))
    return this
  
  render_c:->
    self=@
    user=new InterviewBox.Models.User({id:@model.get('user_id')})
    user.fetch success:()->
      self.model.set({twitterId:user.get('uid')})
      $(self.el).html(self.c_template(self.model.toJSON()))
    return this
    

  previewVideo:->
    player=new InterviewBox.Views.VideoPlayer({model:@model})
    $('html').append(player.render().el)
