class InterviewBox.Views.Comment extends Backbone.View
  template: JST["backbone/templates/lib/comment/eachComment"]
  template_a:JST["backbone/templates/lib/comment/commentForm"]
  template_b:JST["backbone/templates/lib/comment/commentForm_b"]
  
  events:
    'keydown textarea':'enterComment'
    'focusin textarea':'clearDefaultComment'
    'focusout textarea':'setDefaultComment'
    'click .comment_b_list_header':'toggleComments'
  
  
  # option
  # current_user, response_id, 
  initialize:(option)->
    @current_user=option['current_user']
    @response=option['response']
   
  
  listComments:->

  
  # render comment form w/o listing comments
  render_a:->
    $(@el).html(@template_a())
    return this
  # render commebnt form and listing comments
  render_b:->
    self=@
    @toggle=false
    comments=new  InterviewBox.Collections.ResponseCommentsCollection({
      responseId:@response.get('id')
    })
    comments.fetch success:()->
      self.count=comments.length
      msg=''
      msg="Show All ("+self.count+") Comments" if self.count>1
      msg="Show comment ("+self.count+")" if self.count is 1
      $(self.el).html self.template_b({
        showCommentMsg:msg
      })
      comments.each (comment)->
        user=new InterviewBox.Models.User({id:comment.get('user_id')})
        
        user.fetch success:()->
          console.log comment
          uid=user.get('uid')
          # console.log comment

          $(self.el).find('.comment_b_list_content').append self.template({
            uid:uid,
            content:comment.get('content')
          })
      if self.count is 0
        $(self.el).html self.template_b({
          showCommentMsg:''
        })
        self.$('.comment_b_list_header').hide()
    return this
    
  renderComment:->
    $(@el).html(@a_template(@model.toJSON()))
    return this
    
    
  toggleComments:->

    @toggle=!@toggle
    @.$('.comment_b_list').toggle()
    @.$('.link_msg_1').toggle()
    @.$('.link_msg_2').toggle()
    
  enterComment:(e)->
    if e.keyCode is 13
      e.preventDefault()
      content=@.$('textarea').val()
      current_user=@current_user.get('id')
      response_id=@response.get('id')
      @createNewComment current_user, response_id, content
      @clearDefaultComment()
      
  createNewComment:(current_user, response_id, content)->
    self=@
    $.post '/newComment',{
      current_user:current_user,
      response_id:response_id,
      content:content
    },(data)->
      $(self.el).find('.comment_b_list_content').append self.template({
        uid:self.current_user.get('uid'),
        content:data['content']
      })
      console.log self.count
      if self.count>=1 
        self.count+=1
        $(self.el).find('.link_msg_1').html("Show All ("+self.count+") Comments" )
      if self.count is 0
        self.count+=1
        $(self.el).find('.link_msg_1').html("Show comment ("+self.count+")"  )
      self.$('.comment_b_list_header').show()
      if self.toggle is false 
        self.toggleComments()
      
  clearDefaultComment:->
    @.$('textarea').val('')
    
  setDefaultComment:->
    console.log ("..fjdkals")
    @.$('textarea').val('Enter Your Comment...')
  