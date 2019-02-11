class Dashing.Cta extends Dashing.Widget

  onData: (data) =>
    buses = []

    for bus in data['times']
      parsed_arrival_time = moment(bus['time'], 'YYYYMMDD HH:mm')
      arrival_time = parsed_arrival_time.format('h:mm')

      time_until_arrival = parsed_arrival_time.diff(moment(), 'minutes')

      buses.push { route: bus['route'], arrival_time: arrival_time, time_until_arrival: time_until_arrival }
    @set('buses', buses)
