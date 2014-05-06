Music_PrototypePokecenter:
	db $80
	dw Music_PrototypePokecenter_Ch1
	db $01
	dw Music_PrototypePokecenter_Ch2
	db $02
	dw Music_PrototypePokecenter_Ch3

Music_PrototypePokecenter_Ch1:
	tempo 149
	volume 119
	dutycycle 2
	notetype 12, $67
	octave 2

Music_PrototypePokecenter_Ch1_branch_1:
	note F#, 2
	note G_, 2
	note E_, 2
	note C_, 4
	note C_, 2
	note D#, 2
	note E_, 2
	note C_, 4
	octave 1
	note A#, 2
	octave 2
	note C_, 2
	octave 1
	note A_, 4
	note F_, 2
	note A_, 2
	note G_, 4
	octave 2
	note B_, 2
	note G_, 2
	note E_, 2
	note C_, 2
	note D#, 2
	note E_, 2
	note D_, 4
	note F_, 2
	note F#, 2
	note D_, 8
	octave 1
	note B_, 4
	note B_, 2
	note G_, 2
	note B_, 2
	note __, 2
	octave 2
	note D_, 4
	octave 3
	note G_, 4
	note F_, 2
	note A_, 2
	note G_, 4
	note F_, 2
	note A_, 2
	note F#, 2
	note G_, 2
	note D_, 2
	octave 2
	note A#, 1
	note A_, 1
	octave 3
	note D_, 1
	octave 2
	note A#, 1
	octave 3
	note D_, 1
	note C_, 1
	note D#, 1
	note F_, 1
	note A_, 1
	note G_, 1
	note C_, 2
	note D_, 1
	note F_, 1
	note D#, 2
	note E_, 2
	note F_, 2
	note D_, 1
	note C_, 1
	octave 2
	note A#, 1
	note G_, 1
	note F_, 1
	note D_, 1
	octave 3
	note C_, 2
	note F_, 1
	note D_, 1
	note D#, 2
	note E_, 2
	note C_, 2
	note D_, 1
	note D#, 1
	note C_, 1
	octave 2
	note A#, 1
	octave 3
	note C_, 1
	note D_, 1
	octave 2
	note F#, 2
	note G_, 2
	note E_, 2
	note C_, 1
	note __, 1
	note C_, 4
	note G_, 2
	note F_, 2
	note D#, 2
	note E_, 2
	note G_, 8
	note D_, 4
	note D#, 4
	note G_, 6
	note D_, 2
	note D#, 2
	note F_, 2
	loopchannel 0, Music_PrototypePokecenter_Ch1_branch_1


Music_PrototypePokecenter_Ch2:
	dutycycle 2
	notetype 12, $80
	octave 3

Music_PrototypePokecenter_Ch2_branch_1:
	note F#, 2
	note G_, 2
	note E_, 2
	note G_, 10
	note C_, 4
	octave 2
	note A#, 2
	octave 3
	note C_, 1
	note __, 1
	note C_, 8
	octave 2
	note G_, 8
	note __, 4
	octave 3
	note B_, 2
	octave 4
	note C_, 2
	octave 3
	note A_, 4
	note F_, 2
	note F#, 2
	note D_, 4
	note C_, 2
	note D_, 2
	octave 2
	note B_, 3
	note __, 1
	note B_, 2
	note G_, 2
	note B_, 2
	note __, 2
	note A_, 12
	note __, 8
	octave 3
	note F#, 3
	note __, 1
	note F#, 2
	note G_, 2
	note E_, 4
	note G_, 2
	note E_, 2
	note C_, 4
	note D#, 2
	note E_, 2
	note C_, 4
	octave 2
	note A#, 2
	octave 3
	note C_, 2
	octave 2
	note A_, 4
	note F_, 2
	note A_, 2
	note G_, 8
	octave 3
	note F#, 2
	note G_, 2
	note E_, 2
	note F#, 2
	note G_, 2
	note E_, 2
	note C_, 4
	octave 2
	note G_, 2
	note A_, 2
	octave 3
	note C_, 4
	octave 2
	note G_, 1
	note __, 1
	note G_, 2
	note F_, 4
	note D#, 1
	note __, 1
	note D#, 2
	note G_, 2
	note A_, 4
	octave 3
	note C_, 2
	note D#, 2
	note F_, 2
	loopchannel 0, Music_PrototypePokecenter_Ch2_branch_1


Music_PrototypePokecenter_Ch3:
	notetype 12, $24

Music_PrototypePokecenter_Ch3_branch_1:
	octave 4
	note F#, 2
	note G_, 2
	note E_, 2
	note C_, 9
	note __, 1
	note C_, 4
	octave 3
	note A#, 2
	octave 4
	note C_, 2
	octave 3
	note F_, 8
	note B_, 8
	note __, 8
	octave 4
	note D_, 4
	note F_, 2
	note F#, 2
	octave 3
	note A_, 8
	note B_, 3
	note __, 1
	note B_, 2
	note G_, 2
	note B_, 2
	note __, 2
	octave 4
	note D_, 12
	octave 3
	note G_, 4
	note F_, 2
	note A_, 2
	octave 4
	note D_, 8
	note F#, 2
	note G_, 2
	note C_, 3
	note __, 1
	note C_, 4
	note D#, 2
	note E_, 2
	note C_, 4
	octave 3
	note A#, 2
	octave 4
	note C_, 2
	octave 3
	note A_, 4
	note F_, 2
	note A_, 2
	note G_, 8
	octave 4
	note D_, 4
	note C_, 2
	octave 3
	note F_, 2
	octave 4
	note C_, 2
	note E_, 2
	note C_, 2
	octave 3
	note A#, 2
	octave 4
	note D#, 2
	note E_, 2
	note C_, 4
	octave 3
	note A#, 2
	octave 4
	note C_, 2
	octave 3
	note A_, 4
	note A#, 2
	note A_, 1
	note A#, 1
	note G_, 4
	note F_, 2
	note G_, 2
	note D#, 4
	loopchannel 0, Music_PrototypePokecenter_Ch3_branch_1
	