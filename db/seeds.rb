require "open-uri"
require 'json'
require "uri"
require "net/http"
#
require_relative "seed_items"
require_relative "seeds_api"
# https://github.com/pejotrich/flatmate
# https://github.com/andrewbonas/rails_facebook
#
#
batch_466 = [
  "glenntippett",
  "mrchvs",
  # "melwers",
  # "avrilpryce",
  # "Michiel-DK",
  # "PatriciaZB",
  # "theHem-code",
  # "Linda8875",
  # "juliends",
  # "ThierryMR",
  # "Micheledebruyn",
  # "Inbal-Gordon",
  # "ilia-ber",
  # "cassy-dodd",
  # "petia182",
  # "Botlike31",
  # "nkhape",
  # "AlvaroPata",
  # "may-moff",
  # "vdelgadobenito",
  # "tristanmahe",
  # "Pierre-L99",
  # "Nooshin-8",
  # "anaisfr",
  # "camimurg",
  # "GuidoCaldara",
  # "enitschorn",
  # "rayhanw",
  # "matoni109",
  # "Tom-Tee",
  # "cdrmr18",
  # "jarrydanthony",
  # "10035",
  # "lucieroland",
  # "anLpk",
  # "diego-mogollon",
  # "maksimumeffort",
  # "lunarness",
  # "Escapewithcode",
  # "santanu0013",
  # "DraganGasic",
  # "cheenaelise",
  # "joshwbarnes",
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
# batch_466.each do |element|
#   get_git_info(element)
# end

# puts "--- Making Humans Ended !"

# puts "--- Making Wish Lists !!"
# # whats in a wish list ?
# #
# list_users = User.pluck(:id)
# list_users.each do |element|
#   make_me = Wishlist.new(
#     user_id: element
#   )
#     # binding.pry
#   if make_me.valid?
#     make_me.save!
#     puts "made Wishlist # #{make_me.id}"
#   else
#     puts "List didn't work out ..."
#   end

# end

# puts "--- Making Wish Lists Ended !"

# puts "--- Making Items Bro !!"
# make_items()
# puts "--- Making Items ENDED !!"

# puts "--- Making Charities Start "
# csv_options = { col_sep: ',', quote_char: '"', headers: :first_row }
# filepath    = 'db/csv/csv_charities.csv'
# # CSV will return a HASH format
# CSV.foreach(filepath, csv_options) do |row|
#    # puts "#{row['Charity/Non-profit name']}, #{row['Description']},  #{row['Location']},  #{row['Website']},  #{row['Category']}"
# make_me = Charity.new(
#     name: row['Charity/Non-profit name'],
#     description: row['Description'],
#     location: row['Location'],
#     website: row['Website'],
#     category: row['Category']
#     # donate ID
#   )
#      # binding.pry
#   if make_me.valid?
#     make_me.save!
#     puts "made Charity # #{make_me.id}"
#   else
#     puts "Charity didn't work out ..."
#   end
#   end

# puts "--- Charities Done :) "###

puts "---"
puts "--- GAME OVER ---"
# make_items
# puts "--- Making Items Ended !"
# #   ### Make some Bookings ###

# puts "-- Making Bookings !"
# # Day.where(:reference_date => 3.months.ago..Time.now).count
# # => 721
# book_fav = 0
# until book_fav == 35
#   ## make the instance
#   make_me = Booking.new(
#     # total_price: rand(25..85), ## TODO:: work out total price
#     from: Time.now + (rand(10..20) * rand(30_000..40_000)),
#     till: Time.now + (rand(30..40) * rand(70_000..90_000)),
#     user_id: User.pluck(:id).sample,
#     bike_id: Bike.pluck(:id).sample
#   )

#   if make_me.valid?
#     make_me.save!
#     book_fav += 1
#     puts "made Booking # #{make_me.id}"
#   else
#     puts "Fav didn't work out ..."
#   end

# end

# puts "--- Making Bookings ENDED !"

# puts "--- Making Reviews Start !"



# user_image = "https://images-na.ssl-images-amazon.com/images/I/41nzI1lhIVL._SX327_BO1,204,203,200_.jpg"
# item_one = Item.create(
#    name: "A Promised Land Novel",
#    price: 27.99,
#    link: 'https://www.amazon.com.au/A-Promised-Land/dp/B08JCV95VB/?pf_rd_r=VQEYTM5H2207W1VP143P&pf_rd_p=24775cd0-99dd-4031-a438-674f5fa1369a&pd_rd_r=ca722146-b60c-4bd1-89a3-967280554e48&pd_rd_w=b2zem&pd_rd_wg=5xKAv&ref_=pd_gw_unk',
#    description: 'A riveting, deeply personal account of history in the making - from the president who inspired us to believe in the power of democracy',
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://m.media-amazon.com/images/I/51nDhGOv0oL.jpg"
# item_two = Item.create(
#    name: "Greenlights Novel",
#    price: 15.99,
#    link: 'https://www.amazon.com.au/Greenlights/dp/B08J43CXZ4/?pf_rd_r=VQEYTM5H2207W1VP143P&pf_rd_p=24775cd0-99dd-4031-a438-674f5fa1369a&pd_rd_r=ca722146-b60c-4bd1-89a3-967280554e48&pd_rd_w=b2zem&pd_rd_wg=5xKAv&ref_=pd_gw_unk',
#    description: 'From the Academy Award-winning actor, an unconventional memoir filled with raucous stories.',
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/91r79g3OlHL._AC_SL1500_.jpg"
# item_three = Item.create(
#    name: "Edifier R1280DB Powered Bluetooth Bookshelf Speakers",
#    price: 119.00,
#    link: 'https://www.amazon.com.au/Edifier-R1280DB-Bookshelf-Bluetooth-Wireless/dp/B01NCTNZRC?ref_=Oct_s9_apbd_orec_hd_bw_b5KcQSR&pf_rd_r=V9ZY4AGCZABT2NPB051D&pf_rd_p=e590eaf4-3875-5bba-aeee-7c3f7efc3390&pf_rd_s=merchandised-search-10&pf_rd_t=BROWSE&pf_rd_i=4885349051',
#    description: 'Black wood look to keep the classic look with a new twist on the style of modern technology. Now your speakers can blend in well with your PC.',
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/619IjjRuMgL._AC_SL1500_.jpg"
# item_four = Item.create(
#    name: "NVIDIA SHIELD Controller - Android",
#    price: 89.00,
#    link: 'https://www.amazon.com.au/Edifier-R1280DB-Bookshelf-Bluetooth-Wireless/dp/B01NCTNZRC?ref_=Oct_s9_apbd_orec_hd_bw_b5KcQSR&pf_rd_r=V9ZY4AGCZABT2NPB051D&pf_rd_p=e590eaf4-3875-5bba-aeee-7c3f7efc3390&pf_rd_s=merchandised-search-10&pf_rd_t=BROWSE&pf_rd_i=4885349051',
#    description: 'Redesigned from the ground up for precision gaming. Dual vibration feedback. Stereo headphone jack for private audio',
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/61MdyHSbxHL._AC_SL1100_.jpg"
# item_five = Item.create(
#    name: "Echo Dot (3rd Gen) – Smart speaker with Alexa -",
#    price: 59.00,
#    link: "https://www.amazon.com.au/Echo-Dot-3rd-Gen-Charcoal/dp/B07PJV9DHV?ref_=Oct_s9_apbd_orec_hd_bw_b5KbHxT&pf_rd_r=KJTNACN3E162GEPFW8K9&pf_rd_p=cae77b0b-f636-522e-bb40-3b139093711c&pf_rd_s=merchandised-search-10&pf_rd_t=BROWSE&pf_rd_i=4885078051",
#    description: "cho Dot is our most popular voice-controlled speaker, now with improved sound and a new design.",
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/513YGV2RT4L._AC_SL1000_.jpg"
# item_six = Item.create(
#    name: "Echo Wall Clock",
#    price: 49.00,
#    link: "https://www.amazon.com.au/Echo-Wall-Clock-See-timers-at-a-glance/dp/B07SP78TFY/?_encoding=UTF8&pd_rd_w=CaOWS&pf_rd_p=d2e5f020-22cd-4dfd-8518-73f1e2eddd6f&pf_rd_r=8W65MCAT12YAV8R6WJKF&pd_rd_r=6f186116-6c39-4d58-a316-53c3a032f147&pd_rd_wg=cn47x&ref_=pd_gw_trq_rep_sims_gw",
#    description: "Echo Wall Clock helps you stay organised and be on time. Easy-to-read analogue clock shows the time.",
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images.asos-media.com/products/guess-muticolour-dial-watch/22139571-1-silver?$XXL$&wid=513&fit=constrain"
# item_seven = Item.create(
#    name: "GUESS Women's Stainless Steel Two-Tone Crystal Accented Watch",
#    price: 122.96,
#    link: "https://www.amazon.com.au/Womens-Stainless-Two-Tone-Crystal-Accented/dp/B0093Q0VB0/?_encoding=UTF8&smid=ANEGB3WVEVKZB&pd_rd_w=BcsF6&pf_rd_p=9621d879-f15c-4401-b655-512addaad44e&pf_rd_r=8W65MCAT12YAV8R6WJKF&pd_rd_r=6f186116-6c39-4d58-a316-53c3a032f147&pd_rd_wg=cn47x&ref_=pd_gw_unk",
#    description: "SILVER-TONE DIAL WITH DATE WINDOW. Features: Date Window Function. 36 MM CASE SIZE with DURABLE MINERAL CRYSTAL that protects watch from scratch.",
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/517cJC1ys7L._AC_SL1024_.jpg"
# item_eight = Item.create(
#    name: "Lodge L8SK3 10.25 Inch Cast Iron Skillet with Helper Handle, Black",
#    price: 58.90,
#    link: "https://www.amazon.com.au/Lodge-L8SK3-Skillet-Helper-Handle/dp/B00006JSUA?ref_=Oct_s9_apbd_orec_hd_bw_b5TVNPH&pf_rd_r=RJ5NC9M89QJ4H790PA11&pf_rd_p=602a5526-75b1-5fd5-aff1-653d7495ef24&pf_rd_s=merchandised-search-10&pf_rd_t=BROWSE&pf_rd_i=5016656051",
#    description: "unparalleled in heat retention & even heating. seasoned & ready to use. brutally tough for decades of cooking",
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/51oK1KrmNML._AC_SL1498_.jpg"
# item_nine = Item.create(
#    name: "Road To Vitality - Push Up Bars",
#    price: 29.95,
#    link: "https://www.amazon.com.au/dp/B084D43M9W/ref=sspa_dk_detail_2?psc=1&pd_rd_i=B084D43M9W&pd_rd_w=fgRWE&pf_rd_p=ea20208d-137b-46cb-8ff4-3f2183f0cd6f&pd_rd_wg=hlHr6&pf_rd_r=RQ51DF4AK3SAS0AF3JTW&pd_rd_r=1b54ee85-40b4-4e56-99da-ed98f0fd681a&spLa=ZW5jcnlwdGVkUXVhbGlmaWVyPUEyQVkyRExJTFVHUFhWJmVuY3J5cHRlZElkPUEwNDU0NzEwMUUzRVk5UjM0MjZEMiZlbmNyeXB0ZWRBZElkPUExQ09YSjIwMUtDM0VVJndpZGdldE5hbWU9c3BfZGV0YWlsJmFjdGlvbj1jbGlja1JlZGlyZWN0JmRvTm90TG9nQ2xpY2s9dHJ1ZQ==",
#    description: "SUPERIOR STEEL FRAME CONSTRUCTION - By using high grade steel for the frame construction. PULL UP BAR.",
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/51BYKGV8znL._AC_.jpg"
# item_ten = Item.create(
#    name: "Over The Sink Dish Drying Rack",
#    price: 177.95,
#    link: "https://www.amazon.com.au/Stainless-Kitchen-Tableware-Countertop-Size%E2%89%A482cm/dp/B08FT2PRGX/ref=pd_d_dss_r_1/356-2681869-3559559?_encoding=UTF8&pd_rd_i=B08FT2PRGX&pd_rd_r=2b40cbd8-b33b-4594-bfcc-675c9bf269e6&pd_rd_w=NfEyb&pd_rd_wg=21tH1&pf_rd_p=5308a30b-9345-4f1d-83fe-a773f4dfae1b&pf_rd_r=N71MGYGK9E9XVG2ZXRPV&psc=1&refRID=N71MGYGK9E9XVG2ZXRPV",
#    description: "KITCHEN SPACE SAVER: Keep all your dishes, cups, utensil organised in clean manner, you will be amazed by how much space you can save.",
#    image: "https://images-na.ssl-images-amazon.com/images/I/51BYKGV8znL._AC_.jpg",
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/81OogbwE9xL._AC_SL1500_.jpg"
# item_eleven = Item.create(
#    name: "Philips Air Fryer Premium XXL for Fry/Bake/Grill/Roast with Fat Removal and Rapid Air Technology",
#    price: 321.75,
#    link: "https://www.amazon.com.au/dp/B07D2D9GR4?aaxitk=H02OqeJFhQX27OEVfANuOA&pd_rd_plhdr=t&me=ANEGB3WVEVKZB&ref=dacx_dp_6394592720703_4260677320103",
#    description: "FRY or BAKE or GRILL or ROAST; You can make hundreds of dishes in your Airfryer Fry, bake, grill, roast and even reheat your meals.",
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://www.converse.com.au/media/catalog/product/cache/506b4e978a2aaf2437105399caeb33bd/u/n/unisex_converse_chuck_taylor_all_star_classic_colour_low_top_white_17652_0.jpg"
# item_twelve = Item.create(
#    name: "Converse Chuck Taylor All Star Unisex Sneakers",
#    price: 42.05,
#    link: "https://www.amazon.com.au/Converse-Womens-Chuck-Taylor-Shoes/dp/B0000AFT05/ref=sr_1_2?_encoding=UTF8&dchild=1&pd_rd_r=01783093-b725-4c23-9574-b6be51e9c68c&pd_rd_w=ImvhG&pd_rd_wg=8XkkG&pf_rd_p=9621d879-f15c-4401-b655-512addaad44e&pf_rd_r=HV7CYX80PHH34V5V0XZ0&qid=1613791836&refinements=p_n_prime_domestic%3A6845356051&rnid=6963563051&s=apparel&smid=ANEGB3WVEVKZB&sr=1-2",
#    description: "Low-top sneaker with canvas upper. Iconic silhouette. OrthoLite insole for comfort. Diamond outsole tread. Unisex Sizing",
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/61qqNyr3ItL._AC_SL1362_.jpg"
# item_thirteen = Item.create(
#    name: "Mass Effect Legendary Edition - PlayStation 4",
#    price: 69.00,
#    link: "https://www.amazon.com.au/Mass-Effect-Legendary-PlayStation-4/dp/B08NJRKWT6/ref=sr_1_6?dchild=1&keywords=playstation&qid=1613791917&sr=8-6",
#    description: "One person is all that stands between humanity and the greatest threat it's ever faced. Relive the legend of Commander Shepard."
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://myer-media.com.au/wcsstore/MyerCatalogAssetStore/images/40/401/3639/200/7/807270320/807270320_1_1_720x928.jpg"
# item_fourteen = Item.create(
#    name: "Tommy Hilfiger Men's May Crew Tee",
#    price: 26.95,
#    link: "https://www.amazon.com.au/Tommy-Hilfiger-Cloud-Heather-Medium/dp/B0765ZVJY3/ref=sr_1_2?dchild=1&pf_rd_i=5130734051&pf_rd_m=AMMK0LS9EDNM8&pf_rd_p=39f18b0d-07a1-43df-8c67-6bd5bae49920&pf_rd_r=7M3EHPM0Q68NNQ4J7HZK&pf_rd_s=merchandised-search-2&pf_rd_t=101&qid=1613792253&s=apparel&sr=1-2",
#    description: "Tommy Hilfiger flag embroidery on chest. Crew neck",
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/61ySjgN1J7L._AC_SL1500_.jpg"
# item_fifteen = Item.create(
#    name: "PlayStation VR Starter Pack",
#    price: 398.00,
#    link: "https://www.amazon.com.au/PlayStation-CUH-ZVR2-VR-Starter-Pack/dp/B08NBRQ2R8/ref=sr_1_11?dchild=1&keywords=playstation&qid=1613791991&sr=8-11",
#    description: "360 degree Vision. 3D Audio. Intuitive Controls. Built-in Microphone. One Size Fits All. Compatible with PlayStation 5",
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/61E3iyQBU-L.jpg"
# item_sixteen = Item.create(
#    name: "Can't Hurt Me: Master Your Mind and Defy the Odds",
#    price: 19.40,
#    link: "https://www.amazon.com.au/Cant-Hurt-Me-Master-Your/dp/1544512279/?_encoding=UTF8&pd_rd_w=BI3C6&pf_rd_p=e968e706-8052-40af-887f-c89d644d7814&pf_rd_r=1NS4Z3W78DRPY0ABRDQB&pd_rd_r=2c014ad1-ebba-4760-86a4-7b3873d2e558&pd_rd_wg=9urUf&ref_=pd_gw_crs_zg_bs_4851626051",
#    description: "For David Goggins, childhood was a nightmare — poverty, prejudice, and physical abuse colored his days and haunted his nights.",
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/61c3iPKAmwL._AC_SL1200_.jpg"
# item_seventeen = Item.create(
#    name: "Meteor Anti-Burst Yoga Ball",
#    price: 25.95,
#    link: "https://www.amazon.com.au/Anti-Burst-Exercise-Pregnant-Relaxation-Stretching/dp/B07B4ZX8SP/ref=sr_1_8?dchild=1&keywords=gym&qid=1613792478&sr=8-8",
#    description: "ANTI-BURST - Professional grade PVC material, extensive testing and a unique anti-burst design provides for the highest quality.",
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/61gud3gnjuL._AC_SL1001_.jpg"
# item_eighteen = Item.create(
#    name: "Makeup Brushes 18 PCs Makeup Brush Set",
#    price: 19.40,
#    link: "https://www.amazon.com.au/Brushes-Synthetic-Concealers-Foundation-Purple-Gold/dp/B08KGDCDCF/ref=sr_1_1?dchild=1&keywords=makeupo&qid=1613792338&s=fashion&sr=1-1",
#    description: "Professional Makeup Brush Set For Pro Or Beginners： Perfect makeup brush kit for liquids, powders or creams, meet all your requirements.",
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://www.guitarparadise.com.au/resources/40391ba3/product/product-4736/450-squier%20affinity%20tele%20black.jpg"
# item_nineteen = Item.create(
#    name: "Fender Telecaster Electric Guitar",
#    price: 369.00,
#    link: "https://www.guitarparadise.com.au/product/squier-affinity-telecaster-black/",
#    description: "A superb gateway into the time-honored Fender® family, the Squier® Affinity Series™ Telecaster®",
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://underarmour.scene7.com/is/image/Underarmour/V5ProdWithBadge?rp=standard-0pad|pdpMainDesktop&scl=1&fmt=jpg&qlt=85&resMode=sharp2&cache=on,off&bgc=F0F0F0&rect=0,0,612,650&$p_pos=306,325&$p_size=612,650&extendN=0,0.00,0,0.00&$p_src=is{Underarmour/1342656-424_SLF_SL}"
# item_twenty = Item.create(
#    name: "Under Armour Undeniable Duffle",
#    price: 69.20,
#    link: "https://www.amazon.com.au/Under-Armour-Unisex-Adult-1342657-P-Graphite/dp/B07JB1LB64/ref=sr_1_11?dchild=1&keywords=gym&qid=1613792560&sr=8-11",
#    description: "84% Polyester, 16% Elastane. Imported. Textile lining. shoulder drop",
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/61VtiyDp3PL._AC_SL1000_.jpg"
# item_twenty_one = Item.create(
#    name: "38 Inch Acoustic Guitar Classical Guitar",
#    price: 76.95,
#    link: "https://www.amazon.com.au/Acoustic-Guitar-Classical-Strap-ALPHA/dp/B07RRZX1LL/ref=sr_1_2?dchild=1&keywords=guitar&qid=1613792819&sr=8-2",
#    description: "Auditorium Size 38 inch acoustic guitar with dimension of 96 x 36 x 8.5cm.",
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/71R6r39nBKL._AC_SL1425_.jpg"
# item_twenty_two = Item.create(
#    name: "Metallica Black Album Vinyl",
#    price: 45.25,
#    link: "https://www.amazon.com.au/METALLICA-BLACK-ALBUM-VINYL/dp/B00LYHXIE8/ref=sr_1_2?dchild=1&keywords=metallica&qid=1613792939&sr=8-2",
#    description: "Blackened Records is the new label for all of Metallica's repertoire. The audio for this release is identical to the Elektra counterpart.",
#    image: "https://images-na.ssl-images-amazon.com/images/I/71R6r39nBKL._AC_SL1425_.jpg",
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/81A4KqJc98L._AC_SL1400_.jpg"
# item_twenty_three = Item.create(
#    name: "Justin Bieber Changes",
#    price: 9.95,
#    link: "https://www.amazon.com.au/Purpose-JUSTIN-BIEBER/dp/B016AM4BD8/ref=sr_1_4?crid=1GX8TBLUAYQI5&dchild=1&keywords=justin+beiber&qid=1613793050&sprefix=justin+bei%2Caps%2C320&sr=8-4",
#    description: "Justin Bieber s powerful new album PURPOSE will hit stores globally on November 13th.",
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/71hTV17WYiL._AC_SL1024_.jpg"
# item_twenty_four = Item.create(
#    name: "LEGO Technic Bugatti Chiron 42083 Race Car Building Kit",
#    price: 509.99,
#    link: "https://www.amazon.com.au/LEGO-Technic-Bugatti-Chiron-42083/dp/B0792RB3B6/ref=sr_1_11?dchild=1&keywords=lego&qid=1613793221&refinements=p_36%3A5355414051&rnid=5355409051&s=toys&sr=1-11",
#    description: "The perfect gift for car lovers and future engineers Build and experience a quintessential collectible sports car LEGO.",
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/71zV7OiJuhL._AC_SL1500_.jpg"
# item_twenty_five = Item.create(
#    name: "Mr. Potato Head",
#    price: 15.90,
#    link: "https://www.amazon.com.au/Playskool-Friends-Potato-Head-Classic/dp/B005KJE9L2/ref=sr_1_5?dchild=1&keywords=toy&qid=1613793308&s=toys&sr=1-5",
#    description: "Kids can create silly looks. Over 10 pieces to mix and match",
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/61ISjgFTbRL._AC_SL1500_.jpg"
# item_twenty_six = Item.create(
#    name: "Playstation 5",
#    price: 0,
#    link: "https://www.amazon.com.au/Playskool-Friends-Potato-Head-Classic/dp/B005KJE9L2/ref=sr_1_5?dchild=1&keywords=toy&qid=1613793308&s=toys&sr=1-5",
#    description: "Currently unavailable. We don't know when or if this item will be back in stock.",
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/81bEuNZRdAL._AC_SL1500_.jpg"
# item_twenty_seven = Item.create(
#    name: "GIGABYTE GeForce RTX 3080",
#    price: 1000,
#    link: "https://www.amazon.com.au/GIGABYTE-Graphics-WINDFORCE-GV-N3080GAMING-OC-10GD/dp/B08HJTH61J/ref=sr_1_1?crid=1EKNDYQDR9ULQ&dchild=1&keywords=rtx+3080&qid=1613796383&sprefix=rtx%2Caps%2C320&sr=8-1",
#    description: "NVIDIA Ampere Streaming Multiprocessors 2nd Generation RT Cores 3rd Generation Tensor Cores Powered by GeForce RTX 3080 Integrated with 10GB GDD",
#    wishlist_id: rand(1..18)
#  )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/810z0nFKivL._AC_SL1500_.jpg"
# item_twenty_eight = Item.create(
#    name: "Demon's Souls - PlayStation 5",
#    price: 98,
#    link: "https://www.amazon.com.au/Sony-Demons-Souls-PlayStation-5/dp/B08B2MMSML/ref=sr_1_1?crid=2CM5JHVKP93XE&dchild=1&keywords=demon+souls+ps5&qid=1613796725&s=videogames&sprefix=demon+soul%2Cvideogames%2C301&sr=1-1",
#    description: "Experience the original brutal challenge, completely remade from the ground up. All presented in stunning visual quality with super performance.",
#    wishlist_id: rand(1..18)
#   )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/61kQqplOEqL._AC_SL1500_.jpg"
# item_twenty_nine = Item.create(
#    name: "Bosch CityMower 18",
#    price: 319,
#    link: "https://www.amazon.com.au/Bosch-CityMower-Cordless-Lawnmower-Without/dp/B07QFRN36C/ref=zg_bs_garden_23?_encoding=UTF8&psc=1&refRID=830SPGFSNJ9MA76W7JD4",
#    description: "The Bosch CityMower 18 Cordless 18 Volt Lawnmower offers flexible and environmentally friendly mowing. The tool is easy to manoeuvre.",
#    wishlist_id: rand(1..18)
#     )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/61unEqDNjvL._AC_SL1100_.jpg"
# item_thirty = Item.create(
#    name: "Apple iPhone 12 Pro Max",
#    price: 999,
#    link: "https://www.amazon.com.au/Apple-iPhone-12-Pro-Max/dp/B08MWLT7MS/ref=sr_1_1?crid=1T1RW3YRN0N1Q&dchild=1&keywords=iphone+12+pro+max&qid=1613796927&sprefix=iphone+12+%2Caps%2C318&sr=8-1",
#    description: "Apple iPhone 12 Pro Max MGDL3X/A 512GB - Pacific Blue - iPhone 12 Pro. Superfast 5G. A14 Bionic, the fastest chip in a smartphone.",
#    image: "https://images-na.ssl-images-amazon.com/images/I/61unEqDNjvL._AC_SL1100_.jpg",
#    wishlist_id: rand(1..18)
#     )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/615AHkg5RqL._AC_SL1500_.jpg"
# item_thirty_one = Item.create(
#    name: "Grillz Charcoal BBQ Smoker Camping Grill Portable Barbeque",
#    price: 35,
#    link: "https://www.amazon.com.au/Grillz-Charcoal-Camping-Portable-Barbeque/dp/B07MFKL1BY/ref=zg_bs_5707524051_23?_encoding=UTF8&psc=1&refRID=YKEGJC43HAFYR6AQ1G50",
#    description: "Looking for a quick and hassle-free BBQ? Then consider our Portable Charcoal BBQ. It is compact and lightweight.",
#    wishlist_id: rand(1..18)
#     )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# user_image = "https://images-na.ssl-images-amazon.com/images/I/61BtkSjcC4L._AC_SL1000_.jpg"
# item_twenty_two = Item.create(
#    name: "Automatic Pet Water Fountain",
#    price: 40,
#    link: "https://www.amazon.com.au/LEMONDA-Automatic-Transparent-Dispenser-Waterfall/dp/B089RCN1Q1/ref=zg_bs_5581859051_22?_encoding=UTF8&psc=1&refRID=CYGHDPXB2S2XP1CQMK5W",
#    description: "The largest capacity design on the market which can meet the pet's need for several days,perfect for dogs , cats , multiple pet households.",
#    wishlist_id: rand(1..18)
#     )
# user_image = URI.parse(user_image).open
# item_one.image.attach(io: user_image, filename: "image.jpeg", content_type: 'image/jpeg')



# items_array = [item_one, item_two, item_three, item_four, item_five, item_six, item_seven, item_eight, item_nine, item_ten, item_eleven, item_twelve, item_thirteen, item_fourteen, item_fifteen, item_sixteen, item_seventeen, item_eighteen, item_nineteen, item_twenty, item_twenty_one, item_twenty_two, item_twenty_three, item_twenty_four, item_twenty_five, item_twenty_six]


# items_array.each do |item|
#   item
# end

# 25.times do
#   ## make the instance
#   make_me = Review.create!(
#     content: Faker::TvShows::GameOfThrones.quote,
#     rating: rand(1..5),
#     booking_id: Booking.pluck(:id).sample
#   )
#   puts "made Review # #{make_me.id}"
# end

# puts "--- Making Reviews ENDED !"

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






