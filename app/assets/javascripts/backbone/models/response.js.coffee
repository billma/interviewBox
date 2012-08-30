class InterviewBox.Models.Response extends Backbone.Model
  paramRoot: 'response'

class InterviewBox.Collections.QResponsesCollection extends Backbone.Collection
  model: InterviewBox.Models.Response
  url: ()->
    return "/responses/"+@questionId
    
  initialize:(option)->
    @questionId=option['questionId']
class InterviewBox.Collections.UserResponsesCollection extends Backbone.Collection
  model: InterviewBox.Models.Response
  url: ()->
    return "/responses_user/"+@userId
    
  initialize:(option)->
    @userId=option['userId']

class InterviewBox.Collections.AllResponsesCollection extends Backbone.Collection
  model: InterviewBox.Models.Response
  url: '/responsesAll'
