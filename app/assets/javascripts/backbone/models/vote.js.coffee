class InterviewBox.Models.Vote extends Backbone.Model
  paramRoot: 'vote'


class InterviewBox.Collections.VotesCollection extends Backbone.Collection
  model: InterviewBox.Models.Vote
  url: '/votes'
