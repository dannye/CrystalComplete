;Written by Sanqui
INCLUDE "includes.asm"

SECTION "Music_Player", ROMX, BANK[MUSIC_PLAYER]

NUMSONGS EQU 233

MusicTestGFX:
INCBIN "gfx/misc/music_test.2bpp"
PianoGFX:
INCBIN "gfx/misc/piano.2bpp"
NotesGFX:
INCBIN "gfx/misc/note_lines.2bpp"
NotePals:
    RGB 31, 31, 31
    RGB 7, 31, 7
    RGB 7, 7, 31
    RGB 31, 7, 7
NotePalsEnd

placestring_: MACRO
    hlcoord \1, \2
    ld de, \3
    call PlaceString
    ENDM

jbutton: MACRO
	ld a, [hJoyPressed]
	and \1
	jp nz, \2 ; TODO jx
    ENDM

printbit: MACRO
    ld hl, \1
    bit \2, [hl]
    decoord \3, \4
    jr z, .notset\@
    ld a, \5
    ld [de], a
    jr .end\@
.notset\@
    ld a, \6
    ld [de], a
.end\@
    inc de
    ENDM

textbox: MACRO
    hlcoord \1, \2
    ld bc, ( (\4-\2) << 8) + (\3-\1)
    call TextBox
    ENDM

MPLoadPalette:
	ld a, [rSVBK]
	push af

	ld a, 5
	ld [rSVBK], a
	
	ld hl, NotePals
	ld de, OBPals
	ld bc, NotePalsEnd-NotePals
	call CopyBytes

	pop af
	ld [rSVBK], a

; Request palette update
	ld a, 1
	ld [hCGBPalUpdate], a
	ret

MusicPlayer::
	;ld de, 01
	;call PlayMusic
	;call WhiteBGMap
	call ClearTileMap
	hlcoord 6, 5
	ld de, LoadingText
	call PlaceString
	xor a
	ld [hBGMapThird], a
	call DelayFrame
	
	ld b, BANK(MusicTestGFX) ;load the gfx
	ld c, 10
	ld de, MusicTestGFX
	ld hl, $8c60
	call Request2bpp	
	
	ld de, PianoGFX
	ld b, BANK(PianoGFX)
	ld c, $50
	ld hl, $9000
	call Request2bpp
	
	ld de, NotesGFX
	ld b, BANK(NotesGFX)
	ld c, $80
	ld hl, $8000
	call Request2bpp

    call DelayFrame
	call MPLoadPalette
	ld hl, rLCDC
	set 7, [hl]
	ei

	set 2, [hl] ; 8x16 sprites

	call ClearSprites

	xor a
	ld [wNumNoteLines], a
	ld [wChLastNotes], a
	ld [wChLastNotes+1], a
	ld [wChLastNotes+2], a

MPlayerTilemap:

	ld bc, MPTilemapEnd-MPTilemap
	ld hl, MPTilemap
	decoord 0, 0
	call CopyBytes
	
	ld a, [wSongSelection]
	and a ;let's see if a song is currently selected
	jr z, .getsong
	jp .redraw
.getsong ;get the current song
	ld a, [CurMusic]
	jp .redraw
.loop
	call UpdateVisualIntensity
	call DelayFrame
	
	call DrawChData
	call DrawNotes
	
	call GetJoypad
	jbutton B_BUTTON, .exit
	jbutton D_LEFT, .left
	jbutton D_RIGHT, .right
	jbutton D_DOWN, .down
	jbutton D_UP, .up
	jbutton A_BUTTON, .a
	jbutton SELECT, .select
	jbutton START, .start
	
	ld a, 2
	ld [hBGMapThird], a ; prioritize refreshing the note display
    jr .loop
.left
    ld a, [wSongSelection]
    dec a
    cp a, $0
    jr nz, .redraw
    ld a, NUMSONGS-1
    jr .redraw
.right
    ld a, [wSongSelection]
    inc a
    cp a, NUMSONGS
    jr nz, .redraw
    ld a, 1
    jr .redraw
.down
    ld a, [wSongSelection]
    sub a, 10
	jr z, .zerofix
    cp a, NUMSONGS
    jr c, .redraw
