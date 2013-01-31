class InterviewBox.Models.Vote extends Backbone.Model
  paramRoot: 'vote'


# get all votes
class InterviewBox.Collections.VotesCollection extends Backbone.Collection
  model: InterviewBox.Models.Vote
  url: '/votes'
