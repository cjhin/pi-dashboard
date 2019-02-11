# encoding: UTF-8

# require 'active_support/all'
require 'nokogiri'
require 'socket'
require 'faraday'

# 37 Southbound, sedgwick and menomenee: 6600
sedgwick = 1402
# 22 northbond, deaborn and polk
dearborn_and_polk = 1875
# 8 Southbound, halsted and willow
# halsted = 5772

cta_key = ENV['CTA_KEY']

conn = Faraday.new(url: "http://www.ctabustracker.com") do |faraday|
  faraday.request :url_encoded
  faraday.adapter Faraday.default_adapter
end

# Start the scheduler
SCHEDULER.every '60s', :first_in => 0  do |job|

  times = []

  response = conn.get "bustime/api/v1/getpredictions?key=#{cta_key}&stpid=#{dearborn_and_polk}"
  if response.status == 200
    doc = Nokogiri::XML(response.body)

    doc.css('prd').each do |node|
      route = node.css('rt').text
      arrival_time = node.css('prdtm').text

      times << { route: route, time: arrival_time }
    end
  end

  send_event('cta', { times: times })
end
