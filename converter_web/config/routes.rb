Rails.application.routes.draw do
  get 'convert/index'
  
  root 'convert#index'

  post "convert/index" => "convert#convert"
end
