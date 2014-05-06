Music_PrototypeViridian:
	db $80
	dw Music_PrototypeViridian_Ch1
	db $01
	dw Music_PrototypeViridian_Ch2
	db $02
	dw Music_PrototypeViridian_Ch3

Music_PrototypeViridian_Ch1:
	tempo 234
	dutycycle 0
	notetype 12, $c5
	note __, 16
	note __, 16
	note __, 16
	note __, 16

Music_PrototypeViridian_Ch1_branch_1:
	notetype 12, $c5
	octave 2
	note C_, 4
	note C_, 4
	note D_, 4
	note D_, 4
	note F_, 4
	note F_, 4
	note D_, 4
	note D_, 4
	note F_, 4
	note C_, 4
	note E_, 4
	note D_, 4
	note F_, 4
	note F_, 4
	octave 1
	note A#, 4
	octave 2
	note C_, 4
	note C_, 4
	note C_, 4
	note D_, 4
	note D_, 4
	note F_, 4
	note F_, 4
	note D_, 4
	note D_, 4
	note F_, 4
	note C_, 4
	octave 1
	note F_, 4
	octave 2
	note D_, 4
	notetype 12, $c7
	note __, 2
	note C_, 4
	note A_, 4
	note __, 2
	note C_, 4
	note __, 2
	note C_, 4
	note F_, 4
	note C_, 4
	note __, 2
	note A_, 4
	note F_, 4
	note E_, 2
	note D_, 2
	note F_, 4
	note __, 4
	note C_, 4
	note G_, 2
	note A_, 2
	note F_, 4
	octave 1
	note F_, 8
	note __, 16
	octave 2
	note C_, 6
	note D_, 2
	note C_, 3
	note D_, 1
	note C_, 4
	octave 1
	note F_, 8
	loopchannel 0, Music_PrototypeViridian_Ch1_branch_1


Music_PrototypeViridian_Ch2:
	dutycycle 0
	notetype 12, $c5
	note __, 16
	note __, 16
	note __, 16
	note __, 16

Music_PrototypeViridian_Ch2_branch_1:
	note __, 16
	note __, 16
	octave 2
	note D_, 2
	note A_, 1
	note G_, 1
	note F_, 3
	note A#, 1
	octave 3
	note C_, 2
	octave 2
	note A_, 2
	note F_, 4
	note __, 16
	octave 3
	note G_, 1
	note F_, 3
	note C_, 4
	note G_, 2
	note A_, 2
	note F_, 4
	note G_, 1
	note F_, 3
	note C_, 4
	note E_, 2
	note D_, 2
	note F_, 4
	note __, 4
	note C_, 4
	note F_, 4
	note __, 8
	note C_, 4
	note F_, 4
	note __, 4
	note C_, 4
	note A_, 4
	note F_, 4
	note __, 10
	note C_, 2
	note A_, 4
	note F_, 4
	note __, 8
	notetype 12, $c7
	note A_, 8
	note F_, 8
	note __, 8
	notetype 12, $c5
	note C_, 6
	note D_, 2
	note C_, 3
	note D_, 1
	note C_, 4
	octave 2
	note F_, 8
	note __, 8
	loopchannel 0, Music_PrototypeViridian_Ch2_branch_1


Music_PrototypeViridian_Ch3:
	notetype 12, $25

Music_PrototypeViridian_Ch3_branch_1:
	octave 2
	note F_, 2
	octave 3
	note C_, 2
	note F_, 2
	note C_, 2
	octave 2
	note A#, 2
	octave 3
	note D_, 2
	note F_, 2
	note D_, 2
	octave 2
	note F_, 2
	octave 3
	note C_, 2
	note F_, 2
	note C_, 2
	octave 2
	note A#, 2
	octave 3
	note F_, 2
	note A_, 2
	note F_, 2
	loopchannel 0, Music_PrototypeViridian_Ch3_branch_1
