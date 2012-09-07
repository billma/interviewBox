InterviewBox::Application.routes.draw do


  root :to => 'pages#login'
  match '/index'=>'test#index'
  match '/auth/twitter/callback' =>'session#create'
  match '/logout'=>'session#destroy'
  match '/generateToken'=>'session#generateToken'
  
  match '/uploadImage'=>'upload#uploadImage'
  
  match '/home' => 'pages#home'
  match '/profile'=>'pages#profile'
  
  match '/new_user' => 'user#new'
  match '/create_user' => 'user#create'
  match '/users'=>'user#users'
  match '/user/:id'=>'user#user'
  
  match '/newQuestion'=>'question#new'
  match '/createQuestion'=>'question#create'
  match '/questions/:userId'=>'question#questions'
  match '/questionsAll'=>'question#all'
  match '/showQuestion/:id'=>'question#show'
  match '/getQuestionModel/:id'=>"question#getModel"
  
  match '/newResponse'=>'response#new'
  match '/responsesAll'=>'response#all'
  match '/responses/:questionId'=>'response#responses'
  match '/responses_user/:userId'=>'response#userReponses'
  
  
  match '/newComment'=>'comment#new'
  match '/comments/:responseId'=>'comment#getCommentByResponse'
  
  match '/checkVote'=>'vote#checkVote'

  match '/upVote'=>'vote#upVote'
  match '/downVote'=>'vote#downVote'
  match '/getVoteCount'=>'vote#getVoteCount'
  
  match '/pusher/auth'=>'pusher#auth'
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
