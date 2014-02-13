class window.Ball
  constructor: (@x, @y) ->
    @speedX = 0
    @speedY = 0
    @g = 9.81
    @radius = 5
    @maxSpeed = 200

  advance: (delta) ->
    @speedY += @g*delta

    @clampSpeed()

    @x += @speedX * delta
    @y += @speedY * delta

  clampSpeed: () ->
    @speedX = @maxSpeed if @speedX > 0 && @speedX > @maxSpeed
    @speedX = -@maxSpeed if @speedX < 0 && @speedX < -@maxSpeed
    @speedY = @maxSpeed if @speedY > 0 && @speedY > @maxSpeed
    @speedY = -@maxSpeed if @speedY < 0 && @speedY < -@maxSpeed

  draw: (context) ->
    context.beginPath()
    context.arc @x, @y, @radius, 0, Math.PI * 2
    context.stroke()

  getY: () -> @y

  placeAbove: (y) -> @y = y - @radius

  collidesWithBoard: (board) ->
    bb = board.getBB()
    isHeightCollision = bb.top < @y - @radius && bb.bottom > @y + @radius
    isWidthCollision = bb.left < @x - @radius && bb.right > @x + @radius
    isHeightCollision && isWidthCollision

  modifySpeedY: (mod) -> @speedY *= mod; @clampSpeed()
  accelerateY: (amount) -> @speedY += amount; @clampSpeed()
  modifySpeedX: (mod) -> @speedX *= mod; @clampSpeed()
  accelerateX: (amount) -> @speedX += amount; @clampSpeed()
  getX: () -> @x
