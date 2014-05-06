Music_PrototypeGym:
	db $C0
	dw Music_PrototypeGym_Ch1
	db $01
	dw Music_PrototypeGym_Ch2
	db $02
	dw Music_PrototypeGym_Ch3
	db $03
	dw Music_PrototypeGym_Ch4

Music_PrototypeGym_Ch1:
	tempo 130
	volume 119
	dutycycle 0
	notetype 12, $60
	octave 1
	note E_, 15
	note __, 1
	notetype 12, $90
	note E_, 15
	note __, 1
	notetype 12, $b0
	note E_, 7
	note __, 1
	note E_, 7
	note __, 1
	notetype 12, $d0
	note E_, 3
	note __, 1
	note E_, 3
	note __, 1
	note E_, 1
	note __, 1
	note E_, 1
	note __, 1
	notetype 12, $f0
	note E_, 1
	note F_, 1
	note E_, 10
	note __, 8
	notetype 12, $a0

Music_PrototypeGym_Ch1_branch_1:
	note E_, 16
	note D_, 12
	note G_, 3
	note __, 1
	note G_, 16
	note D_, 8
	note E_, 7
	note __, 1
	note E_, 16
	note A_, 12
	note D_, 4
	note C#, 8
	note A_, 8
	note E_, 8
	note D#, 8
	note E_, 16
	note D_, 12
	note G_, 4
	note C_, 8
	note G_, 8
	note F#, 8
	note B_, 8
	note E_, 16
	note D_, 12
	note G_, 4
	note F#, 8
	note D_, 4
	note C#, 4
	note E_, 6
	note F#, 1
	note E_, 1
	note D#, 8
	note E_, 16
	note D_, 16
	note C_, 16
	note B_, 8
	note D_, 8
	note E_, 16
	note D_, 16
	note C_, 16
	note B_, 8
	note D_, 8
	note E_, 16
	loopchannel 0, Music_PrototypeGym_Ch1_branch_1


Music_PrototypeGym_Ch2:
	dutycycle 0
	octave 2
	notetype 12, $70
	callchannel Music_PrototypeGym_Ch2_branch_3
	notetype 12, $a0
	callchannel Music_PrototypeGym_Ch2_branch_3
	notetype 12, $c0
	callchannel Music_PrototypeGym_Ch2_branch_3
	notetype 12, $d0

Music_PrototypeGym_Ch2_branch_1:
	note E_, 1
	note F_, 1
	note E_, 1
	note __, 1
	loopchannel 3, Music_PrototypeGym_Ch2_branch_1
	notetype 12, $f0
	note E_, 1
	note F_, 1
	note E_, 10
	note __, 8

Music_PrototypeGym_Ch2_branch_2:
	notetype 12, $b0
	octave 1
	note B_, 16
	octave 2
	note F#, 12
	octave 1
	note B_, 4
	octave 2
	note C_, 8
	note G_, 8
	note F#, 8
	octave 1
	note E_, 4
	note A_, 4
	note B_, 16
	octave 2
	note C#, 12
	octave 1
	note A_, 4
	octave 2
	note C#, 8
	note A_, 4
	note E_, 1
	note __, 1
	note F#, 1
	note __, 1
	note E_, 8
	note D#, 8
	note __, 4
	octave 1
	note B_, 4
	octave 2
	note G_, 6
	note F#, 1
	note G_, 1
	note F#, 8
	note D_, 3
	note __, 1
	note D_, 1
	note __, 1
	note C_, 1
	octave 1
	note B_, 1
	octave 2
	note C_, 8
	note E_, 6
	note D#, 1
	note E_, 1
	note D#, 4
	note F#, 4
	note B_, 4
	note A_, 4
	note B_, 4
	octave 1
	note B_, 4
	octave 2
	note G_, 6
	note F#, 1
	note G_, 1
	note A_, 8
	note F#, 4
	octave 3
	note D_, 1
	note C_, 1
	octave 2
	note B_, 1
	note __, 1
	octave 3
	note C#, 8
	octave 2
	note A_, 6
	octave 3
	note D_, 1
	notetype 12, $b4
	note E_, 1
	notetype 12, $b0
	note E_, 6
	note F#, 1
	note E_, 1
	note D#, 8
	note __, 4
	notetype 12, $f0
	octave 1
	note B_, 4
	octave 2
	note G_, 8
	note F#, 8
	note __, 4
	note D_, 2
	octave 1
	note B_, 2
	octave 2
	note C_, 8
	note E_, 8
	note D#, 4
	note F#, 4
	note B_, 8
	note __, 4
	octave 1
	note B_, 4
	octave 2
	note G_, 8
	note A_, 8
	note __, 4
	note A_, 2
	note B_, 2
	octave 3
	note C_, 8
	octave 2
	note B_, 8
	notetype 12, $f7
	note F#, 8
	note F#, 8
	note E_, 16
	notetype 12, $f0
	loopchannel 0, Music_PrototypeGym_Ch2_branch_2

