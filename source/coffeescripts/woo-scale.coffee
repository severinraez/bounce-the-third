class window.WooScale
  constructor: (@x, @y, @maxWidth, @height) ->
    @level = 0

    @width = 0
    @heightLeft = @height * 0.15

  setLevel: (woo) ->
    @level = woo
    @width = @maxWidth * @level
    @heightRight = @heightLeft + (@height - @heightLeft) * @level

    console.log 'woo: ', @level


  draw: (context) ->
    return if @width == 0

    context.beginPath()
    context.moveTo @x, @y + @height - @heightLeft
    context.lineTo @x + @width, @y + @height - @heightRight
    context.lineTo @x + @width, @y + @height
    context.lineTo @x, @y + @height
    context.closePath()
    context.fill()