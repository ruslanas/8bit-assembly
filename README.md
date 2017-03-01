8 bit sawtooth synthesizer
==========================

Compile and listen

`fasm music.asm music.wav`

[Download binary](https://raw.githubusercontent.com/ruslanas/8bit-assembly/master/music.wav)

[Listen on FreeSound.org](https://www.freesound.org/people/ruslanas.com/sounds/382612/)

Source code
-----------

```assembly
;
;  music.asm
;
;  8 bit sawtooth synthesizer
;
;  https://github.com/ruslanas/8bit-assembly
;
;  (c) 2017 Ruslanas Balciunas

Duration        equ 1
NumChannels     equ 1
SampleRate      equ 44100
NumSamples      equ Duration * SampleRate
BitsPerSample   equ 8
TotalBytes      equ NumSamples * NumChannels * BitsPerSample / 8

                db 'RIFF'
                dd waveChunkEnd - waveChunkStart

waveChunkStart:
                db 'WAVE'

                db 'fmt '                                       ; chunk ID
                dd fmtChunkEnd - fmtChunkStart                  ; chunk size

fmtChunkStart:
                dw 1                                            ; Audio format (PCM)
                dw NumChannels
                dd SampleRate
                dd SampleRate * NumChannels * BitsPerSample / 8 ; Byte rate
                dw NumChannels * BitsPerSample / 8              ; Align
                dw BitsPerSample
fmtChunkEnd:

                db 'data'                                       ; chunk ID
                dd TotalBytes                                   ; data size

        repeat TotalBytes / 8
                db (% * 3270 / 3465) mod 200 + 56 / 2
                end repeat

        repeat TotalBytes / 8
                db % mod 200 + 56 / 2
                end repeat

        repeat TotalBytes / 8
                db 256 / 2                                      ; silence
                end repeat

        repeat TotalBytes / 8
                db (% * 3270 / 3465) mod 200 + 56 / 2
                end repeat

        repeat TotalBytes / 4
                db (% * 3270 / 3889) mod 150 + 106 / 2
                end repeat

        repeat TotalBytes / 8
                db % mod 200 + 56 / 2
                end repeat

        repeat TotalBytes / 8
                db (% * 3270 / 3671) mod 220 + 36 / 2
                end repeat

waveChunkEnd:
```