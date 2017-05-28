ActiveAdmin.register TripItem, :namespace => :admin do

  actions :all, except: [:show, :destroy]

  index do
    id_column

    column "Маршрут" do |trip_item|
      trip_item.trip_description
    end

    column "Перевозчик" do |trip_item|
      trip_item.trip_carrier_name
    end

    column "Дата начала поездки" do |trip_item|
      trip_item.start_date.strftime("%d.%m.%Y")
    end

    column "Время начала поездки" do |trip_item|
      trip_item.start_date.strftime("%H:%M")
    end

    column "Дата окончания поездки" do |trip_item|
      trip_item.end_date.strftime("%d.%m.%Y")
    end

    column "Время окончания поездки" do |trip_item|
      trip_item.end_date.strftime("%H:%M")
    end

    column :total_cost
    column :currency

    actions
  end

  form do |f|
    f.semantic_errors *f.object.errors.keys
    f.inputs "Основное" do
      f.input :trip, as: :select, collection: Trip.available_collection, input_html: { class: "select2" }
      f.input :start_date, as: :datepicker, datepicker_options: { dateFormat: "dd.mm.yy" }, input_html: { value: f.object.start_date.strftime("%d.%m.%Y"), id: "start_date" }
      f.input :start_time, as: :time_picker

      f.input :end_date, as: :datepicker, datepicker_options: { dateFormat: "dd.mm.yy" }, input_html: { value: f.object.end_date.strftime("%d.%m.%Y"), id: "end_date" }
      f.input :end_time, as: :time_picker

      f.input :total_cost
      f.input :currency, as: :select, collection: Currency.available_collection, input_html: { class: "select2" }
    end

    f.actions
  end

  filter :id
  filter :start_date
  filter :end_date

  controller do
    def scoped_collection
      super.includes(:currency, trip: [:start_city, :station_begin, :end_city, :station_end, :carrier])
    end
  end

  permit_params :start_date, :start_time, :end_date, :end_time, :total_cost,
    :currency_id, :trip_id
end
