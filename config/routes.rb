Rails.application.routes.draw do
  get "/calculations" => "calculations#index"
  get "/calculations/:id" => "calculations#show"
  patch "/calculations/:id" => "calculations#update"
  post "/calculations" => "calculations#create"
  delete "/calculations/:id" => "calculations#destroy"
end
