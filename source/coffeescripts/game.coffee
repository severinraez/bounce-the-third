
class window.Game
  constructor: (@canvas, @size, @sound) ->
    @context = @canvas.getContext '2d'
    @board = new Board 200, 200, @size.width / 2 - 100, @size.height - 50
    @ballStartPos =
      x: @size.width / 2
      y: @size.height - 100
    @ballPeakY = 0
    @states =
      PLAYING: 0
      END_SEQUENCE: 1
      STARTING: 2

    @start()

  start: () ->
    @ball = new Ball @ballStartPos.x, @ballStartPos.y
    @state = @states.STARTING
    @sound.reset()
    startGame = () =>
      @state = @states.PLAYING
    window.setTimeout startGame, 2000

  setSize: (size) ->
    @size = size

  onMove: (x, y) ->
    @board.setPos x, y

  render: () ->
    @context.clearRect 0, 0, @size.width, @size.height
    unless @state == @states.END_SEQUENCE
      @ball.draw @context

    @board.draw @context

  advance: (delta) ->
    return unless @state == @states.PLAYING

    @ball.advance delta

    if @ball.collidesWithBoard @board
      @ball.placeAbove(@board.getY())
      @ball.modifySpeedY -1
      @ball.accelerateY -20
      @ball.accelerateX -10 + Math.random() * 20

    #make sure the sound doesn't get too high
    ballHeightProportion = @ball.getY() / @size.height
    ballHeightLimit =  -0.70595450290846

    @ball.modifySpeedY(0) if ballHeightProportion < ballHeightLimit
    @ball.modifySpeedX(-1) if @ball.getX() < 0 || @ball.getX() > @size.width

    if @ball.getY() > @size.height
      @sound.gameOver()
      @state = @states.END_SEQUENCE

      continueGame = () =>  @start()
      window.setTimeout continueGame, 1500

    @sound.setHeight 1 - (@ball.getY() / @size.height)

