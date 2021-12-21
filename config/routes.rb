Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  devise_for :users, :controllers => { registrations: 'registrations', sessions: 'sessions' }

  authenticated :user, ->(user) { user.is_admin? } do
    root to: "admin/dashboard#index", as: :admin_root
  end

  authenticated :user, ->(user) { user.is_candidate? } do
    root to: "questions#index", as: :candidate_root
  end

  root to: "questions#index"
  resources :questions, only: [ :index ]
  patch 'submit_answer/:user_id' => 'questions#submit_answer'

  scope module: 'admin', path: 'admin' do
    get 'dashboard' => 'dashboard#index'

    resources :users, except: [ :show ]
    resources :questions, except: [ :show ]
    resources :results, only: [ :index ]
    resources :tests, except: [ :show ]

    get 'users/import' => 'users#import', as: :user_import
    post 'users/import' => 'users#bulk_upload', as: :user_bulk_upload

    get 'questions/import' => 'questions#import', as: :question_import
    post 'questions/import' => 'questions#bulk_upload', as: :question_bulk_upload

    get 'results/active_list' => 'results#active_list', as: :active_candidates
    get 'results/rejected_list' => 'results#rejected_list', as: :rejected_candidates
  end
end
