Music_PrototypeRoute1:
	db $C0
	dw Music_PrototypeRoute1_Ch1
	db $01
	dw Music_PrototypeRoute1_Ch2
	db $02
	dw Music_PrototypeRoute1_Ch3
	db $03
	dw Music_PrototypeRoute1_Ch4

Music_PrototypeRoute1_Ch1:
	tempo 128
	volume 119
	dutycycle 2
	notetype 12, $a7
	octave 2

Music_PrototypeRoute1_Ch1_branch_1:
	note F_, 2
	note __, 2
	loopchannel 8, Music_PrototypeRoute1_Ch1_branch_1

Music_PrototypeRoute1_Ch1_branch_2:
	note F_, 1
	note __, 1
	octave 3
	note C_, 2
	octave 2
	loopchannel 18, Music_PrototypeRoute1_Ch1_branch_2
	note F_, 2
	note __, 6

Music_PrototypeRoute1_Ch1_branch_3:
	callchannel Music_PrototypeRoute1_Ch1_branch_4
	callchannel Music_PrototypeRoute1_Ch1_branch_5
	note D_, 2
	note A_, 2
	callchannel Music_PrototypeRoute1_Ch1_branch_4
	callchannel Music_PrototypeRoute1_Ch1_branch_5
	octave 3
	note D_, 2
	note __, 2
	octave 2
	loopchannel 2, Music_PrototypeRoute1_Ch1_branch_3
	loopchannel 0, Music_PrototypeRoute1_Ch1_branch_2

Music_PrototypeRoute1_Ch1_branch_4:
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	note E_, 2
	note B_, 2
	endchannel

Music_PrototypeRoute1_Ch1_branch_5:
	note D_, 2
	note A_, 2
	note D_, 2
	note A_, 2
	note D_, 2
	note A_, 2
	endchannel


Music_PrototypeRoute1_Ch2:
	dutycycle 2
	octave 4
	notetype 12, $a0
	note __, 16
	note __, 16

Music_PrototypeRoute1_Ch2_branch_1:
	note C_, 2
	note __, 2
	note F_, 2
	note __, 2
	octave 3
	note A_, 1
	note B_, 1
	octave 4
	note C_, 1
	note E_, 1
	note C_, 1
	note D_, 1
	note E_, 1
	note G_, 1
	note F_, 2
	note __, 10
	note C_, 1
	note E_, 1
	note A_, 1
	note B_, 1
	octave 5
	note C_, 2
	note __, 6
	octave 4
	note G_, 1
	note F_, 1
	note G_, 1
	note F_, 1
	note E_, 2
	note D_, 2
	octave 3
	note A_, 2
	note __, 6
	note A_, 2
	octave 4
	note C_, 2
	octave 3
	note A_, 2
	octave 4
	note D_, 2
	octave 3
	note A_, 2
	octave 4
	note E_, 1
	note D_, 1
	note C_, 1
	note D_, 1
	octave 3
	note B_, 1
	octave 4
	note C_, 1
	octave 3
	note A_, 2
	note __, 4
	note F_, 1
	note A_, 1
	notetype 12, $80
	note B_, 12
	octave 4
	note E_, 2
	note __, 2
	octave 3
	note A_, 12
	octave 4
	note D_, 2
	note __, 6
	note F_, 1
	note G_, 1
	note A_, 1
	note __, 1
	note F_, 1
	note G_, 1
	note A_, 1
	note __, 1
	note F_, 1
	note G_, 1
	note A_, 1
	note __, 1
	note F#, 1
	note G_, 1
	note A_, 1
	note __, 1
	note F#, 1
	note G_, 1
	note A_, 1
	note __, 1
	note F#, 1
	note G_, 1
	note A_, 1
	note __, 1
	note D_, 2
	note __, 2
	notetype 12, $60
	octave 3
	note B_, 12
	octave 4
	note E_, 2
	note __, 2
	octave 3
	note A_, 12
	octave 4
	note D_, 2
	note __, 2
	note E_, 12
	note B_, 2
	note __, 2
	note D_, 12
	note A_, 2
	note __, 2
	notetype 12, $a0
	loopchannel 0, Music_PrototypeRoute1_Ch2_branch_1


