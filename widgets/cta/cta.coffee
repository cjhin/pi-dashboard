class Dashing.Cta extends Dashing.Widget

  onData: (data) =>
    trains = []

    for train in data['times']
      parsed_arrival_time = moment(train['time'], 'YYYYMMDD HH:mm')
      arrival_time = parsed_arrival_time.format('h:mm a')

      time_until_arrival = parsed_arrival_time.diff(moment(), 'minutes')

      route_class = train['route'].toLowerCase()

      # I'm not going to make it to any train stations in under 5 minutes probably
      # also keep it to 6 or less times, 7 fits but cuts it close, 8 doesnt fit
      if time_until_arrival >= 5 && trains.length < 6
        trains.push {
          route: train['route'],
          destination: train['destination'],
          station: train['station'],
          route_class: route_class
          arrival_time: arrival_time,
          time_until_arrival: time_until_arrival
        }
    @set('trains', trains)
