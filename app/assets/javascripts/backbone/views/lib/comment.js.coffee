class InterviewBox.Views.Comment extends Backbone.View
  template: JST["backbone/templates/lib/comment/commentForm"]
  a_template:JST["backbone/templates/lib/comment/eachComment"]
  
  initialize:->
    
  renderForm:->
    $(@el).html(@template())
    return this

  renderComment:->
    $(@el).html(@a_template(@model.toJSON()))
    return this