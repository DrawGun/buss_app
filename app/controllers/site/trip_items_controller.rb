class Site::TripItemsController < Site::BaseController
  respond_to :json
  before_action :set_trip_items

  def index
    respond_with @trip_items, each_serializer: Site::TripItemSerializer
  end

  private

  def set_trip_items
    trips = if params[:filter] == "all"
      Trip.daily
    else
      Trip.by_wday(params[:filter])
    end

    @trip_items = TripItem.sorted_by_start_date.where(trip_id: trips.pluck(:id))
      .page(params[:page].to_i).per(30)
  end
end
