require "open-uri"
require 'json'
require "uri"
require "net/http"
require 'dotenv'


## get the first access token
def get_initial_token
# {"code":"bc807ec3af945ed60fc1686c65c43344"}
  client_id_key = ENV["MEETUP_KEY"].to_s

 p url = URI("https://secure.meetup.com/oauth2/authorize?client_id=#{client_id_key}&response_type=anonymous_code&redirect_uri=https://www.love-lumina.me/")

https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true

request = Net::HTTP::Get.new(url)
request["Content-Type"] = "application/json"
request["Accept"] = "application/json"
request["Cookie"] = "MEETUP_AFFIL=affil=meetup; MEETUP_BROWSER_ID=\"id=756c9fe0-0bca-4112-bc41-1685ef9f6f92\"; MEETUP_CSRF=239ce87b-ac9b-453e-9d79-2688da4f5d1a; MEETUP_MEMBER=\"id=154567222&status=4&timestamp=1614245261&bs=0&tz=Australia%2FMelbourne&zip=meetup2&country=au&city=Melbourne&state=&lat=-37.81&lon=144.96&ql=false&s=038211a2f0cfead5522e9fd3a51cf56f4a482535&scope=ALL\"; MEETUP_SEGMENT=member; MEETUP_TRACK=id=5e0859a6-c334-4f2b-bd73-818934553be7&l=1&s=a7bf3696ab6fe266da7143de4cb39f9fc2698c45; SIFT_SESSION_ID=256ba851-27e3-49b6-bcb7-31155a4bbb81"

response = https.request(request)
#  puts response.read_body

 p result = JSON.parse(response.body)


end

get_initial_token()

def request_access_token

url = URI("https://secure.meetup.com/oauth2/access?client_id=oleeh69n9arija6n2vo9p5g2e4&client_secret=2t60t96pgsldve4b392q4lnavo&grant_type=anonymous_code&redirect_uri=https://www.love-lumina.me/&code=b4051ab9175060afecb1aab17511edcc")

https = Net::HTTP.new(url.host, url.port)
https.use_ssl = true

request = Net::HTTP::Post.new(url)
request["Content-Type"] = "application/json"
request["Accept"] = "application/json"
request["Cookie"] = "MEETUP_AFFIL=affil=meetup; MEETUP_BROWSER_ID=\"id=756c9fe0-0bca-4112-bc41-1685ef9f6f92\"; MEETUP_CSRF=239ce87b-ac9b-453e-9d79-2688da4f5d1a; MEETUP_MEMBER=\"id=154567222&status=4&timestamp=1614245261&bs=0&tz=Australia%2FMelbourne&zip=meetup2&country=au&city=Melbourne&state=&lat=-37.81&lon=144.96&ql=false&s=038211a2f0cfead5522e9fd3a51cf56f4a482535&scope=ALL\"; MEETUP_SEGMENT=member; MEETUP_TRACK=id=5e0859a6-c334-4f2b-bd73-818934553be7&l=1&s=a7bf3696ab6fe266da7143de4cb39f9fc2698c45; SIFT_SESSION_ID=256ba851-27e3-49b6-bcb7-31155a4bbb81"

response = https.request(request)
puts response.read_body

end
