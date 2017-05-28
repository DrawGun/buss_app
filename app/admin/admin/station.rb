ActiveAdmin.register Station, :namespace => :admin do

  actions :all, except: [:show, :destroy]

  scope :all, default: true

  index do
    id_column

    column :name
    column :city

    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs 'Основное' do
      f.input :name
      f.input :city_id, as: :select, collection: City.available_collection, input_html: { class: 'select2' }
    end

    f.actions
  end

  filter :id
  filter :name, as: :select, collection: -> { Station.available_collection }, input_html: { class: 'select2' }

  controller do
    before_action :update_places_scopes, only: :index

    def update_places_scopes
      City.sorted.find_each do |city|
        scope_type =  Translit.convert(city.name)
        active_admin_config.scopes << (
          ActiveAdmin::Scope.new(scope_type) do |scope|
            scope.where(city_id: city.id)
          end
        ) unless active_admin_config.scopes.map(&:name).include?(scope_type)
      end
    end
  end

  permit_params :name, :city_id
end
