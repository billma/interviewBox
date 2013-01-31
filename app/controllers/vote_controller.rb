class VoteController < ApplicationController


  # check to see if a user has voted
  def checkVote
    hasBeenRated=''
    if params[:question_id]!=nil
      q_id=params[:question_id]
      hasBeenRated= !Vote.find(
        :all,
        :conditions=>["user_id=#{cookies[:current_user]} AND question_id=#{q_id}"]
      ).empty?
    elsif params[:response_id]!=nil
      q_id=params[:question_id]
      hasBeenRated= !Vote.find(
        :all,
        :conditions=>["user_id=#{cookies[:current_user]} AND question_id=#{q_id}"]
      ).empty?
    end 
    render :json=>hasBeenRated
  end 
  
  # create a vote
  def upVote
    Vote.create({
      :user_id=>cookies[:current_user],
      :question_id=>params[:question_id],
      :response_id=>params[:response_id]
    })
    render :json=>{}
  end 
  
  # remove a vote 
  def downVote
    if params[:question_id]!=nil
      q_id=params[:question_id]
      Vote.find(
        :all,
        :conditions=>["user_id=#{cookies[:current_user]} AND question_id=#{q_id}"]
      )[0].destroy()
    elsif params[:response_id]!=nil
      r_id=params[:response_id]
      Vote.find(
        :all,
        :conditions=>["user_id=#{cookies[:current_user]} AND question_id=#{r_id}"]
      )[0].destroy()
    end 
    render :json=>{}
  end 


  # get all vote count for a question
  def getVoteCount 
    count=0
    if params[:question_id]!=nil
      count=Question.find(params[:question_id]).vote.length
    elsif params[:response_id]!=nil
      count=Response.find(params[:response_id]).vote.length
    end 
    render :json=> count
    
  end 
end
