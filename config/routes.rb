UrlTrackingApp::Application.routes.draw do

  devise_for :user, :path => '', :path_names => {:sign_in => 'login', :sign_out => 'logout'}

  get 'users/new'

  resources :urls

  resources :dashboards do
    collection do
      get :track
    end
  end

  get 'url_track' => 'dashboards#track'


  authenticated :user, ->(u)  { u } do
    # root to: "urls#index", as: :loggedin_root
    root to: 'dashboards#index', as: :loggedin_root
  end

  devise_scope :user do
    root :to => 'devise/sessions#new'
  end

end
