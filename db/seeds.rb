require "open-uri"
require 'json'
require "uri"
require "net/http"
require_relative "seed_items"
require_relative "seeds_api"
# https://github.com/pejotrich/flatmate
# https://github.com/andrewbonas/rails_facebook
# https://github.com/rka97/Unive/tree/master/app
#
batch_466 = [
  # commented out peeps with no full name
  # "glenntippett",
  # "mrchvs",
  "melwers",
  "avrilpryce",
  # "Michiel-DK",
  "PatriciaZB",
  "theHem-code",
  "Linda8875",
  "juliends",
  # "ThierryMR",
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
  # "tristanmahe",
  # "Pierre-L99",
  "Nooshin-8",
  "anaisfr",
  "camimurg",
  "GuidoCaldara",
  "enitschorn",
  "rayhanw",
  "matoni109",
  "Tom-Tee",
  "cdrmr18",
  # "jarrydanthony",
  "10035",
  # "lucieroland",
  "anLpk",
  # "diego-mogollon",
  "maksimumeffort",
  "lunarness",
  "Escapewithcode",
  "santanu0013",
  # "DraganGasic",
  "cheenaelise",
  "joshwbarnes",
  "rbalendra",
  "appu4ever",
  "julianharr"
]

def get_git_info(git_name)
  # url = "https://api.github.com/users/#{git_name}"
  url = URI("https://api.github.com/users/#{git_name}")

  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request["Authorization"] = ENV["GITHUB_TOKEN"]

  response = https.request(request)
  user = JSON.parse(response.read_body)
  first_name = user["name"].present? ? user["name"].split.first.capitalize : user["login"].capitalize
  last_name = user["name"].present? ? user["name"].split[1]&.capitalize : ""
  bio = user["bio"].present? ? user["bio"] : Faker::Quote.matz
  location = %w[Sydney Melbourne].sample # user["location"].present? ? user["location"] :

  email = "#{first_name.downcase}@gmail.com"
  # email = user["email"].nil? ? Faker::Internet.email : user["email"]
  interests = %w[arts music outdoors tech photography food family fitness sports writing language LGBTQ film sci-fi games book-clubs dance pets crafts fashion beauty business environment]
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

  3.times { make_me.interest_list.add(interests.sample) }
  make_me.save!
  p make_me.interest_list
  user_image = URI.parse(user["avatar_url"]).open
  make_me.avatar.attach(io: user_image, filename: "#{make_me.first_name}.jpeg", content_type: 'image/jpeg')
  puts "made #{make_me.first_name} #{make_me.last_name}"
end

puts "--- GAME  START ---"
puts "---"
puts "---"
puts "cleaning house :)"

Message.destroy_all
Chatroom.destroy_all
Wishlist.destroy_all
Item.destroy_all
Event.destroy_all
Attendevent.destroy_all
Charity.destroy_all
Favorite.destroy_all
Message.destroy_all
User.destroy_all
# Kills all Active storage items ##
ActiveStorage::Attachment.all.each { |attachment| attachment.purge }
puts "done cleaning house.."

puts "-- Making Humans"

# Make the Plebs ##
batch_466.each do |element|
  get_git_info(element)
end

puts "--- Making Humans Ended !"
puts "--- Making Humans Friendships !"

## TODO: get all the users
user_arr = User.all.ids
# slice in parts
split_arr = user_arr.in_groups(3, false)
group_1 = split_arr[0]
group_2 = split_arr[1]
group_3 = split_arr[2]

# find users
group_1.each do |user|
  friends = group_2 # .concat(group_3)

  friends.take(rand(1..friends.count)).each do |friends_find|
    user1 = User.find_by(id: user)
    friend = User.find_by(id: friends_find)
    user1.friend_request(friend)
    num = rand(1..5)
    if num < 4

      friend.accept_request(user1)
      friend_found = User.find_by(id: user1.friends.ids.last)
      puts " #{user1.first_name} is friends with #{friend_found.first_name}"
    elsif num == 4
      friend.decline_request(user1)
      puts " #{user1.first_name} got ReJected!!"
    else
      puts " #{user1.first_name} has been left hangin.."
    end
  end
end

group_3.each do |user|
  friends = group_1 # .concat(group_3)
  # binding.pry
  friends.take(rand(1..friends.count)).each do |friends_find|
    # binding.pry
    user1 = User.find_by(id: user)
    friend = User.find_by(id: friends_find)
    user1.friend_request(friend)
    num = rand(1..5)
    if num < 4
      friend.accept_request(user1)
      friend_found = User.find_by(id: user1.friends.ids.last)
      puts " #{user1.first_name} is friends with #{friend_found.first_name}"
    elsif num == 4
      friend.decline_request(user1)
      puts " #{user1.first_name} got ReJected!!"
    else
      puts " #{user1.first_name} has been left hangin.."
    end
    # binding.pry
  end
