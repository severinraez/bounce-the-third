class window.WooScale
  constructor: (@x, @y, @maxWidth, @height, @context) ->
    @level = 0

    @width = 0
    @heightLeft = @height * 0.15

    @gradient = @context.createLinearGradient @x, @y, @x+@maxWidth, @height
    @gradient.addColorStop(0,"black");
    @gradient.addColorStop(1,"white");

  setLevel: (woo) ->
    @level = woo
    @width = @maxWidth * @level
    @heightRight = @heightLeft + (@height - @heightLeft) * @level

  draw: (context) ->
    return if @width == 0

    context.save()
    context.fillStyle = @gradient;
    context.beginPath()
    context.moveTo @x, @y + @height - @heightLeft
    context.lineTo @x + @width, @y + @height - @heightRight
    context.lineTo @x + @width, @y + @height
    context.lineTo @x, @y + @height
    context.closePath()
    context.fill()
    context.restore()

    @_drawText()

  _drawText: () ->
    @context.font = "#{@level*@level*60}pt Mystery Quest"
    @context.fillText 'Woo', @x, @y + @height + 50