.zerofix
    ld a, NUMSONGS-1
    jr .redraw
.up
    ld a, [wSongSelection]
    add a, 10
    cp a, NUMSONGS
    jr c, .redraw
    ld a, 1
    jr .redraw
.start
    call SongSelector
    jp MPlayerTilemap
.redraw	
    ld [wSongSelection], a
    
    ; if this takes too long, don't let the user see
    ; blank fields blink in
	; disable copying the map during vblank
	ld a, 2 ; VBlank2
	ld [$ff9e], a
    
	ld a, " "
	hlcoord 5, 2
	ld bc, 95
	call ByteFill
	hlcoord 0, 8
	ld bc, 90
	call ByteFill
	hlcoord 5, 2
	ld de, wSongSelection
	ld bc, $0103
	call PrintNum
	call DrawSongInfo
	hlcoord 16, 1
	ld de, .daystring
	ld a, [GBPrinter]
	bit 2, a
	jr nz, .nitemusic
.drawtimestring
	call PlaceString
	
	
	xor a ; VBlank0
	ld [$ff9e], a
	
	; refresh top two portions
	xor a
	ld [hBGMapThird], a
	call DelayFrame
	jp .loop
.nitemusic
	ld de, .nitestring
	jr .drawtimestring
.nitestring
	db "Nite@"
.daystring
	db "    @"
.a
	ld a, [wSongSelection]
	ld e, a
	ld d, 0
	callba PlayMusic2
	jp .loop
.select
	ld a, [GBPrinter]
	xor 4
	ld [GBPrinter], a
	ld a, [wSongSelection]
	ld e, a
	ld d, 0
	callba PlayMusic2
	ld a, [wSongSelection]
	jp .redraw
.exit
    call ClearSprites
    ld hl, rLCDC
    res 2, [hl] ; 8x8 sprites
    ret

DrawChData:

	ld a, 0
	hlcoord 0, 14
.ch
	ld [wTmpCh], a
	call .Draw
	inc a
	ld de, 2
	add hl, de
	cp 3
	jr c, .ch

	; Ch4 handling goes here.
	hlcoord $13, $e
	ld a, [MusicNoiseSampleSet]
	add $f6
	ld [hl], a
	hlcoord 16, 16
	ld a, [wC4Vol]
	and $f
	cp 8
	jr c, .okc4

	push af
	ld a, $cf
	ld [hli], a
	ld [hld], a
	pop af
	ld de, -20
	add hl, de

.okc4
	and 7
	add $c7
	ld [hli], a
	ld [hld], a
	ret

.Draw
	push af
	push hl
	call GetPitchAddr
	ld a, [hl]
	ld hl, NoteNames
	call GetNthString
	ld e, l
	ld d, h
	pop hl
	push hl
	call PlaceString
	call GetOctaveAddr
	ld d, [hl]
	ld a, $fe
	sub d
	pop hl
	inc hl
	inc hl
	ld [hli], a

	push hl
	dec hl
	dec hl
	dec hl
	ld a, $c7
	ld de, 20
	add hl, de
	ld [hli], a
	ld [hld], a
	add hl, de
	ld [hli], a
	ld [hld], a

	push hl
	call GetIntensityAddr
	ld a, [hl]
	pop hl
	and $f
	cp 8
	jr c, .ok

	push af
	ld a, $cf
	ld [hli], a
	ld [hld], a
	pop af
	ld de, -20
	add hl, de

.ok
	and 7
	add $c7
	ld [hli], a
	ld [hld], a

	pop hl
	pop af
	ret


DrawNotes:
    ld a, 0
    ld [wTmpCh], a
    call DrawNote
    ld a, 1
    ld [wTmpCh], a
    call DrawNote
    ld a, 2
    ld [wTmpCh], a
    call DrawNote
    call MoveNotes
    ret

CheckEndedNote:
; Check that the current channel is actually playing a note.

; Rests count as ends.
	call GetIntensityAddr
	ld a, [hl]
	and a
	jr z, .ended

	ld a, [wTmpCh]
	ld e, a
	ld bc, Channel2 - Channel1

