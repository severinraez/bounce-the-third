window.requestAnimFrame = (() ->
  window.requestAnimationFrame ||
  window.webkitRequestAnimationFrame ||
  window.mozRequestAnimationFrame    ||
  (callback) -> window.setTimeout callback, 1000 / 60
)()

$ ->
  size = {}
  canvas = $ '#canvas'

  setSize = () ->
    size =
      width: $(window).width()
      height: $(window).height()
    setCanvasSize()

  setCanvasSize = () ->
    canvas.attr 'width', size.width
    canvas.attr 'height', size.height
  setSize()

  sound = new Sound()
  game = new Game canvas[0], size, sound

  $(window).on 'resize', (event) ->
    setSize()
    game = new Game size

  $(window).on 'mousemove', (event) ->
    pos =
      abs:
        x: event.pageX
        y: event.pageY

    pos.rel =
      x: pos.abs.x/size.width
      y: pos.abs.y/size.height

    #sound.setHeight pos.rel.y
    game.onMove pos.abs.x, pos.abs.y

  lastTime = new Date()
  theLoop = (time) ->
    delta = (time - lastTime) / 100
    game.advance(delta) if Math.abs(delta) < 100
    lastTime = time
    game.render()
    window.requestAnimFrame theLoop

  window.requestAnimFrame theLoop


