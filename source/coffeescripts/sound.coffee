window.AudioContext = window.AudioContext || window.webkitAudioContext

class window.Sound
  constructor: () ->
    @notes =
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

    @context = new AudioContext()
    @oscillator = @context.createOscillator()

    @range = [@notes['F4'], @notes['C4']]
    @note = @range[0]

    @oscillator.type = 0 # sine wave
    @oscillator.frequency.value = @note
    @oscillator.connect @context.destination
    @oscillator.noteOn && @oscillator.noteOn(0)

  setHeight: (val) ->
    @note = @range[0] + val * (@range[1] - @range[0])
    @oscillator.frequency.value = @note
