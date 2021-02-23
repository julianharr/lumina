require "open-uri"
require 'json'
require "uri"
require "net/http"

require_relative "seed_items"
# https://github.com/pejotrich/flatmate
# https://github.com/andrewbonas/rails_facebook
#
#
batch_466 = [
  "glenntippett",
  "mrchvs",
  "melwers",
  "avrilpryce",
  "Michiel-DK",
  "PatriciaZB",
  "theHem-code",
  "Linda8875",
  "juliends",
  "ThierryMR",
  "Micheledebruyn",
  "Inbal-Gordon",
  "ilia-ber",
  "cassy-dodd",
  "petia182",
  "Botlike31",
  "nkhape",
  "AlvaroPata",
  "may-moff",
  "vdelgadobenito",
  "tristanmahe",
  "Pierre-L99",
  "Nooshin-8",
  "anaisfr",
  "camimurg",
  "GuidoCaldara",
  "enitschorn",
  "rayhanw",
  "matoni109",
  "Tom-Tee",
  "cdrmr18",
  "jarrydanthony",
  "10035",
  "lucieroland",
  "anLpk",
  "diego-mogollon",
  "maksimumeffort",
  "lunarness",
  "Escapewithcode",
  "santanu0013",
  "DraganGasic",
  "cheenaelise",
  "joshwbarnes",
  "rbalendra",
  "appu4ever"
]

def get_git_info(git_name)
  url = "https://api.github.com/users/#{git_name}"
  parsed_url = URI.parse url
  https = Net::HTTP.new(parsed_url.host, parsed_url.port)
  https.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request["Authorization"] = ENV["GITHUB_TOKEN"]

  response = https.request(request)
  user = JSON.parse(response.read_body)

  first_name = user["name"].present? ? user["name"].split.first.capitalize : user["login"].capitalize
  last_name = user["name"].present? ? user["name"].split[1]&.capitalize : ""
  bio = user["bio"].present? ? user["bio"] : Faker::Quote.matz
  location = user["location"].present? ? user["location"] : Faker::Address.city
  email = user["email"].nil? ? Faker::Internet.email : user["email"]

  user_image = URI.parse(user["avatar_url"]).open
  make_me = User.create( # change to create! later
    first_name: first_name.to_s,
    last_name: last_name.to_s,
    git_name: user["login"],
    bio: bio.to_s,
    location: location.to_s,
    nickname: user["login"],
    birthday: Faker::Date.birthday(min_age: 18, max_age: 33),
    email: email.to_s,
    admin: false,
    password: "123456"
  )

  make_me.avatar.attach(io: user_image, filename: "#{make_me.first_name}.jpeg", content_type: 'image/jpeg')
  puts "made #{make_me.first_name} #{make_me.last_name}"
end

puts "--- GAME  START ---"
puts "---"
puts "---"
puts "cleaning house :)"
User.destroy_all
Wishlist.destroy_all
Item.destroy_all
Charity.destroy_all
# Favourite.destroy_all

# Kills all Active storage items ##
ActiveStorage::Attachment.all.each { |attachment| attachment.purge }
puts "done cleaning house.."

puts "-- Making Humans"

# User Master OverLoad # HOLD GME !! ##
url = "https://api.github.com/users/julianharr"
git_back = open(url).read
user = JSON.parse(git_back)
user_image = URI.parse(user["avatar_url"]).open

make_me = User.create!( # change to create! later
  first_name: user["name"].split.first,
  last_name: user["name"].split[1],
  git_name: user["login"],
  bio: user["bio"],
  location: user["location"],
  nickname: user["login"],
  birthday: Faker::Date.birthday(min_age: 18, max_age: 33),
  email: "spin@gmail.com",
  admin: true,
  password: "123456"
)

if make_me.save
  puts "saved user"
else
  puts "user creation failed"
end

make_me.avatar.attach(io: user_image, filename: "#{make_me.first_name}.jpeg", content_type: 'image/jpeg')
puts "made #{make_me.first_name} #{make_me.last_name}"


## Make the Plebs ##
batch_466.each do |element|
  get_git_info(element)
end

puts "--- Making Humans Ended !"

puts "--- Making Wish Lists !!"

list_users = User.pluck(:id)
list_users.each do |element|
  make_me = Wishlist.new(
    user_id: element
  )

  if make_me.valid?
    make_me.save!
    puts "made Wishlist # #{make_me.id}"
  else
    puts "Item didn't work out ..."
  end

end

puts "--- Making Wish Lists Ended !"

puts "--- Making Items Bro !!"

# Call the make_items method from the seed_items file
make_items

puts "Finished making items"
# puts "--- Making Favourites Start !"

# count_fav = 0
# until count_fav == 10
#   make_me = Favourite.new(
#     favorited_type: Bike,
#     favorited_id: Bike.pluck(:id).sample,
#     user_id: User.pluck(:id).sample
#   )
#   if make_me.valid?
#     make_me.save!
#     count_fav += 1
#     puts "made Favourite # #{make_me.id}"
#   else
#     puts "Fav didn't work out ..."
#   end
# end
# puts "--- Making Reviews ENDED !"

puts "---"
puts "---"
puts "--- GAME OVER ---"