; Note duration
;	ld a, e
	ld hl, Channel1NoteDuration
	call AddNTimes
	ld a, [hl]
	cp 2
	jr c, .ended

; Channel on/off flag
	ld a, e
	ld hl, Channel1Flags
	call AddNTimes
	bit 0, [hl]
	jr z, .ended

; Rest flag
; Note flags are wiped after each
; note is read, so this is pointless.
	ld a, e
	ld hl, Channel1NoteFlags
	call AddNTimes
	bit 5, [hl]
	jr nz, .ended

.still_going
	and a
	ret

.ended
	scf
	ret

DrawNote:
    call GetPitchAddr
    inc hl
    ld a, [hld] ; octave
    ld c, 14
    call SimpleMultiply
    add [hl] ; pitch
    ld b, a
    ld hl, wChLastNotes
    ld a, [wTmpCh]
    ld e, a
    ld d, 0
    add hl, de
    ld a, [hl]
    cp b
    jp z, DrawLongerNote
    jp DrawChangedNote
    
DrawChangedNote:    
    ld [hl], b
    ld a, [wTmpCh]
    ld bc, 4
    ld hl, Sprites
    call AddNTimes
    call AddNoteToOld
    call SetVisualIntensity
    ; spillover

DrawNewNote:
    call GetPitchAddr
    push hl
    inc hl
    ld a, [hl]
    xor $0f ; why are lower octaves higher.
    sub $8
    ld bc, 28
    ld hl, 08
    call AddNTimes
    ld b, l
    pop hl
    
    ld a, [hl]
    and a
    ret z ; rest
    
    dec a
    ld hl, Pitchels
    ld e, a
    ld d, 0
    add hl, de
    ld a, [hl]
    add b
    ld c, a
    
    push bc
    ld a, [wTmpCh]
    ld bc, 4
    ld hl, Sprites
    call AddNTimes
    pop bc
    ld a, $13*8
    ld [hli], a 
    ld a, c
    ld [hli], a
    
    push hl
    ld hl, $0020
    ld bc, $20
    ld a, [wTmpCh]
    call AddNTimes
    ld a, l
    pop hl
    ;add 1;8
    ld [hli], a
    ld a, $80
    ld [hli], a
    
    ret

DrawLongerNote:
	call CheckEndedNote
	ret c

    ld a, [wTmpCh]
    ld bc, 4
    ld hl, Sprites
    call AddNTimes
    inc hl
    inc hl
    ld a, [hl]
    inc a
    inc a
    ld b, a
    and a, %00011111
    ;srl a
    
    jr z, .newnote
    ld a, b
    ld [hl], a
    ret
.newnote
    dec hl
    dec hl
    call AddNoteToOld
    call DrawNewNote
    ret

SetVisualIntensity:
    ld a,[wTmpCh]
    ld hl, Channel1Pitch
    ld bc, Channel2 - Channel1
    call AddNTimes
    ld a, [hl]
    cp a, 0
    jr z, .skip
    ld a,[wTmpCh]
    ld hl, Channel1Intensity
    ld bc, Channel2 - Channel1
    push af
    call AddNTimes
    pop af
    cp a, 2
    jr z, .wavChannel
    ld a, [hl]
    ld e, a
    swap a
    and $0F
    ld d, a
    
    ld a, [wTmpCh]
    ld hl, wC1Vol
    ld bc, 2
    call AddNTimes
    ld a, d
    ldi [hl], a
    ld a, e
    and $0F
    ld e, a
    swap a
    or e
    and $F7
    ld [hl], a
    ret
.wavChannel
    ld a, [hl]
    and $F0
    cp a, $10
    jr z, .full
    cp a, $20
    jr z, .half
    cp a, $30
    jr z, .quarter
    xor a
    jr .setWavVol
.full
    ld a, $f
    jr .setWavVol
.half
    ld a, $7
    jr .setWavVol
.quarter
    ld a, $3
.setWavVol
    ld hl, wC3Vol
    ld [hl], a
    ret
.skip
    ld a, [wTmpCh]
    ld hl, wC1Vol
    ld bc, 2
    call AddNTimes
    xor a
    ld [hli], a
    ld [hl], a
    ret
