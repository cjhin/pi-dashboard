class Dashing.Instadash extends Dashing.Widget

  ready: ->
    @currentIndex = 0
    @photoElem = $(@node).find('.photo-container')
    @nextPhoto()
    @startCarousel()

  onData: (data) ->
    @currentIndex = 0

  startCarousel: ->
    setInterval(@nextPhoto, 300000)

  photos = [
      "https://source.unsplash.com/610x730/?chicago",
      "https://source.unsplash.com/610x730/?telluride"
  ]

  nextPhoto: =>
    # photos = @get('photos')
    # if photos
    #   @photoElem.fadeOut =>
    #     @currentIndex = (@currentIndex + 1) % photos.length
    #     @set 'current_photo', photos[@currentIndex]
    @photoElem.fadeOut =>
        @currentIndex = (@currentIndex + 1) % photos.length
        @set 'current_photo', photos[@currentIndex]