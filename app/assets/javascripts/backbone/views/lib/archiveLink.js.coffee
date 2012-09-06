class InterviewBox.Views.ArchiveLinkView extends Backbone.View
  template: JST["backbone/templates/lib/question/eachQuestion_simple"]
  a_template: JST["backbone/templates/lib/question/eachQuestion_fullView"]
  b_template: JST["backbone/templates/lib/response/eachResponse_icon"]
  c_template: JST["backbone/templates/lib/response/eachResponse_download"]
  d_template: JST["backbone/templates/lib/question/eachQuestion_download"]
  
  
  tagName:'li'

      
  events:
    'click .q_preview':'previewVideo'
    'click .r_preview':'previewVideo'
    
  initialize:(option)->
    @current_user=option['current_user']


    
    
  # list a question w/o preview 
  render:->
    $(@el).html(@template(@model.toJSON()))
    
    return this
  # list a question w preview
  render_a:->
    $(@el).html(@a_template(@model.toJSON()))
    @.$('div.timeago').timeago()
    return this
 
  # list a response with user icon (for showquestion page)
  render_b:->
    self=@
    user=new InterviewBox.Models.User({id:@model.get('user_id')})
    user.fetch success:()->
      self.model.set({twitterId:user.get('uid')})
      $(self.el).html(self.b_template(self.model.toJSON()))
      
      comment=new InterviewBox.Views.Comment({
        response:self.model,
        current_user:self.current_user
      })
      self.$('.responseComment').append(comment.render_b().el)
    @.$('div.timeago').timeago()
    return this
    
  # list a reponse w/o user icon (for profile page)
  render_c:->
    $(@el).html(@c_template(@model.toJSON()))
    @.$('div.timeago').timeago()
    return this
  
  # render a question with download button
  render_d:->
    $(@el).html(@d_template(@model.toJSON()))
    @.$('div.timeago').timeago()
    return this

  previewVideo:->
    player=new InterviewBox.Views.VideoPlayer({model:@model})
    $('html').append(player.render().el)
