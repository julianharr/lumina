class EventsController < ApplicationController
  before_action :find_event, only: [:show]

  def index
    @event = Event.all

    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
    @markers = @event.geocoded.map do |flat|
      {
        lat: flat.latitude,
        lng: flat.longitude,
        infoWindow: render_to_string(partial: 'info_window', locals: { event: flat })
      }
    end
  end

  def show
  end

  private

  def find_event
    @event = Event.find(params[:id])
  end

  def current_user_events
  end
end
