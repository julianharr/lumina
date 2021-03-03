class EventsController < ApplicationController
  def index
    @event = Event.includes(:user)

    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    @markers = @event.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end
  end
end
