Rails.application.routes.draw do
  get "/calculations" => "calculations#index"
  get "/calculations/:id" => "calculations#show"
  patch "/calculations/:id" => "calculations#update" # not really
  post "/calculations" => "calculations#create"
  delete "/calculations/:id" => "calculations#destroy"

  get "/champions" => "champions#index"
  get "/abilities" => "abilities#index"
  get "/abilities/:id" => "abilities#show"
  get "items" => "items#index"
end
