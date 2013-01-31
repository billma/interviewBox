

class InterviewBox.Models.Response extends Backbone.Model
  paramRoot: 'response'


# get all responses that belongs to a question
class InterviewBox.Collections.QResponsesCollection extends Backbone.Collection
  model: InterviewBox.Models.Response
  url: ()->
    return "/responses/"+@questionId
    
  initialize:(option)->
    @questionId=option['questionId']

# get all reponses that belongs to a user
class InterviewBox.Collections.UserResponsesCollection extends Backbone.Collection
  model: InterviewBox.Models.Response
  url: ()->
    return "/responses_user/"+@userId
    
  initialize:(option)->
    @userId=option['userId']

# get all reponses
class InterviewBox.Collections.AllResponsesCollection extends Backbone.Collection
  model: InterviewBox.Models.Response
  url: '/responsesAll'