end

group_2.each do |user|
  friends = group_3 # .concat(group_3)
  # binding.pry
  friends.take(rand(1..friends.count)).each do |friends_find|
    # binding.pry
    user1 = User.find_by(id: user)
    friend = User.find_by(id: friends_find)
    user1.friend_request(friend)
    num = rand(1..5)
    if num < 4
      friend.accept_request(user1)
      friend_found = User.find_by(id: user1.friends.ids.last)
      puts " #{user1.first_name} is friends with #{friend_found.first_name}"
    elsif num == 4
      friend.decline_request(user1)
      puts " #{user1.first_name} got ReJected!!"
    else
      puts " #{user1.first_name} has been left hangin.."
    end
    # binding.pry
  end
end
puts "--- Friendships Generator Ended!"
puts "--- Making Overlord Julian !"
# User Master OverLoad # HOLD GME !! ##
make_admin = User.find_by(git_name: "julianharr")
make_admin.update( # change to create! later
  email: "spin@gmail.com",
  admin: true,
  password: "123456"
)
## get friends for Overlord
puts "--- Making Overlord Friend Requests !"
user_arr = User.all.ids
# slice in parts
split_arr = user_arr.in_groups(3, false)
group_1 = split_arr[0]

group_1.each do |friends_find|
  friend = User.find_by(id: friends_find)
  friend.friend_request(make_admin)
end
puts "--- Overlord OVER !"

puts "--- Making Wish Lists !!"
list_users = User.pluck(:id)
list_users.each do |element|
  make_me = Wishlist.new(
    user_id: element
  )
  # binding.pry
  if make_me.valid?
    make_me.save!
    puts "made Wishlist # #{make_me.id}"
  else
    puts "List didn't work out ..."
  end
end

puts "--- Making Wish Lists Ended !"

puts "--- HEY it's time to make Status Updates CMON !"

user_arr.each do |id|
  make_status = Status.create(
    content: Faker::Quote.yoda,
    user_id: id
  )

  if make_status.valid?
    make_status.save!
    puts "made Status"
  else
    puts "Status didn't work out ..."
  end
end

# batch_466.length.times do
#   make_status
#   puts "made Status"
# end

puts "--- Making Items Bro !!"
make_items
puts "--- Making Items ENDED !!"

puts "--- Making Charities Start "
csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
filepath    = 'db/csv/csv_charities.csv'
# CSV will return a HASH format
CSV.foreach(filepath, csv_options) do |row|
  # puts "#{row['Charity/Non-profit name']}, #{row['Description']},  #{row['Location']},  #{row['Website']},  #{row['Category']}"
  make_me = Charity.new(
    name: row['Charity/Non-profit name'],
    description: row['Description'],
    location: row['Location'],
    website: row['Website']
    # category: row['Category']
    # donate ID
  )
  # binding.pry
  if make_me.valid?
    make_me.save!
    puts "made Charity # #{make_me.id}"
  else
    puts "Charity didn't work out ..."
  end
end

puts "--- Charities Done :) " ###
puts "---"
puts "---"
puts "--- Spooling up events ---"
#
# Local meetup API tester below first
#
meetup_event_spooler(meetup_events_finder({ latitude: "-37.81", longitude: "144.96", category: "tech" }))
meetup_event_spooler(meetup_events_finder({ latitude: "-37.784", longitude: "144.986", category: "food" }))

# Big Daddy Events Scraper Below !!! Caution !!!
#
# interests_melb = %w[arts music outdoors tech photography food family fitness sports writing language LGBTQ film sci-fi games book-clubs dance pets crafts fashion beauty business environment]
# interests_melb.each do |element|
#   meetup_event_spooler(meetup_events_finder({ latitude: "-37.81", longitude: "144.96", category: element }))
# end
# # syd = 33.8861° S, 151.2111° E
# interests_syd = %w[arts music outdoors tech photography food family fitness sports writing language LGBTQ film sci-fi games book-clubs dance pets crafts fashion beauty business environment]
# interests_syd.each do |element|
#   meetup_event_spooler(meetup_events_finder({ latitude: "-33.8861", longitude: "151.2111", category: element }))
# end

# 150.times do
#   Attendevent.create!(
#     user_id: User.ids.sample,
#     event_id: Event.ids.sample
#   )
# end

puts "--- Events Over ---"
puts "---"
puts "---"
puts "--- GAME OVER ---"
