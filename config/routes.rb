Rails.application.routes.draw do
  # Hacker Blank/Funny page
  get '/proxyheader.php', to: 'dev/hacker#blank'
  get '/dbadmin/', to: 'dev/hacker#blank'
  get '/myadmin/', to: 'dev/hacker#blank'
  get '/mysqladmin/', to: 'dev/hacker#blank'
  get '/sqlweb/', to: 'dev/hacker#blank'
  get '/webadmin/', to: 'dev/hacker#blank'
  get '/phppgadmin/*section', to: 'dev/hacker#blank'

  ## Devise flagrun.net/auth/
  devise_for :users, module: 'auth', path: '/auth/',
             path_names: {
                 sign_in:      'login',
                 sign_out:     'logout',
                 registration: 'register'
             }

  # ## Account
  # namespace :account do
  #   root to: 'profile#index'
  #   resources :setting
  #   resources :profile
  # end

  ########################################################
  ## flagrun.net/?/id
  # A - Articles
  # resources :articles, path: '/a/'
  # B -
  # C - Comments
  # opinio_model path: '/c/'

  # D -
  # E -
  # F - Forums
  namespace :forum, path:'/f/' do
    resources :categories, path: '/c/', :except => [:index, :show]
    resources :forums, path: '/', :except => :index do
      root :to => 'categories#index', :via => :get
    end
    resources :topics, path: ':forum_id/t/', :except => :index
    resources :posts, path: ':forum_id/t/:topic_id/p/', :except => [:index, :show]

    get ':forum_id/readall', to: 'forums#readall', as: :readall

  end

  # G - Groups
  # H - Help
  # resources :help
  # I - Information
  # J -
  # K -
  # L - Links
  # M - Messages
  # N - Notices
  # O - Operator (Staff)
  namespace :operator, path: '/o/' do
    root to: 'base#index'
  end

  # P - Projects
  # namespace :projects, path: '/p/' do
  # end
  # Q -
  get '/q/*id' => 'static#show', :as => :static, :format => false

  # R -
  # S - System
  namespace :system, path: '/s/' do
    root to: 'base#index'
    # News
    resources :news do
    end
  end

  # T -
  # U - Users
  get '/u/system' => redirect('/s/')

  resources :users, path: '/u/' do
    get 'password', to: 'users#password', as: :change_password
    # get ':forum_id/readall', to: 'forums#readall', as: :readall
    # resources :blog
    # resources :media, path: 'x'
  end

  # V -
  # W -
  # X - Transfer
  # namespace :media, path: '/x/' do
  #   root to: 'base#index'
  #   #resources :files
  #   #resources :music
  #   #resources :photos
  # end

  # Y -
  # Z - Developer Tools
  namespace :dev, path: '/z/' do
    root :to => 'dev#index'
    get '/todo/', to: 'dev#todo'
  end

  ##
  ########################################################
  ## Root
  root :to => 'system/news#index'

end
