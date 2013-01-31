
# get user by id
class InterviewBox.Models.User extends Backbone.Model
  paramRoot: 'user'
  url: ()->
    return '/user/'+@id
  
  initialize:(option)->
    @id=option['id']

# get all users
class InterviewBox.Collections.UsersCollection extends Backbone.Collection
  model: InterviewBox.Models.User
  url: '/users'
