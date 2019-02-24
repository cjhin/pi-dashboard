# encoding: UTF-8

# require 'active_support/all'
require 'nokogiri'
require 'socket'
require 'faraday'

$cta_key = ENV['CTA_TRAIN_KEY']

$conn = Faraday.new(url: "http://lapi.transitchicago.com") do |faraday|
  faraday.request :url_encoded
  faraday.adapter Faraday.default_adapter
end

def get_and_add_to_train_times(times = [], train_stop = '', route_name = '', custom_station_name = '')
  api_url = "/api/1.0/ttarrivals.aspx?key=#{$cta_key}&mapid=#{train_stop}"
  api_url += "&rt=#{route_name}" if route_name.length > 0

  response = $conn.get api_url

  if response.status == 200
    doc = Nokogiri::XML(response.body)

    doc.css('eta').each do |node|
      station = node.css('staNm').text
      route = node.css('rt').text
      destination = node.css('destNm').text
      arrival_time = node.css('arrT').text

      times << {
        route: route,
        destination: destination,
        station: if custom_station_name.length > 0 then custom_station_name else station end,
        time: arrival_time
      }
    end
  end

  return times
end

# Start the scheduler
SCHEDULER.every '60s', :first_in => 0  do |job|

  times = []

  harrison_red_line = 41490
  times = get_and_add_to_train_times(times, harrison_red_line)
  harold_washington = 40850
  times = get_and_add_to_train_times(times, harold_washington, "pink", "Harold Wsh.")

  times = times.sort_by { |time| time[:time] }

  send_event('cta', { times: times })
end
