GoalsApp::Application.routes.draw do
  resource :session
  resources :users do
    resources :goals, :only => [:show]
  end
  resources :goals, :except => [:show]
end
