Rails.application.routes.draw do
  resources :transactions, except: :destroy do
    collection do
      get '/new/:type', to: 'transactions#new_type', as: 'new_type', constraints: { type: /credit|debit|transfer/}
    end
    member do
      get '/chargeback', to: 'transactions#chargeback', as: 'chargeback'
    end
  end

  resources :bank_accounts do
    collection do
      patch '/change-current-account', to: 'bank_accounts#change_current_account', as: 'change_current_account'
    end
  end

  resources :bank_agencies
  root 'pages#home'

  devise_for :users
end
