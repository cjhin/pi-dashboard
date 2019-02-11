class Dashing.GoogleCalendar extends Dashing.Widget

  onData: (data) =>
    event = rest = null
    getEvents = (first, others...) ->
      event = first
      rest = others

    # only make the first event prominent if it is today
    if(moment().diff(moment(data.events.items[0].start.dateTime), 'days') < 1)
      getEvents data.events.items...

      start = moment(event.start.dateTime)
      end = moment(event.end.dateTime)

      @set('event',event)
      @set('event_date', start.format('dddd Do MMMM'))
      @set('event_times', start.format('h:mm') + " - " + end.format('h:mm'))
    else
      rest = data.events.items

    next_events = []
    for next_event in rest
      start = moment(next_event.start.dateTime)
      start_date = start.format('ddd Do MMM')
      start_time = start.format('h:mm')

      next_events.push { summary: next_event.summary, start_date: start_date, start_time: start_time }
    @set('next_events', next_events)
