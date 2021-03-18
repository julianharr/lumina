require 'open-uri'
require 'json'
require 'uri'
require 'net/http'
require 'date'
# rubocop:disable Metrics/ClassLength
class EventsController < ApplicationController
  before_action :find_event, only: [:show]
  before_action :c_user, only: [:show]

  def index
    if params[:query].present?
      @results = Geocoder.search(params[:query]).first.coordinates
      # @bikes is now ready to parse =>
      @event = Event.near(@results, 8)
      ## @event = Event.where('name ILIKE ?', "%#{params[:query]}%")
      @markers = @event.geocoded.map do |flat|
        {
          lat: flat.latitude,
          lng: flat.longitude,
          infoWindow: render_to_string(partial: 'info_window', locals: { event: flat })
        }
      end
    else
      @event = Event.all
      @markers = @event.geocoded.map do |flat|
        {
          lat: flat.latitude,
          lng: flat.longitude,
          infoWindow: render_to_string(partial: 'info_window', locals: { event: flat })
        }
      end
    end
    # the `geocoded` scope filters only flats with coordinates (latitude & longitude)
  end

  def show
  end

  def rsvp
    c_user
    find_event_rsvp
    c_user_meetup_token
    join_meetup_group(c_user_meetup_token, @event)
    if rsvp_to_event(c_user_meetup_token, @event, 'yes') == true
      update_rsvp_count(@event)
      redirect_to event_path(@event), notice: "You have RSVP to the #{@event.name} :)"
    else
      flash[:alert] = "Could not RSVP to #{@event.name}"
    end
  end

  def remove_rsvp
    c_user
    find_event_rsvp
    c_user_meetup_token
    if rsvp_to_event(c_user_meetup_token, @event, 'no') == true
      update_rsvp_count_down(@event)
      redirect_to event_path(@event), notice: "You are no longer going to #{@event.name} :)"
    else
      flash[:alert] = "Could not remove RSVP to #{@event.name}"
    end
  end

  private

  def find_event
    @event = Event.find(params[:id])
  end

  def find_event_rsvp
    @event = Event.find(params[:format])
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

  def join_meetup_group(token, event)
    event_url = event.group_url
    bearer = token

    url = URI("https://api.meetup.com/#{event_url}/members")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request['Accept'] = 'application/json'
    request['Authorization'] = "Bearer #{bearer}"
    request['Cookie'] = 'MEETUP_AFFIL=affil=meetup; MEETUP_BROWSER_ID="id=8f29c91f-3033-4eda-a298-190fc2071d55"; MEETUP_CSRF=dbccdafc-8e61-4007-9a5a-4c92c81dbdc5; MEETUP_MEMBER="id=154567222&status=4&timestamp=1614293651&bs=0&tz=Australia%2FMelbourne&zip=meetup2&country=au&city=Melbourne&state=&lat=-37.81&lon=144.96&ql=false&s=802d872fc49dd2c821523298ccdec801cad92d53&scope=ALL"; MEETUP_TRACK=id=5e0859a6-c334-4f2b-bd73-818934553be7&l=1&s=a7bf3696ab6fe266da7143de4cb39f9fc2698c45; SIFT_SESSION_ID=20670450-2624-4174-a947-cce0ab741e54'

    response = https.request(request)
    result = JSON.parse(response.body) # result has
  end

  def rsvp_to_event(token, event, answer)
    event_url = event.group_url
    event_num = event.meetup_event_id
    response = answer
    bearer = token

    url = URI("https://api.meetup.com/#{event_url}/events/#{event_num}/rsvps?response=#{response}")

    https = Net::HTTP.new(url.host, url.port)
    https.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request['Accept'] = 'application/json'
    request['Authorization'] = "Bearer #{bearer}"
    request['Cookie'] = 'MEETUP_AFFIL=affil=meetup; MEETUP_BROWSER_ID="id=8f29c91f-3033-4eda-a298-190fc2071d55"; MEETUP_CSRF=dbccdafc-8e61-4007-9a5a-4c92c81dbdc5; MEETUP_MEMBER="id=154567222&status=4&timestamp=1614293651&bs=0&tz=Australia%2FMelbourne&zip=meetup2&country=au&city=Melbourne&state=&lat=-37.81&lon=144.96&ql=false&s=802d872fc49dd2c821523298ccdec801cad92d53&scope=ALL"; MEETUP_TRACK=id=5e0859a6-c334-4f2b-bd73-818934553be7&l=1&s=a7bf3696ab6fe266da7143de4cb39f9fc2698c45; SIFT_SESSION_ID=20670450-2624-4174-a947-cce0ab741e54'
    response = https.request(request)

    result = JSON.parse(response.body) # result has
    p result&.key?('response') && result&.value?(answer) ? true : false
  end

  def update_rsvp_count(event)
    attendees = event.attendees
    attendees += 1
    event.update(attendees: attendees)
    Attendevent.create(
      user_id: @user.id,
      event_id: event.id
    )
  end

  def update_rsvp_count_down(event)
    attendees = event.attendees
    attendees -= 1
    event.update(attendees: attendees)
    ## find the sucker
    thing_to_kill = Attendevent.where(user_id: @user.id, event_id: event.id).first
    thing_to_kill.destroy
  end

  def event_questions(event)
    event.group_questions.each { |question| question }
  end
end
