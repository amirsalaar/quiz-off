Rails.application.routes.draw do

  get '/', { to: 'home#index', as: :root }
  resources :users, only: [:new, :edit, :update, :create]
  resource :session, only: [:new, :create, :destroy]

  resources :quizzes do
    resources :questions
  end

end
