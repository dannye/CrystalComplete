Music_PrototypePallet:
	db $80
	dw Music_PrototypePallet_Ch1
	db $01
	dw Music_PrototypePallet_Ch2
	db $02
	dw Music_PrototypePallet_Ch3

Music_PrototypePallet_Ch1: ; a7c5 (2:67c5)
	tempo 255
	volume 119
	dutycycle 0
	octave 2

Music_PrototypePallet_Ch1_branch_1:
	notetype 12, $a7
	note C_, 2
	note D_, 2
	notetype 12, $a0
	note G_, 4
	notetype 12, $a7
	note G_, 8
	note C_, 2
	note D_, 2
	notetype 12, $a0
	note F_, 4
	notetype 12, $a7
	note F_, 8
	loopchannel 0, Music_PrototypePallet_Ch1_branch_1


Music_PrototypePallet_Ch2:
	dutycycle 0
	notetype 12, $77

Music_PrototypePallet_Ch2_branch_1:
	octave 3
	note C_, 2
	note D_, 2
	notetype 12, $70
	note G_, 8
	notetype 12, $77
	note G_, 4
	note C_, 2
	note D_, 2
	notetype 12, $70
	note F_, 8
	notetype 12, $77
	note F_, 4
	loopchannel 4, Music_PrototypePallet_Ch2_branch_1

Music_PrototypePallet_Ch2_branch_2:
	notetype 12, $97
	octave 3
	note G_, 2
	note A_, 2
	octave 4
	note C_, 1
	note __, 3
	note C_, 8
	octave 3
	note G_, 2
	note A_, 2
	octave 4
	note F_, 2
	note E_, 2
	note C_, 8
	loopchannel 2, Music_PrototypePallet_Ch2_branch_2
	note G_, 6
	note F_, 1
	note G_, 1
	note A_, 6
	note G_, 2
	note D_, 6
	note C_, 2
	note D_, 4
	note E_, 1
	note F_, 1
	note E_, 2
	note D_, 6
	note C_, 2
	octave 3
	note G_, 6
	note F_, 1
	note G_, 1
	note A_, 6
	octave 4
	notetype 12, $a7
	note D_, 2
	note C_, 8
	loopchannel 0, Music_PrototypePallet_Ch2_branch_1


Music_PrototypePallet_Ch3:
	dutycycle 0
	notetype 12, $12
	note __, 16
	note __, 16
	note __, 16
	note __, 16

Music_PrototypePallet_Ch3_branch_1:
	octave 4
	note G_, 2
	note A_, 2
	octave 5
	note C_, 1
	note __, 3
	note C_, 8
	octave 4
	note G_, 2
	note A_, 2
	octave 5
	note F_, 2
	note E_, 2
	note C_, 8
	loopchannel 2, Music_PrototypePallet_Ch3_branch_1
	dutycycle 2
	note G_, 6
	note F_, 1
	note G_, 1
	note A_, 6
	note G_, 2
	note D_, 6
	note C_, 2
	note D_, 4
	note E_, 1
	note F_, 1
	note E_, 2
	note D_, 6
	note C_, 2
	octave 4
	note G_, 6
	note F_, 1
	note G_, 1
	note A_, 6
	octave 5
	note D_, 2
	note C_, 8
	octave 4
	note G_, 4
	octave 5
	note D_, 8
	note C_, 4
	note D_, 4
	note E_, 1
	note F_, 1
	note E_, 2
	note D_, 6
	note C_, 2
	note D_, 4
	note E_, 1
	note F_, 1
	note E_, 2
	note D_, 4
	note C_, 4
	note D_, 4
	notetype 12, $22
	note C_, 4
	octave 4
	notetype 12, $32
	note G_, 8
	loopchannel 0, Music_PrototypePallet_Ch3
