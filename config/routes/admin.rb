get "/" => "admin/dashboard#index", :constraints => { :subdomain => "admin" }
constraints :subdomain => "admin", :namespace => :admin, path: "/" do; end

scope module: :admin do
  namespace :admin do

  end
end
