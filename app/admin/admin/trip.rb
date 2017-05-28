ActiveAdmin.register Trip, :namespace => :admin do

  actions :all, except: [:show, :destroy]

  index do
    id_column

    column :start_city
    column :station_begin

    column "Дата начала поездки" do |trip|
      trip.start_date.strftime("%d.%m.%Y")
    end

    column "Время начала поездки" do |trip|
      trip.start_date.strftime("%H:%M")
    end

    column :end_city
    column :station_end

    column "Дата окончания поездки" do |trip|
      trip.end_date.strftime("%d.%m.%Y")
    end

    column "Время окончания поездки" do |trip|
      trip.end_date.strftime("%H:%M")
    end

    column :carrier
    column :total_cost
    column :currency

    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Основное" do
      f.input :start_city, as: :select, collection: City.available_collection, input_html: { class: "select2" }
      f.input :station_begin, as: :select, collection: Station.available_collection, input_html: { class: "select2" }
      f.input :start_date, as: :datepicker, datepicker_options: { dateFormat: "dd.mm.yy" }, input_html: { value: f.object.start_date.strftime("%d.%m.%Y") }
      f.input :start_time, as: :time_picker

      f.input :end_city, as: :select, collection: City.available_collection, input_html: { class: "select2" }
      f.input :station_end, as: :select, collection: Station.available_collection, input_html: { class: "select2" }
      f.input :end_date, as: :datepicker, datepicker_options: { dateFormat: "dd.mm.yy" }, input_html: { value: f.object.start_date.strftime("%d.%m.%Y") }
      f.input :end_time, as: :time_picker

      f.input :carrier, as: :select, collection: Carrier.available_collection, input_html: { class: "select2" }
      f.input :total_cost
      f.input :currency, as: :select, collection: Currency.available_collection, input_html: { class: "select2" }
    end

    f.actions
  end

  filter :id
  filter :start_city_id, as: :select, collection: -> { City.available_collection(name_only: true) }, input_html: { class: "select2" }
  filter :station_begin_id, as: :select, collection: -> { Station.available_collection(name_only: true) }, input_html: { class: "select2" }
  filter :start_date
  filter :end_city_id, as: :select, collection: -> { City.available_collection(name_only: true) }, input_html: { class: "select2" }
  filter :station_end_id, as: :select, collection: -> { Station.available_collection(name_only: true) }, input_html: { class: "select2" }
  filter :end_date

  permit_params :start_city, :station_begin, :start_date, :start_time,
    :end_city, :station_end, :end_date, :end_time
end
