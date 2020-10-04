Rails.application.routes.draw do
  root 'main#index'
  post '/' => "main#create"

  get ':token' => 'main#redirect'
  get ':token/info' => 'main#info'
end
