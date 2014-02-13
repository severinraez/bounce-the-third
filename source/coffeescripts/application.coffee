$ ->
  size = {}

  setSize = () ->
    size =
      width: $(window).width()
      height: $(window).height()
  setSize()

  sound = new Sound()

  $(window).on 'resize', (event) ->
    setSize()

  $(window).on 'mousemove', (event) ->
    pos =
      x: event.pageX/size.width
      y: event.pageY/size.height
    console.log pos

    sound.setHeight pos.y


