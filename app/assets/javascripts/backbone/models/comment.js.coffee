class InterviewBox.Models.Comment extends Backbone.Model
  paramRoot: 'comment'

# get comments given a user id 
class InterviewBox.Collections.ResponseCommentsCollection extends Backbone.Collection
  model: InterviewBox.Models.Comment
  url: ()->
    return '/comments/'+@responseId
  
  initialize:(option)->
    @responseId=option['responseId']