UpdateVisualIntensity:
    ld c, 4
    ld hl, wVolTimer
    ld a, [hl]
    sub a, 60
    ld [hl], a
    ret nc
.timerup
    add a, 64
    ldi [hl], a
.updateChannels
    inc hl
    ld a, [hld]
    ld b, a
    and $7F
    jr z, .nextChannel
    ld a, b
    dec a
    ld b, a
    and $0F
    jr z, .changeEnvelope
    inc hl
    jr .doneCh
.changeEnvelope
    ld a, b
    swap a
    or b
    and $F7
    ld b, a
    ld a, [hl]
    bit 7, b
    jr nz, .increase
    dec a
    bit 7, a
    jr z, .doneInc
    xor a
    jr .doneInc
.increase
    inc a
    bit 4, a
    jr z, .doneInc
    ld a, $0F
.doneInc
    ld [hli], a
.doneCh
    ld a, b
    ld [hld], a
.nextChannel
    inc hl
    inc hl
    dec c
    ret z
    ld a, c
    cp a, 2
    jr z, .nextChannel
    jr .updateChannels
 
AddNoteToOld:
    push hl
    ld a, [wNumNoteLines]
    add a
    add a
    ld c, a
    ld b, 0
    ld hl, Sprites+12
    add hl, bc
    push hl
    pop de
    pop hl
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hli]
    ld [de], a
    inc de
    ld a, [hl]
    ld [de], a
    
    ld a, [wNumNoteLines]
    inc a
    cp $25
    jr z, .startover
    ld [wNumNoteLines], a
    ret
.startover
    xor a
    ld [wNumNoteLines], a
    ret

MoveNotes:
    ld b, $28
    ld de, 4
    ld hl, Sprites
.loop
    dec [hl]
    jr z, .remove
.removed
    add hl, de
    dec b
    jr nz, .loop
    ret
.remove
    inc hl
    inc hl
    xor a
    ld [hld], a
    dec hl
    jr .removed
    ret

Pitchels:
    db 1, 3, 5, 7, 9, 13, 15, 17, 19, 21, 23, 25, 27

GetPitchAddr:
    ld a, [wTmpCh]
    add a
    ld hl, PitchAddrs
    ld c, a
    ld b, 0
    add hl, bc
    ld a, [hli]
    ld h, [hl]
    ld l, a
    ret

PitchAddrs:
    dw Channel1Pitch
    dw $c145
    dw $c177

GetOctaveAddr:
	ld a, [wTmpCh]
	ld hl, Channel1Octave
	ld bc, Channel2 - Channel1
	call AddNTimes
	ret

GetIntensityAddr:
	ld a, [wTmpCh]
	ld hl, wC1Vol
	ld bc, 2
	call AddNTimes
	ret

GetSongInfo:
    ld a, [wSongSelection]
    ld b, a
	ld c, 0
    ld hl, SongInfo
.loop
	ld a, [hl]
    cp -1
    jr z, .noname
	inc c
    ld a, c
    cp b
    jr z, .found
.loop2
    ld a, [hli]
	cp "@"
	jr z, .nextline
    jr .loop2
.found
    xor a
    ret
.nextline
	inc hl
	inc hl
	inc hl
	jr .loop
.noname
    scf
    ret

DrawSongInfo:
    ld a, [wSongSelection]
    call GetSongInfo
    ret c ; no data
    
    push hl
    pop de
    hlcoord 0, 4
    call PlaceString
	inc de
	push de
	call GetSongOrigin
    hlcoord 0, 3
    call PlaceString
	pop de
    inc de
	push de
	call GetSongArtist
    hlcoord 0, 8
    call PlaceString
	pop de
    inc de
	push de
	call GetSongArtist2
    hlcoord 0, 11
    call PlaceString
	pop de
    ret

GetSongOrigin:
    ld a, [de]
    ld b, a
    ld hl, Origin
.loop
    ld a, [hli]
    cp -1
    jr z, .noname
    cp b
    jr nz, .loop
    push hl
    pop de
    ret
.noname
	ld de, BlankName
    ret

