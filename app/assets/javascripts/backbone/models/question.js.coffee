class InterviewBox.Models.Question extends Backbone.Model
  paramRoot: 'question'
  url:()->
    return "/getQuestionModel/"+@id
  initialize:(option)->
    @id=option['id']



class InterviewBox.Collections.UserQuestionsCollection extends Backbone.Collection
  model: InterviewBox.Models.Question
  url: ()->
    return "/questions/"+@userId
    
  initialize:(option)->
    @userId=option['userId']


class InterviewBox.Collections.AllQuestionsCollection extends Backbone.Collection
  model: InterviewBox.Models.Question
  url:'/questionsAll'
    

