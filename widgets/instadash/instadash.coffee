class Dashing.Instadash extends Dashing.Widget

  ready: ->
    @currentIndex = 0
    @photoElem = $(@node).find('.photo-container')
    @nextPhoto()
    @startCarousel()

  onData: (data) ->
    @currentIndex = 0

  startCarousel: ->
    setInterval(@nextPhoto, 180000)

  # photos = [
  #     "https://source.unsplash.com/610x730/?chicago",
  #     "https://source.unsplash.com/610x730/?telluride",
  #     "https://source.unsplash.com/610x730/?mountain"
  # ]

  photos = [
      "img_1.jpg",
      "img_2.jpg",
      "img_3.jpg",
      "img_4.jpg",
      "img_5.jpg",
      "img_6.jpg",
      "img_7.jpg",
      "img_8.jpg",
      "img_9.jpg",
      "img_10.jpg"
  ]

  nextPhoto: =>
    # photos = @get('photos')
    # if photos
    #   @photoElem.fadeOut =>
    #     @currentIndex = (@currentIndex + 1) % photos.length
    #     @set 'current_photo', photos[@currentIndex]
    @photoElem.fadeOut =>
        @currentIndex = (@currentIndex + 1) % photos.length
        @set 'current_photo', './assets/pi-dashboard/' + photos[@currentIndex]
