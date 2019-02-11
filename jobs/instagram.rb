# require 'sinatra'
# require 'instagram'

# Instagram.configure do |config|
#   # For client id and client secret you need to register an application at http://instagram.com/developer
#   config.client_id = ENV['INSTAGRAM_CLIENT_ID'] || 'your_client_id'
#   config.client_secret = ENV['INSTAGRAM_CLIENT_SECRET'] || 'your_client_secret'
#   # To obtain your access token I followed this: http://jelled.com/instagram/access-token
#   config.access_token = ENV['INSTAGRAM_ACCESS_TOKEN'] || 'your_access_token'
# end

# This needs the user ID you want to display images of. Find out the ID for a username here: http://jelled.com/instagram/lookup-user-id
# chasjhin
# user_id = '1697532318'
# chicago
# user_id = '1910638555'
# thehungrypandas
# user_id = '2072810954'

# Uncomment the following line if you want to see the received output in your terminal (for debugging)
# puts Instagram.user_recent_media("#{user_id}")

# SCHEDULER.every '2m', :first_in => 0 do |job|
#   photos = Instagram.user_recent_media("#{user_id}")
#   if photos
#     photos.map! do |photo|
#       { photo: "#{photo.images.standard_resolution.url}" }
#     end
#   end
#   send_event('instadash', photos: photos)
# end