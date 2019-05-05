Rails.application.routes.draw do

  get '/', { to: 'home#index', as: :root }
  get '/leaderboard', { to: 'leaderboard#index' }
  resources :users, only: [:new, :edit, :update, :create] do
    member do
      get :change_password
      patch :update_password
    end
  end
  
  resource :session, only: [:new, :create, :destroy]

  resources :quizzes do
    resources :questions
  end

end
