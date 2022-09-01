Rails.application.routes.draw do

  # public/orders
  post 'orders/confirm'
  get 'orders/complete'
  resources :orders, only: [:new, :index, :show, :create]

  # public/cart_items
  delete 'cart_items/destroy_all'
  resources :cart_items, only: [:index, :update, :destroy, :create]

  # public/customers
  get 'customers/my_page' => 'customers#show'
  get 'customers/information/edit' => 'customers#edit'
  patch 'customers/information' => 'customers#update'
  get 'customers/unsubscribe'
  patch 'customers/withdraw'

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
