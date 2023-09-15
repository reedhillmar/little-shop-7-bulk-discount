Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  get "/merchants/:merchant_id/dashboard", to: "merchants#show"
  get "/merchants/:merchant_id/items", to: "merchants/items#index"
  get "/merchants/:merchant_id/invoices", to: "merchants/invoices#index"
  get "/merchants/:merchant_id/invoices/:invoice_id", to: "merchants/invoices#show", as: :merchant_invoice

  get "/admin", to: "admin_application#welcome"
  get "/admin/merchants", to: "admin/merchants#index"
  get "/admin/merchants/new", to: "admin/merchants#new"
  get "/admin/merchants/:id", to: "admin/merchants#show"
  get "/admin/merchants/:id/edit", to: "admin/merchants#edit"
  post "/admin/merchants", to: "admin/merchants#create"
  patch "/admin/merchants/:id", to: "admin/merchants#update"

  get "/admin/invoices", to: "admin/invoices#index"
end