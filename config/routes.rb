Rails.application.routes.draw do
  get '/', to: redirect('/login')
  get '/login', to: 'users#login'
  post '/login', to: 'users#login_post'
  get '/logout', to: 'users#logout'

  resources :users
  get '/users/:id/vcf', to: 'users#vcf'
  get '/users/:id/set-password', to: 'users#set_password'
  get '/users/:id/admin', to: 'users#admin'
  patch '/users/:id/admin', to: 'users#admin_patch'
  get '/users/:id/dashboard', to: 'users#dashboard'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
