namespace :site, path: '/', constraints: { subdomain: /.*/ } do

  resources :trip_items, only: :index

  root to: "welcome#index"
end
