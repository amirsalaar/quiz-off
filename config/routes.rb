Rails.application.routes.draw do

  get '/', { to: 'home#index', as: :root }
  get '/leaderboard', { to: 'leaderboard#index' }
  resources :users, only: [:new, :edit, :update, :create, :dashboard] do
    member do
      get :change_password
      patch :update_password
      get :dashboard
      get :attempts
    end
  end
  
  resource :session, only: [:new, :create, :destroy]

  resources :quizzes do
    resources :questions do
      member do
        post :answer
      end
    end
    member do
      get :finish
      post :attempt
    end
  end

end
