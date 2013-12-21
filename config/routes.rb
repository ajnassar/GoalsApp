GoalsApp::Application.routes.draw do
  resource :session

  resources :users do
    resources :goals, :only => [:show]
  end

  resources :goals, :except => [:show] do
    resources :cheers, :only => [:create, :destroy]
  end
end
