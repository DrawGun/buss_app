namespace :site, path: '/', constraints: { subdomain: /.*/ } do


  root to: "welcome#index"
end
