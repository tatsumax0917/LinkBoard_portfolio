Rails.application.routes.draw do
  root 'home#top'

  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations'
  }

  devise_scope :user do
    get '/resend_confirmation_email', to: 'devise/confirmations#new'
  end

  scope :users do
    resource :change_password, only: [:edit, :update], controller: 'users/change_password'
    resource :change_email, only: [:edit, :update], controller: 'users/change_email'
    resource :delete_account, only: [:edit, :destroy], controller: 'users/delete_account'
  end

  resources :users, only: [:index]

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  get '/help', to: 'home#help'
  get '/contact' ,to: 'contacts#new'
  post '/contact', to: 'contacts#create'
  get '/:unique_user_id', to: 'users#show', as: :user_profile

end
