require "pry-byebug"
# app/services/tweet_creator.rb
# https://www.toptal.com/ruby-on-rails/rails-service-objects-tutorial
# https://developers.tickettailor.com/?ruby#ticket-tailor-api

class ApiCrawler
  attr_reader :event

  def initialize(event)
    @event = event
  end

  def hit_event_finder_api(_event)
    # https://www.eventbrite.com/platform/api#/introduction/about-our-api
    auth = { username: ENV['EVENT_F_USER'], password: ENV['EVENT_F_PASS'] }
    response = HTTParty.get('https://api.eventfinda.com.au/v2/events.json?rows=2', basic_auth: auth)
  end

  def meetup_api_get
  end
end

# def send_tweet
#   client = Twitter::REST::Client.new do |config|
#     config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
#     config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
#     config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
#     config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
#   end
#   client.update(@message)
# end

# find = ApiCrawler.new("event")
# p find
# binding.pry

# require 'rest-client'
# require 'json'

# headers = {
#  'Accept' => 'application/json',
#  'Authorization' => 'Basic VGlja2V0VGFpbG9y'
# }

# result = RestClient.get '/v1/orders?limit=1',
#  headers

# p JSON.parse(result)