Music_PrototypeGym_Ch2_branch_3:
	note E_, 1
	note F_, 1
	note E_, 1
	note __, 1
	loopchannel 3, Music_PrototypeGym_Ch2_branch_3
	note G_, 1
	note __, 1
	note F_, 1
	note __, 1
	endchannel


Music_PrototypeGym_Ch3:
	notetype 12, $10
	note __, 16
	note __, 16
	octave 4

Music_PrototypeGym_Ch3_branch_1:
	note B_, 1
	octave 5
	note C_, 1
	octave 4
	note B_, 1
	note __, 1
	loopchannel 3, Music_PrototypeGym_Ch3_branch_1
	octave 5
	note D_, 1
	note __, 1
	note C_, 1
	note __, 1
	octave 4

Music_PrototypeGym_Ch3_branch_2:
	note B_, 1
	octave 5
	note C_, 1
	octave 4
	note B_, 1
	note __, 1
	loopchannel 3, Music_PrototypeGym_Ch3_branch_2
	note B_, 1
	octave 5
	note C_, 1
	octave 4
	note B_, 10
	note __, 4
	note E_, 1
	note F#, 1
	note G_, 1
	note A_, 1

Music_PrototypeGym_Ch3_branch_3:
	note B_, 14
	octave 5
	note D_, 1
	note E_, 1
	octave 4
	note A_, 12
	octave 5
	note D_, 1
	note __, 1
	note C_, 1
	octave 4
	note B_, 1
	octave 5
	note C_, 12
	octave 4
	note G_, 4
	note F#, 8
	note B_, 4
	note E_, 1
	note F#, 1
	note G_, 1
	note A_, 1
	note B_, 14
	octave 5
	note D_, 1
	note E_, 1
	octave 4
	note A_, 8
	note F#, 4
	octave 5
	note D_, 1
	note C_, 1
	octave 4
	note B_, 1
	note __, 1
	octave 5
	note C#, 8
	octave 4
	note A_, 6
	octave 5
	note D_, 1
	note __, 1
	note E_, 8
	note D#, 8
	octave 4
	note B_, 14
	octave 5
	note D_, 1
	note E_, 1
	octave 4
	note A_, 12
	octave 5
	note D_, 1
	note __, 1
	note C_, 1
	octave 4
	note B_, 1
	octave 5
	note C_, 12
	octave 4
	note G_, 4
	note F#, 8
	note B_, 4
	note E_, 1
	note F#, 1
	note G_, 1
	note A_, 1
	note B_, 14
	octave 5
	note D_, 1
	note E_, 1
	octave 4
	note A_, 8
	note F#, 4
	octave 5
	note D_, 1
	note C_, 1
	octave 4
	note B_, 1
	note __, 1
	octave 5
	note C#, 8
	octave 4
	note A_, 6
	octave 5
	note D_, 1
	note E_, 1
	note E_, 6
	note F#, 1
	note E_, 1
	note D#, 8
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 16
	note __, 12
	octave 4
	note E_, 1
	note F#, 1
	note G_, 1
	note A_, 1
	loopchannel 0, Music_PrototypeGym_Ch3_branch_3


Music_PrototypeGym_Ch4:
	notetype 12
	togglenoise 0
	note __, 4
	note D#, 2
	note D#, 6
	note D#, 2
	note D#, 6
	note D#, 2
	note D#, 6
	note D#, 2
	note D#, 6
	note D_, 2
	note D_, 6
	note D_, 2
	note D_, 2
	note __, 2
	note C#, 1
	note C#, 1
	note C#, 2
	note C#, 2
	note C#, 2
	note C#, 2
	note C_, 1
	note C_, 1
	note C_, 14
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1

Music_PrototypeGym_Ch4_branch_1:
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 3
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	loopchannel 16, Music_PrototypeGym_Ch4_branch_1

Music_PrototypeGym_Ch4_branch_2:
	;togglenoise 1
	;togglenoise 1
	note D#, 2
	note D#, 2
	note D#, 1
	note D#, 1
	note D#, 1
	note D#, 3
	note D#, 1
	note D#, 1
	note D#, 2
	note D#, 2
	note D#, 1
	note D#, 1
	note D#, 1
	note D#, 1
	note D#, 2
	note D#, 2
	note D#, 1
	note D#, 1
	note D#, 1
	note D#, 1
	note D#, 2
	note D#, 2
	loopchannel 4, Music_PrototypeGym_Ch4_branch_2
	note D#, 2
	note D#, 2
	note D#, 1
	note D#, 1
	note D#, 1
	note D#, 3
	note D#, 1
	note D#, 1
	;togglenoise 0
	;togglenoise 0
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	loopchannel 0, Music_PrototypeGym_Ch4_branch_1
