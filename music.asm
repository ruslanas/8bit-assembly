;
;  8 bit sawtooth synthesizer
;
;  https://github.com/ruslanas/8bit-assembly
;
; (c) 2017 Ruslanas Balciunas

Duration	equ 1
NumChannels	equ 1
SampleRate	equ 44100
NumSamples	equ Duration * SampleRate
BitsPerSample	equ 8
TotalBytes	equ NumSamples * NumChannels * BitsPerSample / 8

		db 'RIFF'
chunkSize	dd waveChunkEnd - waveChunkStart

		db 'WAVE'
waveChunkStart:

fmtChunkId	db 'fmt '
fmtChunkSize	dd fmtChunkEnd - fmtChunkStart

fmtChunkStart:

AudioFormat	dw 1				    ; PCM
		dw NumChannels
		dd SampleRate
ByteRate	dd SampleRate * NumChannels * BitsPerSample/8
BlockAlign	dw NumChannels * BitsPerSample / 8
		dw BitsPerSample

fmtChunkEnd:

dataChunkId	db 'data'
dataChunkSize	dd TotalBytes

repeat TotalBytes / 8
		db (% * 3270 / 3465) mod 200 + 56 / 2
end repeat

repeat TotalBytes / 8
		db % mod 200 + 56 / 2
end repeat

repeat TotalBytes / 8
		db 256 / 2	    ; silence
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