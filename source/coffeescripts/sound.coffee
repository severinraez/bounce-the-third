window.AudioContext = window.AudioContext || window.webkitAudioContext

class window.Sound
  constructor: () ->
    @notes =
      'G2': 98
      'C3': 130.81
      'C4': 261.63
      'C#4': 277.18
      'D4': 293.66
      'E4': 329.63
      'F4': 349.23
      'F#4': 369.99
      'G4': 392
      'G#4': 415.3
      'A4': 440
      'A#4': 466.16
      'B4': 493.88
      'C5': 523.25
      'E5': 659.25
      'F5': 698.46
      'G5': 783.99

    @range = [@notes['C4'], @notes['C5']]
    @note = @range[0]

    @context = new AudioContext()
    @sounding = false
    @reset()

  reset: () ->
    @oscillator?.disconnect()
    @noiseOscillator?.disconnect()
    @sounding = false

    @oscillator = @context.createOscillator()
    @noiseOscillator = @context.createOscillator()

    @oscillator.type = 0 # sine wave
    @oscillator.frequency.value = @note
    @oscillator.connect @context.destination

    @noiseOscillator.type = 0 # sine wave
    @noiseOscillator.frequency.value = @note
    @noiseOscillator.connect @context.destination

  setHeight: (val) ->
    unless @sounding
      @sounding = true
      @oscillator.noteOn && @oscillator.noteOn(0)
      @noiseOscillator.noteOn && @noiseOscillator.noteOn(0.7)

    @note = @range[0] + val * (@range[1] - @range[0])
    @oscillator.frequency.value = @note
    @noiseOscillator.frequency.value = @note

  gameOver: () ->
    now = @context.currentTime;
    @oscillator.frequency.setValueAtTime @note, now
    @noiseOscillator.frequency.setValueAtTime @note, now
    @oscillator.frequency.linearRampToValueAtTime @notes['C3'], now + 1
    @noiseOscillator.frequency.linearRampToValueAtTime @notes['C3'], now + 1



