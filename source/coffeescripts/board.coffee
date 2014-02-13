class window.Board
  constructor: (@width, @height, @x, @y) ->
    1

  draw: (@context) ->
    @context.fillRect @x, @y, @width, @height

  setPos: (x, y) ->
    @x = x; @y = y

  getY: () -> @y

  getBB: () ->
    top: @y
    left: @x
    bottom: @y + @height
    right: @x + @width
