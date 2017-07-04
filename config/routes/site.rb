namespace :site, path: '/', constraints: { subdomain: /.*/ } do

  resources :trips, only: :index

  root to: "welcome#index"
end