GetSongArtist:
    ld a, [de]
    ld b, a
    ld hl, Artist
.loop
    ld a, [hli]
    cp -1
    jr z, .noname
    cp b
    jr nz, .loop
    push hl
    pop de
    ret
.noname
	ld de, BlankName
    ret

GetSongArtist2:
    ld a, [de]
    ld b, a
    ld hl, Artist
.loop
    ld a, [hli]
    cp -1
    jr z, .noname
    cp b
    jr nz, .loop
    push hl
	ld de, Additional
	hlcoord 0, 10
    call PlaceString
    pop de
    ret
.noname
	ld de, BlankName
    ret
    
PER_PAGE EQU 15

SongSelector:
	ld bc, MPKeymapEnd-MPKeymap
	ld hl, MPKeymap
	decoord 0, 17
	call CopyBytes
	ld a, " "
	hlcoord 0, 0
	ld bc, 340
	call ByteFill
    call ClearSprites
    textbox 0, 1, $12, $10
    ld a, 1
    ld [wSelectorTop], a
    call UpdateSelectorNames
.loop
    call DelayFrame
	call GetJoypad
	jbutton B_BUTTON, .exit
	jbutton START, .exit
	jbutton D_DOWN, .down
	jbutton D_UP, .up
    jr .loop
.down
    ld a, [wSelectorCur]
    inc a
    cp PER_PAGE
    jr nz, .nextpage
    ld [wSelectorCur], a
    ret ; i'm too lazy
.nextpage
.up
.exit
    ret

UpdateSelectorNames:
    ld a, [wSelectorTop]
    call GetSongInfo
    ld b, 0
    push hl
    pop de
.loop
    hlcoord 2, 2
    push bc
    ld a, b
    ld bc, $0014
    call AddNTimes
    call PlaceString
    inc de
    inc de
    inc de
    inc de
    pop bc
    inc b
    ld a, b
    cp PER_PAGE
    jr nz, .loop
    ret
    

LoadingText:
    db "LOADING…@"

MusicPlayerText:
    db "--- MUSIC PLAYER ---@"

ZeroText:
    db "000@"

NoteNames:
	db "- @"
	db "C @"
	db "C", 198, "@"
	db "D @"
	db "D", 198, "@"
	db "E @
	db "F @"
	db "F", 198, "@"
	db "G @"
	db "G", 198, "@"
	db "A @"
	db "A", 198, "@"
	db "B @"
	db "XX@"

; ┌─┐│└┘
MPTilemap:
db "──┘ MUSIC PLAYER └──"
db "                    "
db "Song:               "
db "                    "
db "                    "
db "                    "
db "                    "
db "Composer:           "
db "                    "
db "                    "
db "                    "
db "                    "
db "                    "
db "Ch1──Ch2──Wave─Noise"
db "    │    │    │Set  "
db "    │    │    │     "
db "    │    │    │     "
db  0,1,2,3,4,5,6,0,1,2,3,4,5,6,0,1,2,3,4,5

MPTilemapEnd

MPKeymap:
db  0,1,2,3,4,5,6,0,1,2,3,4,5,6,0,1,2,3,4,5

MPKeymapEnd

Additional:
	db "Additional Credits:@"

BlankName:
	db " @"
