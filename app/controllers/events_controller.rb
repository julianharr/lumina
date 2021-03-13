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

  def rsvp
    c_user
    # find group and join it
    # https://www.meetup.com/meetup_api/docs/:urlname/members/#create
    ## get user creds
    # hit endpoint
    #
    # POST
    # 276721744
    #  Melbourne-Startup-Idea-to-IPO
    #  https://secure.meetup.com/meetup_api/console/?path=/:urlname/events/:event_id/rsvps
  end

  private

  def find_event
    @event = Event.find(params[:id])
  end

  def find_by_user
    User.find_by(id: params[:format])
  end

  def c_user
    @user = current_user
  end

  def c_user_meetup_token
    c_user
    @service = Service.where(provider: 'meetup', user_id: @user.id).first
    @service.access_token
  end

  def c_user_has_meetup?
    @user.services.each do |element|
      return true if element.provider == 'meetup'
    end
  end

  def join_meetup_group
  end

  def rsvp_to_event
  end

  def update_rsvp_count
  end
end
