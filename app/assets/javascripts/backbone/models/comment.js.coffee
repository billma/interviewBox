class InterviewBox.Models.Comment extends Backbone.Model
  paramRoot: 'comment'

# get comments by response 
# collection contain all comments 
# on a give response
class InterviewBox.Collections.ResponseCommentsCollection extends Backbone.Collection
  model: InterviewBox.Models.Comment
  url: ()->
    return '/comments/'+@responseId
  
  initialize:(option)->
    @responseId=option['responseId']
