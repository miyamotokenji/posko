Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'sessions#new'
  delete 'sign_out' => 'sessions#destroy'
  get 'sign_out' => 'sessions#destroy'
  get 'sign_in' => 'sessions#new'
  post 'sign_in' => 'sessions#create'
  get 'sign_up' => 'accounts#new'
  post 'sign_up' => 'accounts#create'
  get 'dashboard' => 'pages#dashboard'
  resources :accounts, only: [:create]
  resources :users, shallow: true do
    resources :shifts, shallow: true do
      resources :shift_activities
      member do
        get :end_shift
        patch :finalize_shift
      end
    end
  end
  resources :products, shallow: true do
    collection do
      get :import_modal
      post :import
    end
    resources :variants, shallow: true do
      resources :components
    end
  end
  resources :customers
  resources :invoices
  resources :roles

  constraints format: 'json' do
    namespace :api do
      namespace :v1 do
        post 'sign_in' => 'auth#sign_in'
        resources :users
        resources :access_keys
        resources :customers
        resources :products, shallow: true do
          resources :variants, shallow: true do
            resources :components
          end
        end
        resources :invoices, shallow: true do
          resources :invoice_lines
        end
      end
    end
  end
end
