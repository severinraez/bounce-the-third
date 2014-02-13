
class window.Game
  constructor: (@canvas, @size, @sound) ->
    @context = @canvas.getContext '2d'
    @board = new Board 200, 50, @size.width / 2 - 100, @size.height - 50
    @ballStartPos =
      x: @size.width / 2
      y: @size.height - 100
    @ball = new Ball @ballStartPos.x, @ballStartPos.y
    @ballPeakY = 0

  setSize: (size) ->
    @size = size

  onMove: (x, y) ->
    @board.setPos x, y

  render: () ->
    @context.clearRect 0, 0, @size.width, @size.height
    @ball.draw @context
    @board.draw @context

  advance: (delta) ->
    @ball.advance delta

    if @ball.collidesWithBoard @board
      @ball.placeAbove(@board.getY())
      @ball.modifySpeedY -1
      @ball.accelerateY -20

    #make sure the sound doesn't get too high
    ballHeightProportion = @ball.getY() / @size.height
    ballHeightLimit =  -0.70595450290846
    @ball.modifySpeedY(0) if ballHeightProportion < ballHeightLimit

    if @ball.getY() > @size.height
      @ball = new Ball @ballStartPos.x, @ballStartPos.y

    @sound.setHeight 1 - (@ball.getY() / @size.height)

