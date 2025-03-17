Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    resources :dashboard
    resources :users
    resources :members do
      member do
        patch :redeem 
      end
    end
    resources :services
    resources :coupons
    resources :appointments
    resources :users
  end

  namespace :member do
    resources :dashboard
    resources :members do
      member do
        patch :redeem 
      end
    end
    resources :services
    resources :coupons
    resources :appointments
  end

  root "admin/dashboard#index"
end
