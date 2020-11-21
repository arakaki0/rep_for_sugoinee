Rails.application.routes.draw do

  post "like/:post_id/destroy" => "like#destroy"
  post "like/:post_id/create" => "like#create"

  get "logout" => "user#logout"
  post "login" => "user#login"
  get "login" => "user#login_form"
  post "user/update/:id" => "user#update"
  get "user/edit/:id" => "user#edit"
  post "user/create" => "user#create"
  get "user/signup" => "user#signup"
  get 'user/index' => "user#index"
  get "user/:id" => "user#show"

  post "post/destroy/:id" => "post#destroy"
  post "post/:id/update" => "post#update"
  get "post/edit/:id" => "post#edit"
  post "post/create" => "post#create"
  get "post/new" => "post#new"
  get "post/index" => "post#index"
  get "post/:id" => "post#show"

  get "/" => "home#top"
  get "about" => "home#about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
