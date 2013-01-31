
# get question by id
class InterviewBox.Models.Question extends Backbone.Model
  paramRoot: 'question'
  url:()->
    return "/getQuestionModel/"+@id
  initialize:(option)->
    @id=option['id']


# all questions from a user
class InterviewBox.Collections.UserQuestionsCollection extends Backbone.Collection
  model: InterviewBox.Models.Question
  url: ()->
    return "/questions/"+@userId
    
  initialize:(option)->
    @userId=option['userId']

# get questions by type
class InterviewBox.Collections.TypeQuestionsCollection extends Backbone.Collection
  model: InterviewBox.Models.Question
  url: ()->
    return "/questionsByType/"+@type
    
  initialize:(option)->
    @type=option['type']

    
# get all questions    
class InterviewBox.Collections.AllQuestionsCollection extends Backbone.Collection
  model: InterviewBox.Models.Question
  url:'/questionsAll'
    

