Rails.application.routes.draw do

  get '/', { to: 'home#index', as: :root }
  get '/leaderboard', { to: 'leaderboard#index' }
  resources :users, only: [:new, :edit, :update, :create, :dashboard] do
    resources :attempts #, only: [:create, :update, :destroy]
    member do
      get :change_password
      patch :update_password
      get :dashboard
    end
  end
  
  resource :session, only: [:new, :create, :destroy]

  resources :quizzes do
    resources :questions do
      member do
        post :answer
      end
    end
  end

end
