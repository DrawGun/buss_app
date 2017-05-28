ActiveAdmin.register Trip, :namespace => :admin do

  actions :all, except: [:show, :destroy]

  index do
    id_column

    column :start_city
    column :station_begin
    column :end_city
    column :station_end
    column :carrier
    column :activity

    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Основное" do
      f.input :start_city, as: :select, collection: City.available_collection, input_html: { class: "select2" }
      f.input :station_begin, as: :select, collection: Station.available_collection, input_html: { class: "select2" }
      f.input :end_city, as: :select, collection: City.available_collection, input_html: { class: "select2" }
      f.input :station_end, as: :select, collection: Station.available_collection, input_html: { class: "select2" }
      f.input :carrier, as: :select, collection: Carrier.available_collection, input_html: { class: "select2" }
    end

    f.actions
  end

  filter :id
  filter :start_city_id, as: :select, collection: -> { City.available_collection(name_only: true) }, input_html: { class: "select2" }
  filter :station_begin_id, as: :select, collection: -> { Station.available_collection(name_only: true) }, input_html: { class: "select2" }
  filter :end_city_id, as: :select, collection: -> { City.available_collection(name_only: true) }, input_html: { class: "select2" }
  filter :station_end_id, as: :select, collection: -> { Station.available_collection(name_only: true) }, input_html: { class: "select2" }

  permit_params :start_city_id, :station_begin_id, :end_city_id, :station_end_id,
    :carrier_id

  controller do
    def scoped_collection
      super.includes(:start_city, :end_city, :station_begin, :station_end, :carrier)
    end
  end
end