SongInfo:
    db "Title Screen@", 4, 1, 0
    db "Route 1@", 3, 1, 0
    db "Route 3@", 3, 1, 0
    db "Route 11@", 3, 1, 0
    db "Magnet Train@", 3, 1, 0
    db "Vs. Kanto Gym Leader@", 3, 1, 0
    db "Vs. Kanto Trainer@", 3, 1, 0
    db "Vs. Kanto Wild@", 3, 1, 0
    db "Pokémon Center@", 3, 1, 0
    db "Spotted! Hiker@", 3, 1, 0
    db "Spotted! Girl 1@", 3, 1, 0
    db "Spotted! Boy 1@", 3, 1, 0
    db "Heal Pokémon@", 3, 1, 0
    db "Lavender Town@", 3, 1, 0
    db "Viridian Forest@", 3, 1, 0
    db "Kanto Cave@", 3, 1, 0
    db "Follow Me!@", 3, 1, 0
    db "Game Corner@", 3, 1, 0
    db "Bicycle@", 3, 1, 0
    db "Hall of Fame@", 3, 1, 0
    db "Viridian City@", 3, 1, 0
    db "Celadon City@", 3, 1, 0
    db "Victory! Trainer@", 3, 1, 0
    db "Victory! Wild@", 3, 1, 0
    db "Victory! Champion@", 3, 1, 0
    db "Mt. Moon@", 3, 1, 0
    db "Gym@", 3, 1, 0
    db "Pallet Town@", 3, 1, 0
    db "Oak's Lab@", 3, 1, 0
    db "Professor Oak@", 3, 1, 0
    db "Rival Appears@", 3, 1, 0
    db "Rival Departure@", 3, 1, 0
    db "Surfing@", 3, 1, 0
    db "Evolution@", 3, 1, 0
    db "National Park@", 3, 1, 0
    db "Credits@", 3, 1, 0
    db "Azalea Town@", 3, 1, 0
    db "Cherrygrove City@", 3, 1, 0
    db "Spotted! Kimono Girl@", 3, 1, 0
    db "Union Cave@", 3, 1, 0
    db "Vs. Johto Wild@", 3, 1, 0
    db "Vs. Johto Trainer@", 3, 1, 0
    db "Route 30@", 3, 1, 0
    db "Ecruteak City@", 3, 1, 0
    db "Violet City@", 3, 1, 0
    db "Vs. Johto Gym Leader@", 3, 1, 0
    db "Vs. Champion@", 3, 1, 0
    db "Vs. Rival@", 3, 1, 0
    db "Vs. Rocket Grunt@", 3, 1, 0
    db "Elm's Lab@", 3, 1, 0
    db "Dark Cave@", 3, 1, 0
    db "Route 29@", 3, 1, 0
    db "Route 34@", 3, 1, 0
    db "S.S. Aqua@", 3, 1, 0
    db "Spotted! Boy 2@", 3, 1, 0
    db "Spotted! Girl 2@", 3, 1, 0
    db "Spotted! Team Rocket@", 3, 1, 0
    db "Spotted! Suspicious@", 3, 1, 0
    db "Spotted! Sage@", 3, 1, 0
    db "New Bark Town@", 3, 1, 0
    db "Goldenrod City@", 3, 1, 0
    db "Vermilion City@", 3, 1, 0
    db "Pokémon Channel@", 3, 1, 0
    db "PokéFlute@", 3, 1, 0
    db "Tin Tower@", 3, 1, 0
    db "Sprout Tower@", 3, 1, 0
    db "Burned Tower@", 3, 1, 0
    db "Olivine Lighthouse@", 3, 1, 0
    db "Route 42@", 3, 1, 0
    db "Indigo Plateau@", 3, 1, 0
    db "Route 38@", 3, 1, 0
    db "Rocket Hideout@", 3, 1, 0
    db "Dragon's Den@", 3, 1, 0
    db "Vs. Johto Wild Night@", 3, 1, 0
    db "Unown Radio@", 3, 1, 0
    db "Captured Pokémon@", 3, 1, 0
    db "Route 26@", 3, 1, 0
    db "Mom@", 3, 1, 0
    db "Victory Road@", 3, 1, 0
    db "Pokémon Lullaby@", 3, 1, 0
    db "Pokémon March@", 3, 1, 0
    db "Opening 1@", 3, 1, 0
    db "Opening 2@", 3, 1, 0
    db "Load Game@", 3, 1, 0
    db "Ruins of Alph Inside@", 3, 1, 0
    db "Team Rocket@", 3, 1, 0
    db "Dancing Hall@", 3, 1, 0
    db "Bug Contest Ranking@", 3, 1, 0
    db "Bug Contest@", 3, 1, 0
    db "Rocket Radio@", 3, 1, 0
    db "GameBoy Printer@", 3, 1, 0
    db "Post Credits@", 3, 1, 0
    db "Clair@", 4, 1, 0
    db "Mobile Adapter Menu@", 4, 1, 0
    db "Mobile Adapter@", 4, 1, 0
    db "Buena's Password@", 4, 1, 0
    db "Eusine@", 4, 1, 0
    db "Opening@", 4, 1, 0
    db "Battle Tower@", 4, 1, 0
    db "Vs. Suicune@", 4, 1, 0
    db "Battle Tower Lobby@", 4, 1, 0
    db "Mobile Center@", 4, 1, 0
    db "Opening@",  1, 1, 0
    db "Opening@", 2, 1, 0
    db "Title Screen@",  1, 1, 0
    db "Introduction@",  1, 1, 0
    db "Pallet Town@",  1, 1, 0
    db "Professor Oak@",  1, 1, 0
    db "Oak's Lab@",  1, 1, 0
    db "Rival Appears@",  1, 1, 0
    db "Rival Departure@",  1, 1, 0
    db "Route 1@",  1, 1, 0
    db "Viridian City@",  1, 1, 0
    db "Pokémon Center@",  1, 1, 0
    db "Heal Pokémon@",  1, 1, 0
    db "Viridian Forest@",  1, 1, 0
    db "Follow Me!@",  1, 1, 0
    db "Gym@",  1, 1, 0
    db "Jigglypuff Sings@",  1, 1, 0
    db "Route 3@",  1, 1, 0
    db "Mt. Moon@",  1, 1, 0
    db "Jessie and James@", 2, 1, 0
    db "Cerulean City@",  1, 1, 0
    db "Vermilion City@",  1, 1, 0
    db "S.S. Anne@",  1, 1, 0
    db "Route 11@",  1, 1, 0
    db "Lavender Town@",  1, 1, 0
    db "Pokémon Tower@",  1, 1, 0
    db "Celadon City@",  1, 1, 0
    db "Game Corner@",  1, 1, 0
    db "Rocket Hideout@",  1, 1, 0
    db "Bicycle@",  1, 1, 0
    db "Evolution@",  1, 1, 0
    db "Surfing Pikachu@", 2, 1, 0
    db "Silph Co.@",  1, 1, 0
    db "Surfing@",  1, 1, 0
    db "Cinnabar Island@",  1, 1, 0
    db "Cinnabar Mansion@",  1, 1, 0
    db "Indigo Plateau@",  1, 1, 0
    db "Hall of Fame@",  1, 1, 0
    db "Credits@",  1, 1, 0
    db "Spotted! Boy@",  1, 1, 0
    db "Spotted! Girl@",  1, 1, 0
    db "Spotted! Rocket@",  1, 1, 0
    db "Vs. Wild@",  1, 1, 0
    db "Vs. Trainer@",  1, 1, 0
    db "Vs. Gym Leader@",  1, 1, 0
    db "Vs. Champion@",  1, 1, 0
    db "Victory! Wild@",  1, 1, 0
    db "Victory! Trainer@",  1, 1, 0
    db "Victory! Champion@",  1, 1, 0
    db "Unused@",  1, 1, 0
    db "Unused@", 2, 1, 0
	db "Title Screen@", 5, 6, 7
	db "Duel Theme 1@", 5, 6, 7
	db "Duel Theme 2@", 5, 6, 7
	db "Duel Theme 3@", 5, 6, 7
	db "Pause Menu@", 5, 6, 7
	db "PC/Main Menu@", 5, 6, 7
	db "Deck Machine@", 5, 6, 7
	db "Card Pop@", 5, 6, 7
	db "Overworld@", 5, 6, 7
	db "Pokemon Dome@", 5, 6, 7
	db "Challenge Hall@", 5, 6, 7
	db "Club 1@", 5, 6, 7
	db "Club 2@", 5, 6, 7
	db "Club 3@", 5, 6, 7
	db "Ronald@", 5, 6, 7
	db "Imakuni@", 5, 6, 7
	db "Hall Of Honor@", 5, 6, 7
	db "Credits@", 5, 6, 7
	db "Match Start 1@", 5, 6, 7
	db "Match Start 2@", 5, 6, 7
	db "Match Start 3@", 5, 6, 7
	db "Match Victory@", 5, 6, 7
	db "Match Loss@", 5, 6, 7
	db "Dark Diddly@", 5, 6, 7
	db "Booster Pack@", 5, 6, 7
	db "Medal@", 5, 6, 7
	db "Titlescreen@", 6, 6, 7
	db "Here Comes GR@", 6, 6, 7
	db "GR Overworld@", 6, 6, 7
	db "Fort 1@", 6, 6, 7
	db "Fort 2@", 6, 6, 7
	db "Fort 3@", 6, 6, 7
	db "Fort 4@", 6, 6, 7
	db "GR Castle@", 6, 6, 7
	db "GR Challenge Cup@", 6, 6, 7
	db "Game Corner@", 6, 6, 7
	db "GR Blimp@", 6, 6, 7
	db "GR Duel Theme 1@", 6, 6, 7
	db "GR Duel Theme 2@", 6, 6, 7
	db "GR Duel Theme 3@", 6, 6, 7
	db "Ishihara@", 6, 6, 7
	db "Imakuni 2@", 6, 6, 7
	db "Credits@", 6, 6, 7
	db "Diddly 1@", 6, 6, 7
	db "Diddly 2@", 6, 6, 7
	db "Diddly 3@", 6, 6, 7
	db "Diddly 4@", 6, 6, 7
	db "Diddly 5@", 6, 6, 7
	db "Diddly 6@", 6, 6, 7
	db "Red Field Theme@"                         , 7, 8, 0
	db "Catch 'Em & Evolution Mode in Red Field@" , 7, 8, 0
	db "Hurry Up! Red Field@"                     , 7, 8, 0
	db "Pokedex@"                                 , 7, 8, 0
	db "Gengar Stage - Gastly in the Graveyard@"  , 7, 8, 0
	db "Gengar Stage - Haunter in the Graveyard@" , 7, 8, 0
	db "Gengar Stage - Gengar in the Graveyard@"  , 7, 8, 0
	db "Blue Field Theme@"                        , 7, 8, 0
	db "Catch 'Em & Evolution Mode in Blue Field@", 7, 8, 0
	db "Hurry up! Blue Field@"                    , 7, 8, 0
	db "Hi-Score Screen@"                         , 7, 8, 0
	db "Game Over@"                               , 7, 8, 0
	db "Diglett Stage - Whack the Digletts@"      , 7, 8, 0
	db "Diglett Stage - Whack Dugtrio@"           , 7, 8, 0
	db "Seel Stage@"                              , 7, 8, 0
	db "Title Screen@"                            , 7, 8, 0
	db "Mewtwo Stage@"                            , 7, 8, 0
	db "Options@"                                 , 7, 8, 0
	db "Field Select@"                            , 7, 8, 0
	db "Meowth Stage@"                            , 7, 8, 0
	db "End Credits@"                             , 7, 8, 0
	db "Name Entry@"                              , 7, 8, 0
    db "Vs. Naljo Wild@", 8, 3, 2
    db "Vs. Naljo Gym Leader@", 8, 4, 2
    db "Vs. Pallet Patrol@", 8, 5, 2
	db "Pallet Town@", 9, 9, 7
	db "Route 1@", 9, 9, 7
	db "Viridian City@", 9, 9, 7
	db "Pokecenter@", 9, 9, 7
	db "Gym@", 9, 9, 7
    db -1
	
Origin:
	db 01, "Pokémon Red@"
	db 02, "Pokémon Yellow@"
	db 03, "Pokémon Gold@"
	db 04, "Pokémon Crystal@"
	db 05, "Pokémon TCG@"
	db 06, "Pokémon TCG 2@"
	db 07, "Pokémon Pinball@"
	db 08, "Pokémon Prism@"
	db 09, "Pokémon Prototype@"
	db -1
	
Artist:
	db 01, "Junichi Masuda@"
	db 02, "FroggestSpirit@"
	db 03, "LevusBevus@"
	db 04, "GRonnoc@"
	db 05, "Cat333Pokémon@"
	db 06, "Ichiro Shimakura@"
	db 07, "Danny-E 33@"
	db 08, "Go Ichinose (?)@"
	db 09, "Mickey-A 42@"
	db -1
