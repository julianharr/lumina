class EventsController < ApplicationController
  def index
    @event = Event.all

    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    @markers = @event.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude
      }
    end
  end
end
