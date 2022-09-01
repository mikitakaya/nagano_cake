Rails.application.routes.draw do

  # public/orders
  post 'orders/confirm' => "orders#confirm", as: "confirm"
  get 'orders/complete' => "orders#complete", as: "complete"
  resources :orders, only: [:new, :index, :show, :create]

  # public/cart_items
  delete 'cart_items/destroy_all' => "cart_items#destroy_all", as: "destroy_all"
  resources :cart_items, only: [:index, :update, :destroy, :create]

  # public/customers
  get 'customers/my_page' => 'customers#show', as: "show"
  get 'customers/information/edit' => 'customers#edit', as: "edit"
  patch 'customers/information' => 'customers#update', as: "update"
  get 'customers/unsubscribe' => "customers#unsubscribe", as: "unsubscribe"
  patch 'customers/withdraw' => "customers#withdraw", as: "withdraw"

  # public/items
  resources :items, only: [:index, :show]

  # public/homes
  root to: 'homes#top'
  get 'about' => "homes#about", as: "about"

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
