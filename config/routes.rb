Rails.application.routes.draw do

  post 'orders/confirm'
  get 'orders/complete'
  resources :orders, only: [:new, :index, :show, :create]

  namespace :public do
    get 'cart_items/index'
  end

  namespace :public do
    get 'customers/show'
    get 'customers/edit'
    get 'customers/unsubscribe'
  end

  namespace :public do
    get 'items/index'
    get 'items/show'
  end

  namespace :public do
    get 'homes/top'
    get 'homes/about'
  end

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: "admin/sessions"
  }

end