Music_PrototypeRoute1_Ch3:
	vibrato 8, $25
	notetype 12, $13
	note __, 16
	octave 4
	note A_, 2
	note __, 2
	note A_, 2
	note __, 2
	note A_, 2
	note __, 2
	note A_, 2
	note __, 2

Music_PrototypeRoute1_Ch3_branch_1:
	note A_, 2
	note __, 2
	octave 5
	note C_, 2
	note __, 4
	octave 4
	note G_, 1
	note __, 1
	note A_, 2
	note __, 2
	note F_, 2
	note __, 2
	note A_, 1
	note __, 1
	note A_, 1
	note __, 3
	note A_, 2
	note C_, 2
	note __, 2
	note G_, 1
	note A_, 1
	note G_, 1
	note __, 1
	note F_, 2
	note __, 2
	note F_, 1
	note G_, 1
	note F_, 1
	note __, 1
	note C_, 2
	note __, 2
	octave 3
	note A_, 2
	note __, 6
	octave 4
	note D_, 2
	note __, 2
	note C_, 2
	note __, 2
	octave 3
	note F_, 2
	note __, 3
	octave 4
	note E_, 1
	note F_, 2
	note C_, 2
	note __, 6

Music_PrototypeRoute1_Ch3_branch_2:
	note E_, 12
	note C_, 4
	note D_, 4
	note A_, 2
	note F_, 2
	note D_, 2
	octave 3
	note A_, 2
	note D_, 2
	note __, 2
	octave 4
	loopchannel 2, Music_PrototypeRoute1_Ch3_branch_2

Music_PrototypeRoute1_Ch3_branch_3:
	note E_, 4
	note B_, 2
	note F#, 1
	note __, 4
	note G_, 1
	note G#, 4
	note A_, 2
	note F#, 2
	note D_, 1
	note __, 1
	note F#, 1
	note B_, 1
	note A_, 8
	octave 5
	loopchannel 2, Music_PrototypeRoute1_Ch3_branch_3
	octave 4
	loopchannel 0, Music_PrototypeRoute1_Ch3_branch_1


Music_PrototypeRoute1_Ch4:
	notetype 12
	togglenoise 0
Music_PrototypeRoute1_Ch4_loop_1:
	note G_, 1
	note G_, 1
	note G_, 2
	loopchannel 8, Music_PrototypeRoute1_Ch4_loop_1

Music_PrototypeRoute1_Ch4_branch_1:
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 6
	note G_, 2
	note G_, 2
	note G_, 2
	note G_, 4
	note G_, 2
	note G_, 2
	note G_, 4
	note G_, 2

Music_PrototypeRoute1_Ch4_branch_2:
	note G_, 2
	note G_, 2
	note G_, 4
	loopchannel 4, Music_PrototypeRoute1_Ch4_branch_2
	note G_, 2
	note G_, 5
	note G_, 1
	note G_, 2
	note G_, 8

Music_PrototypeRoute1_Ch4_branch_3:
	note G_, 1
	note G_, 1
	note G_, 2
	note G_, 1
	note G_, 1
	note G_, 2
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 2
	note G_, 1
	note G_, 1
	note G_, 4
	note G_, 1
	note G_, 1
	note G_, 2
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 2
	note G_, 1
	note G_, 1
	note G_, 4
	note G_, 1
	note G_, 1
	note G_, 2
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 2
	note G_, 1
	note G_, 1
	note G_, 4
	note G_, 1
	note G_, 1
	note G_, 2
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 1
	note G_, 4
	loopchannel 2, Music_PrototypeRoute1_Ch4_branch_3
	loopchannel 0, Music_PrototypeRoute1_Ch4_branch_1
