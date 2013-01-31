InterviewBox::Application.routes.draw do

  root :to => 'pages#login'

  # session and twitter authentication
  
  match '/index'=>'test#index'
  match '/auth/twitter/callback' =>'session#create'
  match '/logout'=>'session#destroy'
  match '/generateToken'=>'session#generateToken'
  match '/getDownloadLink'=>'session#getDownloadLink'
  
  # aws image upload 
  match '/uploadImage'=>'upload#uploadImage'
  
  # pages url  
  match '/home' => 'pages#home'
  match '/profile'=>'pages#profile'
 
  # user url 
  match '/new_user' => 'user#new'
  match '/create_user' => 'user#create'
  match '/users'=>'user#users'
  match '/user/:id'=>'user#user'
 
  # question url 

  match '/newQuestion'=>'question#new'
  match '/createQuestion'=>'question#create'
  match '/questions/:userId'=>'question#questionsByUser'
  match '/questionsByType/:type'=>'question#questionsByType'
  match '/questionsAll'=>'question#all'
  match '/showQuestion/:id'=>'question#show'
  match '/getQuestionModel/:id'=>"question#getModel"
  
  # response url 
  match '/newResponse'=>'response#new'
  match '/responsesAll'=>'response#all'
  match '/responses/:questionId'=>'response#responses'
  match '/responses_user/:userId'=>'response#userReponses'
  
  # comment url  
  match '/newComment'=>'comment#new'
  match '/comments/:responseId'=>'comment#getCommentByResponse'
  
  # vote url 
  match '/checkVote'=>'vote#checkVote'
  match '/upVote'=>'vote#upVote'
  match '/downVote'=>'vote#downVote'
  match '/getVoteCount'=>'vote#getVoteCount'


  #pusher url
  match '/pusher/auth'=>'pusher#auth'
end
