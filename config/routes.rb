Rails.application.routes.draw do
  get 'auth/failure', to: 'authentications#failure'
  get 'auth/:provider/callback', to: 'authentications#login'
  post 'auth/:provider/callback', to: 'authentications#login'
  delete 'logout' => 'authentications#logout'
  post 'forgot_password' => 'users#forgot_password'
  post 'reset_password' => 'users#reset_password'

  resources :users, only: [:create, :show] do
    get 'info', on: :collection
    get 'unlock', on: :collection
  end

  resources :logins do
    get 'resend_confirmation', on: :collection, action: 'begin_resend_confirmation'
    post 'resend_confirmation', on: :collection
    get 'confirm_email', on: :collection
    get 'forgot_password', on: :collection, action: 'begin_forgot_password'
    post 'forgot_password', on: :collection
    get 'reset_password', on: :collection, action: 'begin_reset_password'
    post 'reset_password', on: :collection
  end
end
