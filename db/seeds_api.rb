require "open-uri"
require 'json'
require "uri"
require "net/http"

url = URI("https://secure.meetup.com/oauth2/authorize?client_id=oleeh69n9arija6n2vo9p5g2e4&response_type=anonymous_code&redirect_uri=https://love-lumina.me")
parsed_url = URI.parse url
https = Net::HTTP.new(parsed_url.host, parsed_url.port)
https.use_ssl = true

request = Net::HTTP::Get.new(url)
request["Content-Type"] = "application/json"

response = https.request(request)
puts response.read_body
