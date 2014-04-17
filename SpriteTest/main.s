	.file	"main.c"
@ GNU C version 3.3.2 (arm-thumb-elf)
@	compiled by GNU C version 3.3.1 (cygming special).
@ GGC heuristics: --param ggc-min-expand=30 --param ggc-min-heapsize=4096
@ options passed:  -fpreprocessed -mthumb-interwork -mlong-calls
@ -auxbase-strip -O2 -Wall -fverbose-asm
@ options enabled:  -fdefer-pop -fomit-frame-pointer
@ -foptimize-sibling-calls -fcse-follow-jumps -fcse-skip-blocks
@ -fexpensive-optimizations -fthread-jumps -fstrength-reduce -fpeephole
@ -fforce-mem -ffunction-cse -fkeep-static-consts -fcaller-saves
@ -freg-struct-return -fgcse -fgcse-lm -fgcse-sm -floop-optimize
@ -fcrossjumping -fif-conversion -fif-conversion2 -frerun-cse-after-loop
@ -frerun-loop-opt -fdelete-null-pointer-checks -fschedule-insns
@ -fschedule-insns2 -fsched-interblock -fsched-spec -fbranch-count-reg
@ -freorder-blocks -freorder-functions -fcprop-registers -fcommon
@ -fverbose-asm -fgnu-linker -fregmove -foptimize-register-move
@ -fargument-alias -fstrict-aliasing -fmerge-constants
@ -fzero-initialized-in-bss -fident -fpeephole2 -fguess-branch-probability
@ -fmath-errno -ftrapping-math -mapcs -mapcs-frame -mapcs-32 -msoft-float
@ -mthumb-interwork -mlong-calls

	.global	videoBuffer
	.data
	.align	2
	.type	videoBuffer, %object
	.size	videoBuffer, 4
videoBuffer:
	.word	100663296
	.text
	.align	2
	.global	DrawPixel3
	.type	DrawPixel3, %function
DrawPixel3:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L2
	rsb	r1, r1, r1, asl #4	@  y,  y
	add	r0, r0, r1, asl #4	@  x
	ldr	r1, [r3, #0]	@  videoBuffer
	mov	r0, r0, asl #1
	@ lr needed for prologue
	strh	r2, [r0, r1]	@ movhi 
	bx	lr
.L3:
	.align	2
.L2:
	.word	videoBuffer
	.size	DrawPixel3, .-DrawPixel3
	.global	paletteMem
	.data
	.align	2
	.type	paletteMem, %object
	.size	paletteMem, 4
paletteMem:
	.word	83886080
	.text
	.align	2
	.global	DrawPixel4
	.type	DrawPixel4, %function
DrawPixel4:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	rsb	r1, r1, r1, asl #4	@  y,  y
	add	r1, r0, r1, asl #4	@  x
	ldr	r3, .L7
	bic	ip, r1, #-16777216
	ldr	lr, [r3, #0]	@  videoBuffer
	bic	ip, ip, #16646144
	bic	ip, ip, #1
	ldrsh	r3, [ip, lr]	@  pixel
	and	r2, r2, #255	@  color
	and	r1, r3, #65280	@  pixel
	and	r3, r3, #255	@  pixel
	tst	r0, #1	@  x
	add	r1, r1, r2	@  color
	add	r3, r3, r2, asl #8	@  color
	strneh	r3, [ip, lr]	@ movhi 
	streqh	r1, [ip, lr]	@ movhi 
	ldr	lr, [sp], #4
	bx	lr
.L8:
	.align	2
.L7:
	.word	videoBuffer
	.size	DrawPixel4, .-DrawPixel4
	.global	ScanlineCounter
	.data
	.align	2
	.type	ScanlineCounter, %object
	.size	ScanlineCounter, 4
ScanlineCounter:
	.word	67108870
	.text
	.align	2
	.global	WaitVBlank
	.type	WaitVBlank, %function
WaitVBlank:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L13
	ldr	r2, [r3, #0]	@  ScanlineCounter
	@ lr needed for prologue
.L10:
	ldrh	r3, [r2, #0]
	cmp	r3, #159
	bls	.L10
	bx	lr
.L14:
	.align	2
.L13:
	.word	ScanlineCounter
	.size	WaitVBlank, .-WaitVBlank
	.global	FrontBuffer
	.data
	.align	2
	.type	FrontBuffer, %object
	.size	FrontBuffer, 4
FrontBuffer:
	.word	100663296
	.global	BackBuffer
	.align	2
	.type	BackBuffer, %object
	.size	BackBuffer, 4
BackBuffer:
	.word	100704256
	.text
	.align	2
	.global	FlipPage
	.type	FlipPage, %function
FlipPage:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r1, #67108864
	ldr	r3, [r1, #0]
	tst	r3, #16
	orr	ip, r3, #16
	bic	r0, r3, #16
	ldrne	r3, .L19
	ldreq	r3, .L19+4
	ldrne	r2, [r3, #0]	@  BackBuffer
	ldreq	r2, [r3, #0]	@  FrontBuffer
	ldr	r3, .L19+8
	@ lr needed for prologue
	strne	r0, [r1, #0]
	streq	ip, [r1, #0]
	str	r2, [r3, #0]	@  videoBuffer
	bx	lr
.L20:
	.align	2
.L19:
	.word	BackBuffer
	.word	FrontBuffer
	.word	videoBuffer
	.size	FlipPage, .-FlipPage
	.align	2
	.global	DMAFastCopy
	.type	DMAFastCopy, %function
DMAFastCopy:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	ip, #67108864
	cmp	r3, #-2080374784	@  mode
	cmpne	r3, #-2147483648	@  mode
	orr	r2, r2, r3	@  count,  mode
	streq	r0, [ip, #212]	@  source
	@ lr needed for prologue
	streq	r1, [ip, #216]	@  dest
	streq	r2, [ip, #220]
	bx	lr
	.size	DMAFastCopy, .-DMAFastCopy
	.align	2
	.global	UpdateSpriteMemory
	.type	UpdateSpriteMemory, %function
UpdateSpriteMemory:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
	mov	r6, #0	@  i
	mov	r9, sp	@  sprites
	cmp	r6, r1	@  i,  count
	sub	sp, sp, r1, asl #3	@  count
	sub	fp, ip, #4
	mov	r8, r0	@  sprites
	mov	r5, #0
	mov	r4, #0	@  sprite
	mov	sl, sp	@  sprites
	bge	.L32
	mov	lr, r6	@  i,  i
	mov	r7, sp	@  sprites
	mov	r6, r1	@  i,  count
.L30:
	add	ip, lr, r8	@  i,  sprites
	ldrh	r1, [ip, #4]	@  <variable>.y
	ldrh	r2, [ip, #20]	@  <variable>.shape
	mov	r3, r4, lsr #16	@  sprite
	orr	r2, r2, r1
	orr	r2, r2, #8192
	mov	r3, r3, asl #16
	orr	r4, r3, r2	@  sprite
	mov	r3, r4, asl #16	@  sprite
	ldrh	r0, [ip, #16]	@  <variable>.size
	mov	r3, r3, lsr #16
	orr	r4, r3, r0, asl #16	@  sprite
	mov	r2, r4, lsr #16	@  sprite
	ldr	r1, [ip, #36]	@  <variable>.hFlip
	mov	r2, r2, asl #16
	mov	r3, r4, asl #16	@  sprite
	cmp	r1, #0
	orr	r2, r2, #268435456
	orrne	r4, r2, r3, lsr #16	@  sprite
	mov	r3, r4, lsr #16	@  sprite
	ldr	r2, [ip, #40]	@  <variable>.vFlip
	mov	r3, r3, asl #16
	mov	r1, r4, asl #16	@  sprite
	cmp	r2, #0
	orr	r3, r3, #536870912
	orrne	r4, r3, r1, lsr #16	@  sprite
	ldrh	r1, [lr, r8]	@  <variable>.x
	mov	r2, r4, asl #16	@  sprite
	mov	r3, r5, lsr #16
	ldrh	r0, [ip, #44]	@  <variable>.location
	mov	r2, r2, lsr #16
	orr	r1, r1, r4, lsr #16	@  sprite
	mov	r3, r3, asl #16
	orr	r4, r2, r1, asl #16	@  sprite
	orr	r5, r3, r0
	subs	r6, r6, #1	@  i,  i
	add	lr, lr, #80	@  i,  i
	stmia	r7!, {r4-r5}	@  tempSprites,  sprite
	bne	.L30
.L32:
	mov	r0, sl	@  sprites
	mov	r1, #117440512
	mov	r2, #512
	mov	r3, #-2147483648
	bl	DMAFastCopy
	mov	sp, r9	@  sprites
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
	.size	UpdateSpriteMemory, .-UpdateSpriteMemory
	.align	2
	.global	GetNextFreePosition
	.type	GetNextFreePosition, %function
GetNextFreePosition:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r2, #0	@  i
	cmp	r2, r1	@  i,  count
	@ lr needed for prologue
	bge	.L41
	add	r0, r0, #60	@  sprites
.L39:
	ldr	r3, [r0, #0]	@  <variable>.isRemoved
	cmp	r3, #0
	add	r0, r0, #80
	movne	r0, r2	@  i,  i
	bxne	lr
	add	r2, r2, #1	@  i,  i
	cmp	r2, r1	@  i,  count
	blt	.L39
.L41:
	bx	lr
	.size	GetNextFreePosition, .-GetNextFreePosition
	.global	BUTTONS
	.data
	.align	2
	.type	BUTTONS, %object
	.size	BUTTONS, 4
BUTTONS:
	.word	67109168
	.text
	.align	2
	.global	CheckButtons
	.type	CheckButtons, %function
CheckButtons:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	ldr	r2, .L43
	ldr	r3, [r2, #0]	@  BUTTONS
	ldrh	r8, [r3, #0]
	ldrh	r1, [r3, #0]
	ldrh	r0, [r3, #0]
	ldrh	ip, [r3, #0]
	ldrh	lr, [r3, #0]
	ldrh	r4, [r3, #0]
	ldrh	r5, [r3, #0]
	ldrh	r6, [r3, #0]
	ldrh	r7, [r3, #0]
	ldrh	r2, [r3, #0]
	mov	r1, r1, lsr #1
	mov	r0, r0, lsr #5
	mov	ip, ip, lsr #4
	mov	lr, lr, lsr #6
	mov	r4, r4, lsr #7
	mov	r5, r5, lsr #3
	mov	r6, r6, lsr #2
	mov	r7, r7, lsr #8
	mov	r2, r2, lsr #9
	ldr	r3, .L43+4
	eor	r8, r8, #1
	eor	r1, r1, #1
	eor	r0, r0, #1
	eor	ip, ip, #1
	eor	lr, lr, #1
	eor	r4, r4, #1
	eor	r5, r5, #1
	eor	r6, r6, #1
	eor	r7, r7, #1
	eor	r2, r2, #1
	and	r8, r8, #1
	and	r1, r1, #1
	and	r0, r0, #1
	and	ip, ip, #1
	and	lr, lr, #1
	and	r4, r4, #1
	and	r5, r5, #1
	and	r6, r6, #1
	and	r7, r7, #1
	and	r2, r2, #1
	str	r2, [r3, #36]	@  buttons
	str	r8, [r3, #0]	@  buttons
	str	r1, [r3, #4]	@  buttons
	str	r0, [r3, #8]	@  buttons
	str	ip, [r3, #12]	@  buttons
	str	lr, [r3, #16]	@  buttons
	str	r4, [r3, #20]	@  buttons
	str	r5, [r3, #24]	@  buttons
	str	r6, [r3, #28]	@  buttons
	str	r7, [r3, #32]	@  buttons
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	bx	lr
.L44:
	.align	2
.L43:
	.word	BUTTONS
	.word	buttons
	.size	CheckButtons, .-CheckButtons
	.align	2
	.global	Pressed
	.type	Pressed, %function
Pressed:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r0, #16	@  button
	ldreq	r3, .L62
	@ lr needed for prologue
	ldreq	r0, [r3, #12]	@  button,  buttons
	bxeq	lr
	bgt	.L59
	cmp	r0, #2	@  button
	ldreq	r3, .L62
	ldreq	r0, [r3, #4]	@  button,  buttons
	bxeq	lr
	bgt	.L60
	cmp	r0, #1	@  button
	ldreq	r3, .L62
	ldreq	r0, [r3, #0]	@  button,  buttons
	bxeq	lr
.L46:
	bx	lr
.L60:
	cmp	r0, #4	@  button
	ldreq	r3, .L62
	ldreq	r0, [r3, #28]	@  button,  buttons
	bxeq	lr
	cmp	r0, #8	@  button
	ldreq	r3, .L62
	ldreq	r0, [r3, #24]	@  button,  buttons
	bne	.L46
	bx	lr
.L59:
	cmp	r0, #128	@  button
	ldreq	r3, .L62
	ldreq	r0, [r3, #20]	@  button,  buttons
	bxeq	lr
	bgt	.L61
	cmp	r0, #32	@  button
	ldreq	r3, .L62
	ldreq	r0, [r3, #8]	@  button,  buttons
	bxeq	lr
	cmp	r0, #64	@  button
	ldreq	r3, .L62
	ldreq	r0, [r3, #16]	@  button,  buttons
	bne	.L46
	bx	lr
.L61:
	cmp	r0, #256	@  button
	ldreq	r3, .L62
	ldreq	r0, [r3, #32]	@  button,  buttons
	bxeq	lr
	cmp	r0, #512	@  button
	ldreq	r3, .L62
	ldreq	r0, [r3, #36]	@  button,  buttons
	bne	.L46
	bx	lr
.L63:
	.align	2
.L62:
	.word	buttons
	.size	Pressed, .-Pressed
	.align	2
	.global	keyPoll
	.type	keyPoll, %function
keyPoll:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r0, .L65
	ldr	r3, .L65+4
	ldr	r2, .L65+8
	ldr	r1, [r3, #0]	@  BUTTONS
	ldrh	r3, [r0, #0]	@ movhi	@  curr_state
	strh	r3, [r2, #0]	@ movhi 	@  prev_state
	ldrh	r3, [r1, #0]
	mvn	r3, r3
	bic	r3, r3, #64512
	@ lr needed for prologue
	strh	r3, [r0, #0]	@ movhi 	@  curr_state
	bx	lr
.L66:
	.align	2
.L65:
	.word	curr_state
	.word	BUTTONS
	.word	prev_state
	.size	keyPoll, .-keyPoll
	.align	2
	.global	keyIsDown
	.type	keyIsDown, %function
keyIsDown:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L68
	ldrh	r2, [r3, #0]	@  curr_state
	and	r2, r2, r0	@  key,  key
	mov	r0, r2	@  key
	@ lr needed for prologue
	bx	lr
.L69:
	.align	2
.L68:
	.word	curr_state
	.size	keyIsDown, .-keyIsDown
	.align	2
	.global	keyIsUp
	.type	keyIsUp, %function
keyIsUp:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L71
	ldrh	r2, [r3, #0]	@  curr_state
	bic	r0, r0, r2	@  key,  key
	@ lr needed for prologue
	bx	lr
.L72:
	.align	2
.L71:
	.word	curr_state
	.size	keyIsUp, .-keyIsUp
	.align	2
	.global	keyWasDown
	.type	keyWasDown, %function
keyWasDown:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L74
	ldrh	r2, [r3, #0]	@  prev_state
	and	r2, r2, r0	@  key,  key
	mov	r0, r2	@  key
	@ lr needed for prologue
	bx	lr
.L75:
	.align	2
.L74:
	.word	prev_state
	.size	keyWasDown, .-keyWasDown
	.align	2
	.global	keyWasUp
	.type	keyWasUp, %function
keyWasUp:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L77
	ldrh	r2, [r3, #0]	@  prev_state
	bic	r0, r0, r2	@  key,  key
	@ lr needed for prologue
	bx	lr
.L78:
	.align	2
.L77:
	.word	prev_state
	.size	keyWasUp, .-keyWasUp
	.align	2
	.global	keyTransition
	.type	keyTransition, %function
keyTransition:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L80
	ldr	r1, .L80+4
	ldrh	r2, [r3, #0]	@  curr_state
	ldrh	r3, [r1, #0]	@  prev_state
	eor	r2, r2, r3
	and	r2, r2, r0	@  key,  key
	mov	r0, r2	@  key
	@ lr needed for prologue
	bx	lr
.L81:
	.align	2
.L80:
	.word	curr_state
	.word	prev_state
	.size	keyTransition, .-keyTransition
	.align	2
	.global	keyHeld
	.type	keyHeld, %function
keyHeld:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L83
	ldr	r1, .L83+4
	ldrh	r2, [r3, #0]	@  curr_state
	ldrh	r3, [r1, #0]	@  prev_state
	and	r2, r2, r3
	and	r2, r2, r0	@  key,  key
	mov	r0, r2	@  key
	@ lr needed for prologue
	bx	lr
.L84:
	.align	2
.L83:
	.word	curr_state
	.word	prev_state
	.size	keyHeld, .-keyHeld
	.align	2
	.global	keyHit
	.type	keyHit, %function
keyHit:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L86
	ldr	r1, .L86+4
	ldrh	r2, [r3, #0]	@  curr_state
	ldrh	r3, [r1, #0]	@  prev_state
	bic	r2, r2, r3
	and	r2, r2, r0	@  key,  key
	mov	r0, r2	@  key
	@ lr needed for prologue
	bx	lr
.L87:
	.align	2
.L86:
	.word	curr_state
	.word	prev_state
	.size	keyHit, .-keyHit
	.align	2
	.global	keyReleased
	.type	keyReleased, %function
keyReleased:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	ldr	r3, .L89
	ldr	r2, .L89+4
	ldrh	r1, [r3, #0]	@  curr_state
	ldrh	r3, [r2, #0]	@  prev_state
	bic	r3, r3, r1
	and	r3, r3, r0	@  key,  key
	mov	r0, r3	@  key
	@ lr needed for prologue
	bx	lr
.L90:
	.align	2
.L89:
	.word	curr_state
	.word	prev_state
	.size	keyReleased, .-keyReleased
	.global	simpleOutside_Palette
	.section	.rodata
	.align	1
	.type	simpleOutside_Palette, %object
	.size	simpleOutside_Palette, 512
simpleOutside_Palette:
	.short	0
	.short	31540
	.short	156
	.short	388
	.short	404
	.short	540
	.short	9100
	.short	9116
	.short	31743
	.short	31
	.short	32767
	.short	272
	.short	644
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.global	simpleOutside_Map
	.align	1
	.type	simpleOutside_Map, %object
	.size	simpleOutside_Map, 8192
simpleOutside_Map:
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	2
	.short	2
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	2
	.short	2
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	3
	.short	3
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	3
	.short	3
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	3
	.short	3
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	4
	.short	4
	.short	0
	.short	0
	.short	0
	.short	0
	.short	4
	.short	4
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	3
	.short	3
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	4
	.short	4
	.short	0
	.short	0
	.short	0
	.short	0
	.short	4
	.short	4
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	3
	.short	3
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	4
	.short	4
	.short	4
	.short	4
	.short	0
	.short	0
	.short	0
	.short	0
	.short	4
	.short	4
	.short	4
	.short	4
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	3
	.short	3
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	4
	.short	4
	.short	4
	.short	4
	.short	0
	.short	0
	.short	0
	.short	0
	.short	4
	.short	4
	.short	4
	.short	4
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	3
	.short	3
	.short	0
	.short	0
	.short	0
	.short	0
	.short	4
	.short	4
	.short	4
	.short	4
	.short	4
	.short	4
	.short	5
	.short	6
	.short	5
	.short	6
	.short	4
	.short	4
	.short	4
	.short	4
	.short	4
	.short	4
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	3
	.short	3
	.short	0
	.short	0
	.short	0
	.short	0
	.short	4
	.short	4
	.short	4
	.short	4
	.short	4
	.short	4
	.short	7
	.short	8
	.short	7
	.short	8
	.short	4
	.short	4
	.short	4
	.short	4
	.short	4
	.short	4
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	5
	.short	6
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	10
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	11
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	7
	.short	8
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.global	simpleOutside_Tiles
	.type	simpleOutside_Tiles, %object
	.size	simpleOutside_Tiles, 768
simpleOutside_Tiles:
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	5
	.byte	5
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	5
	.byte	5
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	2
	.byte	2
	.byte	5
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	2
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	2
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	12
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.global	simpleOutsideHitMap_Map
	.align	1
	.type	simpleOutsideHitMap_Map, %object
	.size	simpleOutsideHitMap_Map, 8192
simpleOutsideHitMap_Map:
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	2
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	2
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	2
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	2
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	2
	.short	2
	.short	2
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	2
	.short	2
	.short	2
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	2
	.short	2
	.short	2
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	2
	.short	2
	.short	2
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	3
	.short	3
	.short	3
	.short	3
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	1
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	3
	.short	3
	.short	3
	.short	4
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	10
	.short	11
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	6
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	7
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	13
	.short	12
	.short	14
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	8
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.short	9
	.global	simpleOutsideHitMap_Tiles
	.type	simpleOutsideHitMap_Tiles, %object
	.size	simpleOutsideHitMap_Tiles, 960
simpleOutsideHitMap_Tiles:
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	2
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	7
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	3
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	1
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	4
	.byte	4
	.byte	5
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	4
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	2
	.global	philFacingRight3Data
	.align	1
	.type	philFacingRight3Data, %object
	.size	philFacingRight3Data, 1024
philFacingRight3Data:
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	512
	.short	0
	.short	0
	.short	0
	.short	19714
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	0
	.short	514
	.short	514
	.short	514
	.short	0
	.short	19789
	.short	19789
	.short	19789
	.short	2
	.short	19789
	.short	333
	.short	257
	.short	1
	.short	19789
	.short	19789
	.short	257
	.short	1
	.short	19789
	.short	19789
	.short	19789
	.short	1
	.short	19789
	.short	19789
	.short	19789
	.short	77
	.short	19789
	.short	19789
	.short	19789
	.short	77
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	0
	.short	0
	.short	3855
	.short	19727
	.short	0
	.short	3840
	.short	6159
	.short	19727
	.short	0
	.short	3840
	.short	3855
	.short	19727
	.short	0
	.short	3840
	.short	11023
	.short	19727
	.short	0
	.short	3840
	.short	3855
	.short	19727
	.short	19789
	.short	19789
	.short	19789
	.short	0
	.short	257
	.short	257
	.short	1
	.short	0
	.short	19789
	.short	19789
	.short	19789
	.short	0
	.short	19789
	.short	19532
	.short	19532
	.short	19532
	.short	19789
	.short	514
	.short	514
	.short	514
	.short	19789
	.short	19532
	.short	19532
	.short	19532
	.short	19789
	.short	19789
	.short	19789
	.short	0
	.short	19789
	.short	19789
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	256
	.short	1
	.short	0
	.short	0
	.short	257
	.short	257
	.short	0
	.short	256
	.short	257
	.short	257
	.short	332
	.short	332
	.short	257
	.short	0
	.short	258
	.short	332
	.short	1
	.short	0
	.short	332
	.short	332
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	512
	.short	0
	.short	0
	.short	257
	.short	257
	.short	0
	.short	0
	.short	257
	.short	257
	.short	0
	.short	0
	.short	0
	.short	1
	.short	0
	.short	0
	.short	0
	.short	1
	.short	0
	.short	0
	.short	0
	.short	1
	.short	0
	.short	0
	.short	0
	.short	1
	.short	0
	.short	0
	.short	0
	.short	1
	.short	0
	.short	0
	.short	0
	.short	3840
	.short	3855
	.short	19727
	.short	0
	.short	0
	.short	3855
	.short	19727
	.short	0
	.short	0
	.short	3855
	.short	271
	.short	0
	.short	0
	.short	0
	.short	19456
	.short	0
	.short	0
	.short	0
	.short	256
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	19789
	.short	19789
	.short	19789
	.short	0
	.short	19789
	.short	19789
	.short	19789
	.short	0
	.short	257
	.short	257
	.short	257
	.short	0
	.short	19532
	.short	19532
	.short	19532
	.short	0
	.short	257
	.short	257
	.short	257
	.short	0
	.short	19714
	.short	19789
	.short	19789
	.short	0
	.short	19714
	.short	19789
	.short	19789
	.short	77
	.short	19714
	.short	19533
	.short	19789
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	589
	.short	0
	.short	0
	.short	19712
	.short	19714
	.short	0
	.short	0
	.short	19788
	.short	19714
	.short	0
	.short	19456
	.short	19532
	.short	19789
	.short	0
	.short	19532
	.short	19532
	.short	76
	.short	0
	.short	19456
	.short	19532
	.short	76
	.short	0
	.short	0
	.short	19532
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	19788
	.short	19789
	.short	19789
	.short	19789
	.short	19456
	.short	19789
	.short	19789
	.short	77
	.short	0
	.short	19788
	.short	19789
	.short	0
	.short	0
	.short	19712
	.short	19789
	.short	0
	.short	0
	.short	19456
	.short	19532
	.short	0
	.short	0
	.short	19456
	.short	19532
	.short	0
	.short	0
	.short	19456
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	77
	.short	0
	.short	0
	.short	0
	.short	77
	.short	0
	.short	0
	.short	0
	.short	77
	.short	0
	.short	0
	.short	0
	.short	76
	.short	0
	.short	0
	.short	0
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.global	philFacingRight3Palette
	.align	1
	.type	philFacingRight3Palette, %object
	.size	philFacingRight3Palette, 512
philFacingRight3Palette:
	.short	0
	.short	2
	.short	1086
	.short	3194
	.short	6358
	.short	7404
	.short	2131
	.short	1071
	.short	1066
	.short	8478
	.short	11645
	.short	17981
	.short	23261
	.short	29734
	.short	23785
	.short	15625
	.short	8358
	.short	20516
	.short	10242
	.short	29963
	.short	30160
	.short	30292
	.short	30456
	.short	2982
	.short	5864
	.short	7656
	.short	6438
	.short	1701
	.short	1378
	.short	8107
	.short	16305
	.short	22454
	.short	3005
	.short	4921
	.short	7696
	.short	6474
	.short	1717
	.short	495
	.short	297
	.short	7101
	.short	12221
	.short	18365
	.short	23485
	.short	2556
	.short	5590
	.short	7536
	.short	6410
	.short	1397
	.short	1296
	.short	203
	.short	5660
	.short	10876
	.short	15037
	.short	23390
	.short	29784
	.short	23764
	.short	16623
	.short	10474
	.short	21554
	.short	16429
	.short	10248
	.short	29945
	.short	30042
	.short	30267
	.short	30428
	.short	27523
	.short	21190
	.short	15880
	.short	10566
	.short	20130
	.short	15873
	.short	11649
	.short	28585
	.short	28590
	.short	29619
	.short	30648
	.short	10570
	.short	19026
	.short	27482
	.short	32767
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.global	philData
	.align	1
	.type	philData, %object
	.size	philData, 1024
philData:
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	589
	.short	0
	.short	19712
	.short	19789
	.short	589
	.short	0
	.short	19712
	.short	257
	.short	257
	.short	0
	.short	19712
	.short	333
	.short	257
	.short	0
	.short	19712
	.short	19789
	.short	257
	.short	0
	.short	19712
	.short	19789
	.short	19789
	.short	0
	.short	19712
	.short	19789
	.short	19788
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	77
	.short	0
	.short	0
	.short	19789
	.short	19789
	.short	0
	.short	0
	.short	257
	.short	19713
	.short	0
	.short	0
	.short	257
	.short	19789
	.short	0
	.short	0
	.short	19713
	.short	19789
	.short	0
	.short	0
	.short	19789
	.short	19789
	.short	0
	.short	0
	.short	19788
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	512
	.short	0
	.short	0
	.short	0
	.short	512
	.short	0
	.short	0
	.short	0
	.short	512
	.short	0
	.short	0
	.short	0
	.short	512
	.short	0
	.short	0
	.short	19789
	.short	19789
	.short	0
	.short	0
	.short	256
	.short	257
	.short	512
	.short	514
	.short	19789
	.short	19789
	.short	19714
	.short	19789
	.short	19789
	.short	19789
	.short	19789
	.short	19789
	.short	19789
	.short	19533
	.short	19789
	.short	19789
	.short	19789
	.short	19533
	.short	77
	.short	19533
	.short	19532
	.short	19532
	.short	77
	.short	19789
	.short	19789
	.short	19789
	.short	19789
	.short	77
	.short	0
	.short	0
	.short	257
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	19789
	.short	19789
	.short	0
	.short	11085
	.short	3355
	.short	19789
	.short	77
	.short	19789
	.short	19789
	.short	19789
	.short	19789
	.short	19789
	.short	19789
	.short	19789
	.short	19789
	.short	19532
	.short	19532
	.short	77
	.short	19789
	.short	19789
	.short	19789
	.short	77
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	512
	.short	0
	.short	0
	.short	0
	.short	512
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	0
	.short	0
	.short	0
	.short	256
	.short	0
	.short	0
	.short	0
	.short	19456
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	77
	.short	19712
	.short	19532
	.short	19788
	.short	77
	.short	19712
	.short	19789
	.short	19789
	.short	77
	.short	19712
	.short	19533
	.short	19788
	.short	1
	.short	256
	.short	257
	.short	257
	.short	76
	.short	19456
	.short	19532
	.short	513
	.short	0
	.short	256
	.short	257
	.short	257
	.short	0
	.short	512
	.short	19789
	.short	19789
	.short	0
	.short	512
	.short	19789
	.short	19789
	.short	19532
	.short	19788
	.short	0
	.short	19789
	.short	19789
	.short	19789
	.short	0
	.short	19789
	.short	19532
	.short	19789
	.short	0
	.short	19789
	.short	257
	.short	257
	.short	0
	.short	257
	.short	19457
	.short	19532
	.short	0
	.short	19532
	.short	257
	.short	257
	.short	0
	.short	0
	.short	19789
	.short	19789
	.short	0
	.short	0
	.short	19789
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	512
	.short	19789
	.short	19789
	.short	0
	.short	512
	.short	19789
	.short	77
	.short	0
	.short	512
	.short	19789
	.short	77
	.short	0
	.short	512
	.short	19789
	.short	77
	.short	0
	.short	512
	.short	19789
	.short	77
	.short	0
	.short	19456
	.short	19532
	.short	76
	.short	0
	.short	19532
	.short	19532
	.short	76
	.short	0
	.short	19532
	.short	19532
	.short	76
	.short	19789
	.short	19789
	.short	0
	.short	0
	.short	19789
	.short	19789
	.short	0
	.short	0
	.short	19789
	.short	19789
	.short	0
	.short	0
	.short	19789
	.short	19789
	.short	0
	.short	0
	.short	19789
	.short	19789
	.short	0
	.short	0
	.short	19532
	.short	19532
	.short	0
	.short	0
	.short	19532
	.short	19532
	.short	76
	.short	0
	.short	19532
	.short	19532
	.short	76
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.global	philPalette
	.align	1
	.type	philPalette, %object
	.size	philPalette, 512
philPalette:
	.short	0
	.short	2
	.short	1086
	.short	3194
	.short	6358
	.short	7404
	.short	2131
	.short	1071
	.short	1066
	.short	8478
	.short	11645
	.short	17981
	.short	23261
	.short	29734
	.short	23785
	.short	15625
	.short	8358
	.short	20516
	.short	10242
	.short	29963
	.short	30160
	.short	30292
	.short	30456
	.short	2982
	.short	5864
	.short	7656
	.short	6438
	.short	1701
	.short	1378
	.short	8107
	.short	16305
	.short	22454
	.short	3005
	.short	4921
	.short	7696
	.short	6474
	.short	1717
	.short	495
	.short	297
	.short	7101
	.short	12221
	.short	18365
	.short	23485
	.short	2556
	.short	5590
	.short	7536
	.short	6410
	.short	1397
	.short	1296
	.short	203
	.short	5660
	.short	10876
	.short	15037
	.short	23390
	.short	29784
	.short	23764
	.short	16623
	.short	10474
	.short	21554
	.short	16429
	.short	10248
	.short	29945
	.short	30042
	.short	30267
	.short	30428
	.short	27523
	.short	21190
	.short	15880
	.short	10566
	.short	20130
	.short	15873
	.short	11649
	.short	28585
	.short	28590
	.short	29619
	.short	30648
	.short	10570
	.short	19026
	.short	27482
	.short	32767
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.global	philFacingRightData
	.align	1
	.type	philFacingRightData, %object
	.size	philFacingRightData, 1024
philFacingRightData:
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	512
	.short	0
	.short	0
	.short	0
	.short	19714
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	0
	.short	514
	.short	514
	.short	514
	.short	0
	.short	19789
	.short	19789
	.short	19789
	.short	2
	.short	19789
	.short	333
	.short	257
	.short	1
	.short	19789
	.short	19789
	.short	257
	.short	1
	.short	19789
	.short	19789
	.short	19789
	.short	1
	.short	19789
	.short	19789
	.short	19789
	.short	77
	.short	19789
	.short	19789
	.short	19789
	.short	77
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	0
	.short	0
	.short	19532
	.short	19788
	.short	0
	.short	19456
	.short	6220
	.short	19788
	.short	0
	.short	19456
	.short	19532
	.short	19788
	.short	0
	.short	19456
	.short	11084
	.short	19788
	.short	0
	.short	19456
	.short	19532
	.short	19788
	.short	19789
	.short	19789
	.short	19789
	.short	0
	.short	257
	.short	257
	.short	1
	.short	0
	.short	19789
	.short	19789
	.short	19789
	.short	0
	.short	19789
	.short	19532
	.short	19532
	.short	19532
	.short	19789
	.short	514
	.short	514
	.short	514
	.short	19789
	.short	19532
	.short	19532
	.short	19532
	.short	19789
	.short	19789
	.short	19789
	.short	0
	.short	19789
	.short	19789
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	256
	.short	1
	.short	0
	.short	0
	.short	257
	.short	257
	.short	0
	.short	256
	.short	257
	.short	257
	.short	332
	.short	332
	.short	257
	.short	0
	.short	258
	.short	332
	.short	1
	.short	0
	.short	332
	.short	332
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	512
	.short	0
	.short	0
	.short	257
	.short	257
	.short	0
	.short	0
	.short	257
	.short	257
	.short	0
	.short	0
	.short	0
	.short	1
	.short	0
	.short	0
	.short	0
	.short	1
	.short	0
	.short	0
	.short	0
	.short	1
	.short	0
	.short	0
	.short	0
	.short	1
	.short	0
	.short	0
	.short	0
	.short	1
	.short	0
	.short	0
	.short	0
	.short	19456
	.short	19532
	.short	76
	.short	0
	.short	0
	.short	19532
	.short	76
	.short	0
	.short	0
	.short	19532
	.short	76
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	19789
	.short	19789
	.short	0
	.short	19789
	.short	19789
	.short	77
	.short	0
	.short	257
	.short	257
	.short	1
	.short	0
	.short	19532
	.short	19532
	.short	76
	.short	0
	.short	257
	.short	257
	.short	1
	.short	0
	.short	19789
	.short	19714
	.short	77
	.short	0
	.short	19789
	.short	19714
	.short	77
	.short	0
	.short	19789
	.short	19714
	.short	77
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	19714
	.short	77
	.short	0
	.short	19789
	.short	19714
	.short	77
	.short	0
	.short	19789
	.short	19714
	.short	77
	.short	0
	.short	19789
	.short	19714
	.short	77
	.short	0
	.short	19789
	.short	19714
	.short	77
	.short	0
	.short	19532
	.short	19532
	.short	76
	.short	0
	.short	19532
	.short	19532
	.short	19532
	.short	0
	.short	19532
	.short	19532
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.global	philFacingRightPalette
	.align	1
	.type	philFacingRightPalette, %object
	.size	philFacingRightPalette, 512
philFacingRightPalette:
	.short	0
	.short	2
	.short	1086
	.short	3194
	.short	6358
	.short	7404
	.short	2131
	.short	1071
	.short	1066
	.short	8478
	.short	11645
	.short	17981
	.short	23261
	.short	29734
	.short	23785
	.short	15625
	.short	8358
	.short	20516
	.short	10242
	.short	29963
	.short	30160
	.short	30292
	.short	30456
	.short	2982
	.short	5864
	.short	7656
	.short	6438
	.short	1701
	.short	1378
	.short	8107
	.short	16305
	.short	22454
	.short	3005
	.short	4921
	.short	7696
	.short	6474
	.short	1717
	.short	495
	.short	297
	.short	7101
	.short	12221
	.short	18365
	.short	23485
	.short	2556
	.short	5590
	.short	7536
	.short	6410
	.short	1397
	.short	1296
	.short	203
	.short	5660
	.short	10876
	.short	15037
	.short	23390
	.short	29784
	.short	23764
	.short	16623
	.short	10474
	.short	21554
	.short	16429
	.short	10248
	.short	29945
	.short	30042
	.short	30267
	.short	30428
	.short	27523
	.short	21190
	.short	15880
	.short	10566
	.short	20130
	.short	15873
	.short	11649
	.short	28585
	.short	28590
	.short	29619
	.short	30648
	.short	10570
	.short	19026
	.short	27482
	.short	32767
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.global	philFacingRight2Data
	.align	1
	.type	philFacingRight2Data, %object
	.size	philFacingRight2Data, 1024
philFacingRight2Data:
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	512
	.short	0
	.short	0
	.short	0
	.short	19714
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	0
	.short	514
	.short	514
	.short	514
	.short	0
	.short	19789
	.short	19789
	.short	19789
	.short	2
	.short	19789
	.short	333
	.short	257
	.short	1
	.short	19789
	.short	19789
	.short	257
	.short	1
	.short	19789
	.short	19789
	.short	19789
	.short	1
	.short	19789
	.short	19789
	.short	19789
	.short	77
	.short	19789
	.short	19789
	.short	19789
	.short	77
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	0
	.short	0
	.short	3855
	.short	19727
	.short	0
	.short	3840
	.short	6159
	.short	19727
	.short	0
	.short	3840
	.short	3855
	.short	19727
	.short	0
	.short	3840
	.short	11023
	.short	19727
	.short	0
	.short	3840
	.short	3855
	.short	19727
	.short	19789
	.short	19789
	.short	19789
	.short	0
	.short	257
	.short	257
	.short	1
	.short	0
	.short	19789
	.short	19789
	.short	19789
	.short	0
	.short	19789
	.short	19532
	.short	19532
	.short	19532
	.short	19789
	.short	514
	.short	514
	.short	514
	.short	19789
	.short	19532
	.short	19532
	.short	19532
	.short	19789
	.short	19789
	.short	19789
	.short	0
	.short	19789
	.short	19789
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	256
	.short	1
	.short	0
	.short	0
	.short	257
	.short	257
	.short	0
	.short	256
	.short	257
	.short	257
	.short	332
	.short	332
	.short	257
	.short	0
	.short	258
	.short	332
	.short	1
	.short	0
	.short	332
	.short	332
	.short	1
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	512
	.short	0
	.short	0
	.short	257
	.short	257
	.short	0
	.short	0
	.short	257
	.short	257
	.short	0
	.short	0
	.short	0
	.short	1
	.short	0
	.short	0
	.short	0
	.short	1
	.short	0
	.short	0
	.short	0
	.short	1
	.short	0
	.short	0
	.short	0
	.short	1
	.short	0
	.short	0
	.short	0
	.short	1
	.short	0
	.short	0
	.short	0
	.short	3840
	.short	3855
	.short	19727
	.short	0
	.short	0
	.short	3855
	.short	19727
	.short	0
	.short	0
	.short	3855
	.short	271
	.short	0
	.short	0
	.short	0
	.short	19456
	.short	0
	.short	0
	.short	0
	.short	256
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	19789
	.short	19789
	.short	19789
	.short	0
	.short	19789
	.short	19789
	.short	19789
	.short	0
	.short	257
	.short	257
	.short	257
	.short	0
	.short	19532
	.short	19532
	.short	19532
	.short	0
	.short	257
	.short	257
	.short	257
	.short	0
	.short	19789
	.short	19714
	.short	19789
	.short	0
	.short	19789
	.short	589
	.short	19789
	.short	77
	.short	19532
	.short	19789
	.short	19714
	.short	19789
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	0
	.short	0
	.short	19712
	.short	19789
	.short	0
	.short	0
	.short	19789
	.short	19789
	.short	0
	.short	0
	.short	19788
	.short	19789
	.short	0
	.short	19456
	.short	19532
	.short	77
	.short	0
	.short	19532
	.short	19532
	.short	76
	.short	0
	.short	19456
	.short	19532
	.short	19532
	.short	0
	.short	0
	.short	19532
	.short	19532
	.short	19789
	.short	19788
	.short	589
	.short	19789
	.short	19789
	.short	19456
	.short	19789
	.short	19714
	.short	77
	.short	0
	.short	19788
	.short	19714
	.short	0
	.short	0
	.short	19712
	.short	19714
	.short	0
	.short	0
	.short	19712
	.short	19714
	.short	0
	.short	0
	.short	19456
	.short	19532
	.short	0
	.short	0
	.short	19456
	.short	19532
	.short	0
	.short	0
	.short	19456
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	0
	.short	77
	.short	0
	.short	0
	.short	0
	.short	77
	.short	0
	.short	0
	.short	0
	.short	77
	.short	0
	.short	0
	.short	0
	.short	77
	.short	0
	.short	0
	.short	0
	.short	76
	.short	0
	.short	0
	.short	0
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	19532
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.global	philFacingRight2Palette
	.align	1
	.type	philFacingRight2Palette, %object
	.size	philFacingRight2Palette, 512
philFacingRight2Palette:
	.short	0
	.short	2
	.short	1086
	.short	3194
	.short	6358
	.short	7404
	.short	2131
	.short	1071
	.short	1066
	.short	8478
	.short	11645
	.short	17981
	.short	23261
	.short	29734
	.short	23785
	.short	15625
	.short	8358
	.short	20516
	.short	10242
	.short	29963
	.short	30160
	.short	30292
	.short	30456
	.short	2982
	.short	5864
	.short	7656
	.short	6438
	.short	1701
	.short	1378
	.short	8107
	.short	16305
	.short	22454
	.short	3005
	.short	4921
	.short	7696
	.short	6474
	.short	1717
	.short	495
	.short	297
	.short	7101
	.short	12221
	.short	18365
	.short	23485
	.short	2556
	.short	5590
	.short	7536
	.short	6410
	.short	1397
	.short	1296
	.short	203
	.short	5660
	.short	10876
	.short	15037
	.short	23390
	.short	29784
	.short	23764
	.short	16623
	.short	10474
	.short	21554
	.short	16429
	.short	10248
	.short	29945
	.short	30042
	.short	30267
	.short	30428
	.short	27523
	.short	21190
	.short	15880
	.short	10566
	.short	20130
	.short	15873
	.short	11649
	.short	28585
	.short	28590
	.short	29619
	.short	30648
	.short	10570
	.short	19026
	.short	27482
	.short	32767
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.global	laserData
	.align	1
	.type	laserData, %object
	.size	laserData, 64
laserData:
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	514
	.short	514
	.short	514
	.short	514
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.global	mapTiles
	.data
	.align	2
	.type	mapTiles, %object
	.size	mapTiles, 4
mapTiles:
	.word	simpleOutside_Tiles
	.global	map
	.align	2
	.type	map, %object
	.size	map, 4
map:
	.word	simpleOutside_Map
	.global	mapPalette
	.align	2
	.type	mapPalette, %object
	.size	mapPalette, 4
mapPalette:
	.word	simpleOutside_Palette
	.global	hitMap
	.align	2
	.type	hitMap, %object
	.size	hitMap, 4
hitMap:
	.word	simpleOutsideHitMap_Map
	.global	hitMapTiles
	.align	2
	.type	hitMapTiles, %object
	.size	hitMapTiles, 4
hitMapTiles:
	.word	simpleOutsideHitMap_Tiles
	.global	isJumping
	.bss
	.global	isJumping
	.align	2
	.type	isJumping, %object
	.size	isJumping, 4
isJumping:
	.space	4
	.global	isMoving
	.global	isMoving
	.align	2
	.type	isMoving, %object
	.size	isMoving, 4
isMoving:
	.space	4
	.global	walkingCounter
	.global	walkingCounter
	.align	2
	.type	walkingCounter, %object
	.size	walkingCounter, 4
walkingCounter:
	.space	4
	.global	mapLeft
	.global	mapLeft
	.align	2
	.type	mapLeft, %object
	.size	mapLeft, 4
mapLeft:
	.space	4
	.global	mapRight
	.data
	.align	2
	.type	mapRight, %object
	.size	mapRight, 4
mapRight:
	.word	255
	.global	screenLeft
	.bss
	.global	screenLeft
	.align	2
	.type	screenLeft, %object
	.size	screenLeft, 4
screenLeft:
	.space	4
	.global	screenRight
	.data
	.align	2
	.type	screenRight, %object
	.size	screenRight, 4
screenRight:
	.word	239
	.global	nextColumn
	.bss
	.global	nextColumn
	.align	2
	.type	nextColumn, %object
	.size	nextColumn, 4
nextColumn:
	.space	4
	.global	prevColumn
	.global	prevColumn
	.align	2
	.type	prevColumn, %object
	.size	prevColumn, 4
prevColumn:
	.space	4
	.global	mapTop
	.global	mapTop
	.align	2
	.type	mapTop, %object
	.size	mapTop, 4
mapTop:
	.space	4
	.global	mapBottom
	.data
	.align	2
	.type	mapBottom, %object
	.size	mapBottom, 4
mapBottom:
	.word	255
	.global	screenTop
	.bss
	.global	screenTop
	.align	2
	.type	screenTop, %object
	.size	screenTop, 4
screenTop:
	.space	4
	.global	screenBottom
	.data
	.align	2
	.type	screenBottom, %object
	.size	screenBottom, 4
screenBottom:
	.word	159
	.global	nextRow
	.bss
	.global	nextRow
	.align	2
	.type	nextRow, %object
	.size	nextRow, 4
nextRow:
	.space	4
	.global	prevRow
	.global	prevRow
	.align	2
	.type	prevRow, %object
	.size	prevRow, 4
prevRow:
	.space	4
	.global	regX
	.global	regX
	.align	2
	.type	regX, %object
	.size	regX, 4
regX:
	.space	4
	.global	regY
	.global	regY
	.align	2
	.type	regY, %object
	.size	regY, 4
regY:
	.space	4
	.text
	.align	2
	.global	Initialize
	.type	Initialize, %function
Initialize:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 16
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, sl, fp, ip, lr, pc}
	mov	r2, #4416
	sub	fp, ip, #4
	sub	sp, sp, #16
	mov	r3, #67108864
	mov	r1, #83886080
	ldr	r0, .L155
	add	r1, r1, #512
	str	r2, [r3, #0]
	mov	r2, #0	@  n
.L96:
	mov	r3, r2, asl #1	@  n
	ldrh	r4, [r3, r0]	@ movhi	@  philPalette
	add	r2, r2, #1	@  n,  n
	cmp	r2, #255	@  n
	strh	r4, [r3, r1]	@ movhi 
	ble	.L96
	mov	r0, #508
	mov	r1, #100663296
	ldr	ip, .L155+4
	mov	r2, #0	@  n
	add	r0, r0, #3
	add	r1, r1, #65536
.L101:
	mov	r3, r2, asl #1	@  n
	ldrh	lr, [r3, ip]	@ movhi	@  philData
	add	r2, r2, #1	@  n,  n
	cmp	r2, r0	@  n
	strh	lr, [r3, r1]	@ movhi 
	ble	.L101
	mov	r2, #512	@  n
	mov	r0, #100663296
	ldr	lr, .L155+8
	add	ip, r2, r2	@  n
	add	r0, r0, #65536
	mov	r1, #0
.L106:
	mov	r3, r2, asl #1	@  n
	ldrh	r4, [r1, lr]	@ movhi	@  philFacingRightData
	add	r2, r2, #1	@  n,  n
	cmp	r2, ip	@  n
	strh	r4, [r3, r0]	@ movhi 
	add	r1, r1, #2
	blt	.L106
	add	r3, r2, #512	@  n
	mov	r0, #100663296
	ldr	lr, .L155+12
	mov	ip, r3
	add	r0, r0, #65536
	mov	r1, #0
.L111:
	mov	r3, r2, asl #1	@  n
	ldrh	r4, [r1, lr]	@ movhi	@  philFacingRight2Data
	add	r2, r2, #1	@  n,  n
	cmp	r2, ip	@  n
	strh	r4, [r3, r0]	@ movhi 
	add	r1, r1, #2
	blt	.L111
	add	r3, r2, #512	@  n
	mov	r0, #100663296
	ldr	lr, .L155+16
	mov	ip, r3
	add	r0, r0, #65536
	mov	r1, #0
.L116:
	mov	r3, r2, asl #1	@  n
	ldrh	r4, [r1, lr]	@ movhi	@  philFacingRight3Data
	add	r2, r2, #1	@  n,  n
	cmp	r2, ip	@  n
	strh	r4, [r3, r0]	@ movhi 
	add	r1, r1, #2
	blt	.L116
	add	r3, r2, #32	@  n
	mov	ip, #100663296
	ldr	lr, .L155+20
	mov	r0, r3
	add	ip, ip, #65536
	mov	r1, #0
.L121:
	mov	r3, r2, asl #1	@  n
	ldrh	r4, [r1, lr]	@ movhi	@  laserData
	add	r2, r2, #1	@  n,  n
	cmp	r2, r0	@  n
	strh	r4, [r3, ip]	@ movhi 
	add	r1, r1, #2
	blt	.L121
	ldr	r7, .L155+24
	mov	r0, #160
	mov	sl, #240
	mov	r8, #1
	mov	r1, #0	@  n
	mov	r2, #127	@  n
.L126:
	add	r3, r1, r7	@  n
	subs	r2, r2, #1	@  n,  n
	str	sl, [r1, r7]	@  <variable>.x
	str	r8, [r3, #60]	@  <variable>.isRemoved
	str	r0, [r3, #4]	@  <variable>.y
	add	r1, r1, #80	@  n,  n
	bpl	.L126
	ldr	r6, .L155+28
	mov	r5, #0	@  i
	ldr	lr, [r6, #0]	@  numberOfSprites
	mov	r3, #16
	mov	r2, #32
	str	r3, [fp, #-44]	@  characterBBox.xsize
	str	r2, [fp, #-40]	@  characterBBox.ysize
	str	r5, [fp, #-52]	@  i,  characterBBox.x
	str	r5, [fp, #-48]	@  i,  characterBBox.y
	sub	ip, fp, #52
	add	lr, lr, #1
	ldmia	ip, {r0, r1, r2, r3}
	ldr	r4, .L155+32
	str	lr, [r6, #0]	@  numberOfSprites
	ldr	lr, .L155+36
	mov	ip, #32768
	str	ip, [r7, #16]	@  <variable>.size
	str	r5, [lr, #0]	@  i,  characterSpriteIndex
	str	r5, [r7, #4]	@  i,  <variable>.y
	str	r5, [r7, #0]	@  i,  <variable>.x
	str	r5, [r7, #8]	@  i,  <variable>.mapX
	str	r5, [r7, #12]	@  i,  <variable>.mapY
	str	r5, [r7, #20]	@  i,  <variable>.shape
	str	r5, [r7, #44]	@  i,  <variable>.location
	stmia	r4, {r0, r1, r2, r3}
	str	r8, [r7, #56]	@  <variable>.speed
	str	r5, [r7, #60]	@  i,  <variable>.isRemoved
	str	r5, [r7, #48]	@  i,  <variable>.noGravity
	str	r5, [r7, #52]	@  i,  <variable>.isProjectile
	bl	WaitVBlank
	sub	r0, r4, #64
	mov	r1, #128
	bl	UpdateSpriteMemory
	ldr	r3, .L155+40
	mov	ip, #100663296
	ldr	r6, .L155+44
	ldr	r7, .L155+48
	mov	r4, ip
	mov	lr, #8064	@ movhi
	add	ip, ip, #63488
	ldr	r0, [r3, #0]	@  mapPalette
	mov	r2, #7296	@ movhi
	mov	r3, #67108864
	add	r4, r4, #57344
	strh	lr, [r3, #8]	@ movhi 
	str	ip, [r6, #0]	@  bg0map
	strh	r2, [r3, #10]	@ movhi 
	mov	r1, #83886080
	mov	r2, #256
	mov	r3, #-2147483648
	str	r4, [r7, #0]	@  bg1map
	bl	DMAFastCopy
	ldr	r3, .L155+52
	mov	r1, #100663296
	ldr	r0, [r3, #0]	@  mapTiles
	mov	r2, #192
	mov	r3, #-2080374784
	bl	DMAFastCopy
	ldr	r3, .L155+56
	mov	r1, #100663296
	ldr	r0, [r3, #0]	@  hitMapTiles
	mov	r2, sl
	mov	r3, #-2080374784
	add	r1, r1, #32768
	bl	DMAFastCopy
	ldr	r3, .L155+60
	ldr	ip, [r3, #0]	@  map
	ldr	r3, .L155+64
	ldr	r6, [r6, #0]	@  bg0map
	ldr	r7, [r7, #0]	@  bg1map
	ldr	r3, [r3, #0]	@  hitMap
	mov	lr, r5	@  i,  i
.L136:
	mov	r1, lr, asl #1	@  i
	mov	r2, lr	@  i,  i
	mov	r0, #31	@  j
.L135:
	ldrh	r4, [r1, ip]	@ movhi
	strh	r4, [r2, r6]	@ movhi 
	ldrh	r4, [r1, r3]	@ movhi
	subs	r0, r0, #1	@  j,  j
	strh	r4, [r2, r7]	@ movhi 
	add	r1, r1, #2
	add	r2, r2, #2	@  i,  i
	bpl	.L135
	add	r5, r5, #1	@  i,  i
	cmp	r5, #31	@  i
	add	lr, lr, #64	@  i,  i
	ble	.L136
	ldmea	fp, {r4, r5, r6, r7, r8, sl, fp, sp, lr}
	bx	lr
.L156:
	.align	2
.L155:
	.word	philPalette
	.word	philData
	.word	philFacingRightData
	.word	philFacingRight2Data
	.word	philFacingRight3Data
	.word	laserData
	.word	sprites
	.word	numberOfSprites
	.word	sprites+64
	.word	characterSpriteIndex
	.word	mapPalette
	.word	bg0map
	.word	bg1map
	.word	mapTiles
	.word	hitMapTiles
	.word	map
	.word	hitMap
	.size	Initialize, .-Initialize
	.align	2
	.global	Update
	.type	Update, %function
Update:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #72
	bl	keyPoll
	mov	r0, #64
	bl	keyHit
	cmp	r0, #0
	ldreq	r7, .L219
	beq	.L158
	ldr	r7, .L219
	ldr	r1, [r7, #0]	@  isJumping
	cmp	r1, #0
	bne	.L207
	ldr	r3, .L219+4
	str	r1, [r3, #0]	@  walkingCounter
	ldr	r3, .L219+8
	mov	r2, #1
	str	r2, [r7, #0]	@  isJumping
	str	r1, [r3, #0]	@  jumpDuration
.L158:
	ldr	r3, [r7, #0]	@  isJumping
	cmp	r3, #0
	beq	.L159
.L207:
	ldr	r5, .L219+8
	ldr	r3, [r5, #0]	@  jumpDuration
	cmp	r3, #19
	ble	.L212
.L159:
	ldr	r3, .L219+12
	mov	lr, pc
	bx	r3
	ldr	r6, .L219+16
.L160:
	mov	r0, #16
	bl	keyHeld
	cmp	r0, #0
	beq	.L161
	ldr	r3, [r7, #0]	@  isJumping
	cmp	r3, #0
	bne	.L204
	ldr	r3, .L219+4
	ldr	r2, .L219+20
	ldr	r1, [r3, #0]	@  walkingCounter
	smull	r3, r0, r2, r1
	mov	r3, r1, asr #31
	rsb	r3, r3, r0, asr #4
	add	r3, r3, r3, asl #2
	sub	r1, r1, r3, asl #3
	cmp	r1, #10
	beq	.L213
	cmp	r1, #20
	beq	.L210
	cmp	r1, #30
	beq	.L214
	cmp	r1, #0
	bne	.L204
.L210:
	ldr	r4, .L219+24
	ldr	r3, [r4, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #2
	add	r3, r6, r3, asl #4
	mov	r2, #32
.L208:
	str	r2, [r3, #44]	@  <variable>.location
.L162:
	ldr	r3, [r4, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #2
	mov	r3, r3, asl #4
	ldr	r2, [r3, r6]	@  <variable>.x
	add	r4, r3, r6
	cmp	r2, #119
	mov	r2, #0
	str	r2, [r4, #36]	@  <variable>.hFlip
	ble	.L171
	ldr	r3, .L219+28
	mov	r2, #508
	ldr	r1, [r3, #0]	@  screenRight
	add	r2, r2, #2
	cmp	r1, r2
	ble	.L170
.L171:
	add	r1, r4, #8	@  dir
	mov	r0, sp
	mov	r2, #72
	ldr	r3, .L219+32
	mov	lr, pc
	bx	r3
	mov	r0, r4
	mov	r1, #1
	ldmia	r4, {r2, r3}
	ldr	ip, .L219+36
	mov	lr, pc
	bx	ip
.L161:
	mov	r0, #32
	bl	keyHeld
	cmp	r0, #0
	beq	.L173
	ldr	r3, [r7, #0]	@  isJumping
	cmp	r3, #0
	bne	.L206
	ldr	r3, .L219+4
	ldr	r2, .L219+20
	ldr	r1, [r3, #0]	@  walkingCounter
	smull	r3, r0, r2, r1
	mov	r3, r1, asr #31
	rsb	r3, r3, r0, asr #4
	add	r3, r3, r3, asl #2
	sub	r1, r1, r3, asl #3
	cmp	r1, #10
	beq	.L215
	cmp	r1, #20
	beq	.L211
	cmp	r1, #30
	beq	.L216
	cmp	r1, #0
	bne	.L206
.L211:
	ldr	r4, .L219+24
	ldr	r3, [r4, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #2
	add	r3, r6, r3, asl #4
	mov	r2, #32
.L209:
	str	r2, [r3, #44]	@  <variable>.location
.L174:
	ldr	r3, [r4, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #2
	mov	r3, r3, asl #4
	ldr	r2, [r3, r6]	@  <variable>.x
	add	r4, r3, r6
	cmp	r2, #120
	mov	r2, #1
	str	r2, [r4, #36]	@  <variable>.hFlip
	bgt	.L183
	ldr	r3, .L219+40
	ldr	r2, [r3, #0]	@  screenLeft
	cmp	r2, #0
	bne	.L182
.L183:
	add	r1, r4, #8	@  dir
	mov	r0, sp
	mov	r2, #72
	ldr	r3, .L219+32
	mov	lr, pc
	bx	r3
	mov	r0, r4
	mov	r1, #0
	ldmia	r4, {r2, r3}
	ldr	ip, .L219+36
	mov	lr, pc
	bx	ip
.L173:
	mov	r0, #1
	bl	keyHit
	cmp	r0, #0
	bne	.L217
.L185:
	mov	r4, r6
	mov	r5, #127	@  i
.L191:
	ldr	r3, [r4, #52]	@  <variable>.isProjectile
	cmp	r3, #0
	beq	.L188
	ldr	r3, [r4, #60]	@  <variable>.isRemoved
	cmp	r3, #0
	add	r1, r4, #8	@  dir
	mov	r2, #72
	mov	r0, sp
	beq	.L218
.L188:
	subs	r5, r5, #1	@  i,  i
	add	r4, r4, #80
	bpl	.L191
	mov	r0, #32
	bl	keyHeld
	cmp	r0, #0
	bne	.L192
	mov	r0, #16
	bl	keyHeld
	cmp	r0, #0
	bne	.L192
	ldr	r1, [r7, #0]	@  isJumping
	cmp	r1, #0
	ldreq	r2, .L219+24
	ldreq	r3, [r2, #0]	@  characterSpriteIndex
	addeq	r3, r3, r3, asl #2
	addeq	r3, r6, r3, asl #4
	streq	r1, [r3, #44]	@  <variable>.location
.L192:
	bl	WaitVBlank
	ldr	r0, .L219+16
	mov	r1, #128
	bl	UpdateSpriteMemory
	ldr	r3, .L219+44
	ldr	r2, .L219+48
	ldrh	r0, [r3, #0]	@  regY
	ldrh	r1, [r2, #0]	@  regX
	mov	r3, #67108864
	strh	r0, [r3, #18]	@ movhi 
	strh	r1, [r3, #16]	@ movhi 
	mov	r3, #39936	@  n
	add	r3, r3, #64	@  n,  n
.L197:
	subs	r3, r3, #1	@  n,  n
	bne	.L197
	ldmea	fp, {r4, r5, r6, r7, fp, sp, lr}
	bx	lr
.L218:
	ldr	r3, .L219+32
	mov	lr, pc
	bx	r3
	mov	r0, r4
	mov	r1, #1
	ldmia	r4, {r2, r3}
	ldr	ip, .L219+36
	mov	lr, pc
	bx	ip
	b	.L188
.L217:
	ldr	r2, .L219+24
	ldr	r3, [r2, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #2
	mov	r3, r3, asl #4
	add	r2, r3, r6
	ldr	r0, [r3, r6]	@  <variable>.x
	ldr	r1, [r2, #4]	@  dir,  <variable>.y
	ldr	r3, .L219+52
	mov	lr, pc
	bx	r3
	b	.L185
.L182:
	ldr	r3, .L219+56
	mov	lr, pc
	bx	r3
	b	.L173
.L206:
	ldr	r4, .L219+24
	b	.L174
.L216:
	ldr	r4, .L219+24
	ldr	r3, [r4, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #2
	add	r3, r6, r3, asl #4
	mov	r2, #96
	b	.L209
.L215:
	ldr	r4, .L219+24
	ldr	r3, [r4, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #2
	add	r3, r6, r3, asl #4
	mov	r2, #64
	b	.L209
.L170:
	ldr	r3, .L219+60
	mov	lr, pc
	bx	r3
	b	.L161
.L204:
	ldr	r4, .L219+24
	b	.L162
.L214:
	ldr	r4, .L219+24
	ldr	r3, [r4, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #2
	add	r3, r6, r3, asl #4
	mov	r2, #96
	b	.L208
.L213:
	ldr	r4, .L219+24
	ldr	r3, [r4, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #2
	add	r3, r6, r3, asl #4
	mov	r2, #64
	b	.L208
.L212:
	ldr	r4, .L219+24
	ldr	r4, [r4, #0]	@  characterSpriteIndex
	ldr	r6, .L219+16
	add	r4, r4, r4, asl #2
	add	r4, r6, r4, asl #4
	add	r1, r4, #8	@  dir
	mov	r2, #72
	ldr	r3, .L219+32
	mov	r0, sp
	mov	lr, pc
	bx	r3
	ldmia	r4, {r2, r3}
	mov	r0, r4
	mov	r1, #2
	ldr	ip, .L219+36
	mov	lr, pc
	bx	ip
	ldr	r3, [r5, #0]	@  jumpDuration
	add	r3, r3, #1
	str	r3, [r5, #0]	@  jumpDuration
	b	.L160
.L220:
	.align	2
.L219:
	.word	isJumping
	.word	walkingCounter
	.word	jumpDuration
	.word	Gravity
	.word	sprites
	.word	1717986919
	.word	characterSpriteIndex
	.word	screenRight
	.word	memcpy
	.word	Move
	.word	screenLeft
	.word	regY
	.word	regX
	.word	Shoot
	.word	MoveMapLeft
	.word	MoveMapRight
	.size	Update, .-Update
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	bl	Initialize
.L225:
	bl	Update
	b	.L225
	.size	main, .-main
	.align	2
	.global	Gravity
	.type	Gravity, %function
Gravity:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	ldr	r7, .L238
	ldr	r3, [r7, #0]	@  numberOfSprites
	mov	r6, #0	@  i
	cmp	r6, r3	@  i
	sub	fp, ip, #4
	bge	.L228
	ldr	r4, .L238+4
	mov	r8, r4
.L234:
	ldr	r5, [r4, #48]	@  <variable>.noGravity
	cmp	r5, #0
	add	r6, r6, #1	@  i,  i
	beq	.L236
.L229:
	ldr	r3, [r7, #0]	@  numberOfSprites
	cmp	r6, r3	@  i
	add	r4, r4, #80
	blt	.L234
.L228:
	ldmea	fp, {r4, r5, r6, r7, r8, fp, sp, lr}
	bx	lr
.L236:
	ldr	r3, [r4, #72]	@  <variable>.boundingBox.xsize
	ldr	r1, [r4, #12]	@  <variable>.mapY
	ldr	r2, [r4, #76]	@  <variable>.boundingBox.ysize
	ldr	r0, [r4, #8]	@  <variable>.mapX
	add	r3, r3, r3, lsr #31
	add	r0, r0, r3, asr #1	@  curX
	add	r1, r1, r2	@  curBottom
	ldr	r3, .L238+8
	mov	lr, pc
	bx	r3
	cmp	r0, #2	@  curX
	beq	.L237
	ldr	r3, [r4, #4]	@  <variable>.y
	ldr	r2, [r4, #12]	@  <variable>.mapY
	add	r3, r3, #1
	add	r2, r2, #1
	str	r3, [r4, #4]	@  <variable>.y
	str	r2, [r4, #12]	@  <variable>.mapY
	b	.L229
.L237:
	ldr	r1, .L238+12
	ldr	r3, [r1, #0]	@  isJumping
	cmp	r3, #0
	beq	.L228
	ldr	r2, .L238+16
	ldr	r3, [r2, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #2
	add	r3, r8, r3, asl #4
	str	r5, [r1, #0]	@  isJumping
	str	r5, [r3, #44]	@  <variable>.location
	b	.L228
.L239:
	.align	2
.L238:
	.word	numberOfSprites
	.word	sprites
	.word	GetNextTile
	.word	isJumping
	.word	characterSpriteIndex
	.size	Gravity, .-Gravity
	.align	2
	.global	GetNextTile
	.type	GetNextTile, %function
GetNextTile:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, r1, asr #31	@  y
	add	r1, r1, r3, lsr #29	@  y
	mov	r3, r0, asr #31	@  x
	add	r0, r0, r3, lsr #29	@  x
	mov	r1, r1, asr #3
	ldr	r3, .L241
	mov	r1, r1, asl #5
	add	r1, r1, r0, asr #3
	ldr	r2, [r3, #0]	@  bg1map
	mov	r1, r1, asl #1
	ldrh	r0, [r1, r2]	@  x
	@ lr needed for prologue
	bx	lr
.L242:
	.align	2
.L241:
	.word	bg1map
	.size	GetNextTile, .-GetNextTile
	.align	2
	.global	Shoot
	.type	Shoot, %function
Shoot:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 20
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #20
	mov	r8, r0	@  startX
	str	r1, [fp, #-60]	@  startY
	ldr	r0, .L244
	mov	r1, #128
	bl	GetNextFreePosition
	mov	r7, #0
	mov	r3, #8
	str	r3, [fp, #-44]	@  laserBBox.ysize
	str	r3, [fp, #-48]	@  laserBBox.xsize
	str	r7, [fp, #-56]	@  laserBBox.x
	str	r7, [fp, #-52]	@  laserBBox.y
	add	r4, r0, r0, asl #2	@  location,  location
	ldr	r3, .L244
	ldr	r9, .L244+4
	mov	r4, r4, asl #4
	sub	ip, fp, #56
	add	lr, r4, r3
	ldmia	ip, {r0, r1, r2, r3}
	ldr	ip, .L244
	ldr	r6, [r9, #0]	@  numberOfSprites
	str	r8, [r4, ip]	@  startX,  <variable>.x
	ldr	ip, [fp, #-60]	@  startY
	add	r6, r6, #1
	str	r6, [r9, #0]	@  numberOfSprites
	add	r5, lr, #64
	str	ip, [lr, #4]	@  <variable>.y
	mov	ip, #128
	mov	sl, #1
	str	ip, [lr, #44]	@  <variable>.location
	str	r7, [lr, #16]	@  <variable>.size
	str	r7, [lr, #20]	@  <variable>.shape
	stmia	r5, {r0, r1, r2, r3}
	mov	r3, #2
	str	r7, [lr, #60]	@  <variable>.isRemoved
	str	sl, [lr, #52]	@  <variable>.isProjectile
	str	r3, [lr, #56]	@  <variable>.speed
	str	sl, [lr, #48]	@  <variable>.noGravity
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
.L245:
	.align	2
.L244:
	.word	sprites
	.word	numberOfSprites
	.size	Shoot, .-Shoot
	.align	2
	.global	Move
	.type	Move, %function
Move:
	@ Function supports interworking.
	@ args = 80, pretend = 8, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	sub	sp, sp, #8
	stmfd	sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub	fp, ip, #12
	add	r5, fp, #4	@  direction
	cmp	r1, #1	@  direction
	stmia	r5, {r2, r3}	@  direction
	mov	r7, r0	@  x
	beq	.L252
	bcc	.L248
	cmp	r1, #2	@  direction
	beq	.L256
.L247:
	mov	r1, r5	@  direction
	mov	r0, r7	@  x
	mov	r2, #80
	ldr	r3, .L262
	mov	lr, pc
	bx	r3
	mov	r0, r7	@  x
	ldmea	fp, {r4, r5, r6, r7, fp, sp, lr}
	bx	lr
.L256:
	ldr	r1, [fp, #16]	@  y,  sprite.mapY
	cmp	r1, #0	@  y
	ldr	r4, [fp, #12]	@  x,  sprite.mapX
	ble	.L247
	sub	r6, r1, #1	@  direction,  y
	mov	r0, r4	@  x
	mov	r1, r6	@  direction
	bl	GetNextTile
	cmp	r0, #2	@  x
	ldrne	r3, [fp, #8]	@  sprite.y
	subne	r3, r3, #1
	strne	r3, [fp, #8]	@  sprite.y
	strne	r6, [fp, #16]	@  direction,  sprite.mapY
	b	.L247
.L248:
	ldr	r4, [fp, #12]	@  x,  sprite.mapX
	ldr	r3, [fp, #80]	@  sprite.boundingBox.ysize
	ldr	r2, [fp, #16]	@  sprite.mapY
	add	r3, r3, r3, lsr #31
	cmp	r4, #0	@  x
	add	r1, r2, r3, asr #1	@  y
	ble	.L253
	sub	r0, r4, #1	@  x,  x
	bl	GetNextTile
	cmp	r0, #2	@  x
	beq	.L253
	ldr	r0, .L262+4
	ldr	r1, [fp, #60]	@  sprite.speed
	ldr	r3, [fp, #4]	@  sprite.x
	ldr	r2, [r0, #0]	@  walkingCounter
	rsb	ip, r1, r4	@  x
	rsb	r3, r1, r3
.L261:
	add	r2, r2, #1
	str	r2, [r0, #0]	@  walkingCounter
	str	r3, [fp, #4]	@  sprite.x
	str	ip, [fp, #12]	@  sprite.mapX
	b	.L247
.L253:
	ldr	r3, [fp, #56]	@  sprite.isProjectile
	cmp	r3, #0
	beq	.L247
	mov	r3, #240
	str	r3, [fp, #4]	@  sprite.x
	mov	r2, #160
	mov	r3, #1
	str	r2, [fp, #8]	@  sprite.y
	str	r3, [fp, #64]	@  sprite.isRemoved
	b	.L247
.L252:
	ldr	r2, [fp, #76]	@  sprite.boundingBox.xsize
	ldr	r6, [fp, #12]	@  sprite.mapX
	ldr	r3, [fp, #80]	@  sprite.boundingBox.ysize
	add	r4, r6, r2	@  x
	ldr	r2, [fp, #16]	@  sprite.mapY
	add	r3, r3, r3, lsr #31
	cmp	r4, #512	@  x
	add	r1, r2, r3, asr #1	@  y
	bge	.L253
	add	r0, r4, #1	@  x,  x
	bl	GetNextTile
	cmp	r0, #2	@  x
	beq	.L253
	ldr	r0, .L262+4
	ldr	r1, [fp, #60]	@  sprite.speed
	ldr	r3, [fp, #4]	@  sprite.x
	ldr	r2, [r0, #0]	@  walkingCounter
	add	ip, r6, r1
	add	r3, r3, r1
	b	.L261
.L263:
	.align	2
.L262:
	.word	memcpy
	.word	walkingCounter
	.size	Move, .-Move
	.align	2
	.global	MoveMapLeft
	.type	MoveMapLeft, %function
MoveMapLeft:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #12
	ldr	sl, .L269
	ldr	r1, [sl, #0]	@  screenLeft
	sub	r4, r1, #1
	mov	r2, r1, asr #31
	mov	r3, r4, asr #31
	add	r2, r1, r2, lsr #29
	add	r3, r4, r3, lsr #29
	cmp	r1, #0
	ldr	r9, .L269+4
	mov	r5, r3, asr #3
	mov	r7, r2, asr #3
	ble	.L264
	ldr	r2, .L269+8
	ldr	r3, [r2, #0]	@  characterSpriteIndex
	ldr	r2, .L269+12
	add	r3, r3, r3, asl #2
	add	lr, r2, r3, asl #4
	ldr	r2, .L269+16
	ldr	r3, [r9, #0]	@  regX
	ldr	ip, [r2, #0]	@  mapLeft
	ldr	r6, .L269+20
	ldr	r8, .L269+24
	cmp	ip, #0
	ldr	r2, [r6, #0]	@  screenRight
	sub	r3, r3, #1
	str	r3, [r9, #0]	@  regX
	ldrgt	r3, [r8, #0]	@  mapRight
	sub	r6, r2, #1
	ldrgt	r2, .L269+16
	subgt	r3, r3, #1
	sub	ip, ip, #1
	strgt	ip, [r2, #0]	@  mapLeft
	strgt	r3, [r8, #0]	@  mapRight
	ldr	r2, [lr, #8]	@  <variable>.mapX
	ldr	r3, [lr, #56]	@  <variable>.speed
	rsb	r2, r3, r2
	ldr	r3, .L269+20
	str	r6, [r3, #0]	@  screenRight
	ldr	r3, .L269+28
	ldr	r6, .L269+32
	cmp	r5, r7
	str	r7, [r3, #0]	@  prevColumn
	str	r4, [sl, #0]	@  screenLeft
	str	r5, [r6, #0]	@  nextColumn
	mov	r0, r4
	mov	r1, r5
	str	r2, [lr, #8]	@  <variable>.mapX
	blt	.L268
.L264:
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
.L268:
	ldr	ip, .L269+36
	ldr	lr, .L269+40
	ldr	r2, [ip, #0]	@  mapTop
	ldr	r3, [lr, #0]	@  mapBottom
	ldr	ip, .L269+44
	ldr	lr, .L269+48
	ldr	r4, [ip, #0]	@  map
	ldr	ip, [lr, #0]	@  bg0map
	mov	r6, #64
	str	r6, [sp, #8]
	stmia	sp, {r4, ip}	@ phole stm
	ldr	ip, .L269+52
	mov	lr, pc
	bx	ip
	ldr	lr, .L269+32
	ldr	ip, .L269+56
	ldr	r1, [lr, #0]	@  nextColumn
	ldr	lr, .L269+60
	ldr	r4, [ip, #0]	@  hitMap
	ldr	r3, .L269+36
	ldr	ip, [lr, #0]	@  bg1map
	ldr	r6, .L269+40
	ldr	r2, [r3, #0]	@  mapTop
	ldr	r3, [r6, #0]	@  mapBottom
	str	ip, [sp, #4]
	mov	ip, #64
	ldr	r0, [sl, #0]	@  screenLeft
	str	r4, [sp, #0]
	str	ip, [sp, #8]
	ldr	r6, .L269+52
	mov	lr, pc
	bx	r6
	b	.L264
.L270:
	.align	2
.L269:
	.word	screenLeft
	.word	regX
	.word	characterSpriteIndex
	.word	sprites
	.word	mapLeft
	.word	screenRight
	.word	mapRight
	.word	prevColumn
	.word	nextColumn
	.word	mapTop
	.word	mapBottom
	.word	map
	.word	bg0map
	.word	CopyColumnToBackground
	.word	hitMap
	.word	bg1map
	.size	MoveMapLeft, .-MoveMapLeft
	.align	2
	.global	MoveMapRight
	.type	MoveMapRight, %function
MoveMapRight:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #12
	ldr	r8, .L276
	ldr	r1, [r8, #0]	@  screenRight
	mov	lr, #508
	add	r5, r1, #1
	mov	r2, r1, asr #31
	mov	r3, r5, asr #31
	add	lr, lr, #2
	add	r2, r1, r2, lsr #29
	add	r3, r5, r3, lsr #29
	cmp	r1, lr
	mov	r6, r3, asr #3
	mov	sl, r2, asr #3
	bgt	.L271
	ldr	r3, .L276+4
	ldr	r2, [r3, #0]	@  characterSpriteIndex
	ldr	r7, .L276+8
	ldr	r3, .L276+12
	add	r2, r2, r2, asl #2
	add	r4, r3, r2, asl #4
	ldr	r3, [r7, #0]	@  regX
	ldr	r2, .L276+16
	ldr	r7, .L276+20
	ldr	ip, [r2, #0]	@  mapRight
	ldr	r2, [r7, #0]	@  screenLeft
	cmp	ip, lr
	add	r7, r2, #1
	ldr	r9, .L276+24
	add	r2, ip, #1
	ldr	ip, .L276+8
	add	r3, r3, #1
	str	r3, [ip, #0]	@  regX
	ldrle	r3, [r9, #0]	@  mapLeft
	ldrle	lr, .L276+16
	addle	r3, r3, #1
	strle	r2, [lr, #0]	@  mapRight
	strle	r3, [r9, #0]	@  mapLeft
	ldr	r2, [r4, #8]	@  <variable>.mapX
	ldr	r3, [r4, #56]	@  <variable>.speed
	add	r2, r2, r3
	ldr	r3, .L276+20
	str	r7, [r3, #0]	@  screenLeft
	ldr	r3, .L276+28
	ldr	r7, .L276+32
	cmp	r6, sl
	str	sl, [r3, #0]	@  prevColumn
	str	r5, [r8, #0]	@  screenRight
	str	r6, [r7, #0]	@  nextColumn
	mov	r0, r5
	mov	r1, r6
	str	r2, [r4, #8]	@  <variable>.mapX
	bgt	.L275
.L271:
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
.L275:
	ldr	ip, .L276+36
	ldr	lr, .L276+40
	ldr	r2, [ip, #0]	@  mapTop
	ldr	r3, [lr, #0]	@  mapBottom
	ldr	ip, .L276+44
	ldr	lr, .L276+48
	ldr	r4, [ip, #0]	@  map
	ldr	ip, [lr, #0]	@  bg0map
	mov	r7, #64
	str	r7, [sp, #8]
	stmia	sp, {r4, ip}	@ phole stm
	ldr	ip, .L276+52
	mov	lr, pc
	bx	ip
	ldr	lr, .L276+32
	ldr	ip, .L276+56
	ldr	r1, [lr, #0]	@  nextColumn
	ldr	lr, .L276+60
	ldr	r4, [ip, #0]	@  hitMap
	ldr	r3, .L276+36
	ldr	ip, [lr, #0]	@  bg1map
	ldr	r7, .L276+40
	ldr	r2, [r3, #0]	@  mapTop
	ldr	r3, [r7, #0]	@  mapBottom
	str	ip, [sp, #4]
	mov	ip, #64
	ldr	r0, [r8, #0]	@  screenRight
	str	r4, [sp, #0]
	str	ip, [sp, #8]
	ldr	r7, .L276+52
	mov	lr, pc
	bx	r7
	b	.L271
.L277:
	.align	2
.L276:
	.word	screenRight
	.word	characterSpriteIndex
	.word	regX
	.word	sprites
	.word	mapRight
	.word	screenLeft
	.word	mapLeft
	.word	prevColumn
	.word	nextColumn
	.word	mapTop
	.word	mapBottom
	.word	map
	.word	bg0map
	.word	CopyColumnToBackground
	.word	hitMap
	.word	bg1map
	.size	MoveMapRight, .-MoveMapRight
	.align	2
	.global	MoveMap
	.type	MoveMap, %function
MoveMap:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #12
	mov	r5, #0	@  moveRight
	mov	r6, r5	@  moveDown,  moveRight
	mov	r7, r5	@  moveLeft,  moveRight
	mov	r8, r5	@  moveUp,  moveDown
	cmp	r0, #3	@  direction
	ldrls	pc, [pc, r0, asl #2]	@  direction
	b	.L278
	.p2align 2
.L296:
	.word	.L280
	.word	.L304
	.word	.L288
	.word	.L305
.L280:
	ldr	r4, .L311
	ldr	r0, [r4, #0]	@  screenLeft
	cmp	r0, #0
	ble	.L304
	ldr	r2, .L311+4
	ldr	ip, .L311+8
	ldr	r3, [r2, #0]	@  regX
	ldr	r1, [ip, #0]	@  mapLeft
	sub	r3, r3, #1
	cmp	r1, #0
	str	r3, [r2, #0]	@  regX
	ble	.L282
	ldr	r3, .L311+12
	ldr	r2, [r3, #0]	@  mapRight
	sub	r1, r1, #1
	sub	r2, r2, #1
	str	r1, [ip, #0]	@  mapLeft
	str	r2, [r3, #0]	@  mapRight
.L282:
	sub	ip, r0, #1
	ldr	lr, .L311+16
	mov	r2, r0, asr #31
	mov	r1, ip, asr #31
	add	r2, r0, r2, lsr #29
	ldr	r3, .L311+20
	add	r1, ip, r1, lsr #29
	ldr	r0, [lr, #0]	@  screenRight
	mov	r2, r2, asr #3
	mov	r1, r1, asr #3
	cmp	r1, r2
	str	r2, [r3, #0]	@  prevColumn
	ldr	r3, .L311+24
	sub	r0, r0, #1
	movlt	r7, #1	@  moveLeft
	str	ip, [r4, #0]	@  screenLeft
	str	r0, [lr, #0]	@  screenRight
	str	r1, [r3, #0]	@  nextColumn
.L284:
	ldr	r4, [lr, #0]	@  screenRight
	mov	r0, #508
	add	r0, r0, #2
	cmp	r4, r0
	bgt	.L288
	ldr	r2, .L311+4
	ldr	ip, .L311+12
	ldr	r3, [r2, #0]	@  regX
	ldr	r1, [ip, #0]	@  mapRight
	add	r3, r3, #1
	cmp	r1, r0
	str	r3, [r2, #0]	@  regX
	bgt	.L286
	ldr	r3, .L311+8
	ldr	r2, [r3, #0]	@  mapLeft
	add	r1, r1, #1
	add	r2, r2, #1
	str	r1, [ip, #0]	@  mapRight
	str	r2, [r3, #0]	@  mapLeft
.L286:
	ldr	lr, .L311
	mov	r0, r4, asr #31
	ldr	r3, [lr, #0]	@  screenLeft
	add	ip, r4, #1
	ldr	r2, .L311+20
	add	r0, r4, r0, lsr #29
	mov	r0, r0, asr #3
	add	r3, r3, #1
	mov	r1, ip, asr #31
	add	r1, ip, r1, lsr #29
	str	r3, [lr, #0]	@  screenLeft
	str	r0, [r2, #0]	@  prevColumn
	ldr	r3, .L311+16
	ldr	r2, .L311+24
	mov	r1, r1, asr #3
	cmp	r1, r0
	str	ip, [r3, #0]	@  screenRight
	str	r1, [r2, #0]	@  nextColumn
	movgt	r5, #1	@  moveRight
.L288:
	ldr	r4, .L311+28
	ldr	r0, [r4, #0]	@  screenTop
	cmp	r0, #0
	ble	.L305
	ldr	r2, .L311+32
	ldr	ip, .L311+36
	ldr	r3, [r2, #0]	@  regY
	ldr	r1, [ip, #0]	@  mapTop
	sub	r3, r3, #1
	cmp	r1, #0
	str	r3, [r2, #0]	@  regY
	ble	.L290
	ldr	r3, .L311+40
	ldr	r2, [r3, #0]	@  mapBottom
	sub	r1, r1, #1
	sub	r2, r2, #1
	str	r1, [ip, #0]	@  mapTop
	str	r2, [r3, #0]	@  mapBottom
.L290:
	sub	ip, r0, #1
	ldr	lr, .L311+44
	mov	r2, r0, asr #31
	mov	r1, ip, asr #31
	add	r2, r0, r2, lsr #29
	ldr	r3, .L311+48
	add	r1, ip, r1, lsr #29
	ldr	r0, [lr, #0]	@  screenBottom
	mov	r2, r2, asr #3
	mov	r1, r1, asr #3
	cmp	r1, r2
	str	r2, [r3, #0]	@  prevRow
	ldr	r3, .L311+52
	sub	r0, r0, #1
	movlt	r8, #1	@  moveUp
	str	ip, [r4, #0]	@  screenTop
	str	r0, [lr, #0]	@  screenBottom
	str	r1, [r3, #0]	@  nextRow
.L292:
	ldr	r4, [lr, #0]	@  screenBottom
	mov	r0, #508
	add	r0, r0, #2
	cmp	r4, r0
	bgt	.L279
	ldr	r2, .L311+32
	ldr	ip, .L311+40
	ldr	r3, [r2, #0]	@  regY
	ldr	r1, [ip, #0]	@  mapBottom
	add	r3, r3, #1
	cmp	r1, r0
	str	r3, [r2, #0]	@  regY
	bgt	.L294
	ldr	r3, .L311+36
	ldr	r2, [r3, #0]	@  mapTop
	add	r1, r1, #1
	add	r2, r2, #1
	str	r2, [r3, #0]	@  mapTop
	str	r1, [ip, #0]	@  mapBottom
.L294:
	ldr	lr, .L311+28
	mov	r0, r4, asr #31
	ldr	r3, [lr, #0]	@  screenTop
	add	ip, r4, #1
	ldr	r2, .L311+48
	add	r0, r4, r0, lsr #29
	mov	r0, r0, asr #3
	add	r3, r3, #1
	mov	r1, ip, asr #31
	add	r1, ip, r1, lsr #29
	str	r3, [lr, #0]	@  screenTop
	str	r0, [r2, #0]	@  prevRow
	ldr	r3, .L311+44
	ldr	r2, .L311+52
	mov	r1, r1, asr #3
	cmp	r1, r0
	str	ip, [r3, #0]	@  screenBottom
	str	r1, [r2, #0]	@  nextRow
	movgt	r6, #1	@  moveDown
.L279:
	cmp	r7, #0	@  moveLeft
	bne	.L307
.L298:
	cmp	r5, #0	@  moveRight
	bne	.L308
.L299:
	cmp	r8, #0	@  moveUp
	bne	.L309
.L300:
	cmp	r6, #0	@  moveDown
	bne	.L310
.L278:
	ldmea	fp, {r4, r5, r6, r7, r8, fp, sp, lr}
	bx	lr
.L310:
	ldr	r3, .L311+44
	ldr	r2, .L311+52
	ldr	r0, [r3, #0]	@  direction,  screenBottom
	ldr	ip, .L311+12
	ldr	r3, .L311+8
	ldr	r1, [r2, #0]	@  nextRow
	ldr	lr, .L311+56
	ldr	r2, [r3, #0]	@  mapLeft
	ldr	r3, [ip, #0]	@  mapRight
	ldr	ip, .L311+60
	ldr	r4, [lr, #0]	@  map
	ldr	lr, [ip, #0]	@  bg0map
	mov	ip, #64
	stmia	sp, {r4, lr}	@ phole stm
	str	ip, [sp, #8]
	ldr	r4, .L311+64
	mov	lr, pc
	bx	r4
	b	.L278
.L309:
	ldr	r3, .L311+28
	ldr	r2, .L311+52
	ldr	r0, [r3, #0]	@  direction,  screenTop
	ldr	ip, .L311+12
	ldr	r3, .L311+8
	ldr	r1, [r2, #0]	@  nextRow
	ldr	lr, .L311+56
	ldr	r2, [r3, #0]	@  mapLeft
	ldr	r3, [ip, #0]	@  mapRight
	ldr	ip, .L311+60
	ldr	r4, [lr, #0]	@  map
	ldr	lr, [ip, #0]	@  bg0map
	mov	ip, #64
	stmia	sp, {r4, lr}	@ phole stm
	str	ip, [sp, #8]
	ldr	r4, .L311+64
	mov	lr, pc
	bx	r4
	b	.L300
.L308:
	ldr	r3, .L311+16
	ldr	r2, .L311+24
	ldr	r0, [r3, #0]	@  direction,  screenRight
	ldr	ip, .L311+40
	ldr	r3, .L311+36
	ldr	r1, [r2, #0]	@  nextColumn
	ldr	lr, .L311+56
	ldr	r2, [r3, #0]	@  mapTop
	ldr	r3, [ip, #0]	@  mapBottom
	ldr	ip, .L311+60
	ldr	r4, [lr, #0]	@  map
	ldr	lr, [ip, #0]	@  bg0map
	mov	ip, #64
	stmia	sp, {r4, lr}	@ phole stm
	str	ip, [sp, #8]
	ldr	r4, .L311+68
	mov	lr, pc
	bx	r4
	b	.L299
.L307:
	ldr	r3, .L311
	ldr	r2, .L311+24
	ldr	r0, [r3, #0]	@  direction,  screenLeft
	ldr	ip, .L311+40
	ldr	r3, .L311+36
	ldr	r1, [r2, #0]	@  nextColumn
	ldr	lr, .L311+56
	ldr	r2, [r3, #0]	@  mapTop
	ldr	r3, [ip, #0]	@  mapBottom
	ldr	ip, .L311+60
	ldr	r4, [lr, #0]	@  map
	ldr	lr, [ip, #0]	@  bg0map
	mov	ip, #64
	stmia	sp, {r4, lr}	@ phole stm
	str	ip, [sp, #8]
	ldr	r4, .L311+68
	mov	lr, pc
	bx	r4
	b	.L298
.L305:
	ldr	lr, .L311+44
	b	.L292
.L304:
	ldr	lr, .L311+16
	b	.L284
.L312:
	.align	2
.L311:
	.word	screenLeft
	.word	regX
	.word	mapLeft
	.word	mapRight
	.word	screenRight
	.word	prevColumn
	.word	nextColumn
	.word	screenTop
	.word	regY
	.word	mapTop
	.word	mapBottom
	.word	screenBottom
	.word	prevRow
	.word	nextRow
	.word	map
	.word	bg0map
	.word	CopyRowToBackground
	.word	CopyColumnToBackground
	.size	MoveMap, .-MoveMap
	.align	2
	.global	CopyColumnToBackground
	.type	CopyColumnToBackground, %function
CopyColumnToBackground:
	@ Function supports interworking.
	@ args = 12, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, lr}
	mov	ip, r3, asr #31	@  bottomRow
	mov	lr, r3	@  bottomRow
	mov	r3, r2, asr #31	@  topRow
	mov	r4, r1	@  copyToColumn
	add	r2, r2, r3, lsr #29	@  topRow
	add	ip, lr, ip, lsr #29	@  bottomRow
	mov	r1, r1, asr #31	@  copyToColumn
	add	r1, r4, r1, lsr #27	@  copyToColumn
	mov	lr, ip, asr #3	@  bottomRow
	mov	r3, r0, asr #31	@  column
	mov	ip, r2, asr #3	@  row
	bic	r1, r1, #31
	add	r3, r0, r3, lsr #29	@  column
	cmp	ip, lr	@  row,  bottomRow
	rsb	r4, r1, r4	@  copyToColumn,  copyToColumn
	mov	r0, r3, asr #3	@  column
	ldr	r5, [sp, #16]	@  dest,  dest
	ldr	r1, [sp, #20]	@  sourceColumns,  sourceColumns
	bge	.L320
	mla	r2, r1, ip, r0	@  sourceColumns,  row,  column
	ldr	r3, [sp, #12]	@  source,  source
	mov	r1, r1, asl #1	@  sourceColumns
	add	r0, r3, r2, asl #1	@  source
.L318:
	mov	r3, ip, asr #31	@  row
	add	r3, ip, r3, lsr #27	@  row
	bic	r3, r3, #31
	rsb	r3, r3, ip	@  row
	ldrh	r2, [r0, #0]
	add	r3, r4, r3, asl #5	@  copyToColumn
	add	ip, ip, #1	@  row,  row
	mov	r3, r3, asl #1
	cmp	ip, lr	@  row,  bottomRow
	strh	r2, [r3, r5]	@ movhi 	@ * dest
	add	r0, r0, r1
	blt	.L318
.L320:
	ldmfd	sp!, {r4, r5, lr}
	bx	lr
	.size	CopyColumnToBackground, .-CopyColumnToBackground
	.align	2
	.global	CopyRowToBackground
	.type	CopyRowToBackground, %function
CopyRowToBackground:
	@ Function supports interworking.
	@ args = 12, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	mov	ip, r3, asr #31	@  rightColumn
	mov	lr, r3	@  rightColumn
	mov	r3, r2, asr #31	@  leftColumn
	mov	r4, r1	@  copyToRow
	add	r2, r2, r3, lsr #29	@  leftColumn
	add	ip, lr, ip, lsr #29	@  rightColumn
	mov	r1, r1, asr #31	@  copyToRow
	add	r1, r4, r1, lsr #27	@  copyToRow
	mov	lr, ip, asr #3	@  rightColumn
	mov	r3, r0, asr #31	@  row
	mov	ip, r2, asr #3	@  column
	add	r3, r0, r3, lsr #29	@  row
	bic	r1, r1, #31
	cmp	ip, lr	@  column,  rightColumn
	mov	r0, r3, asr #3	@  row
	rsb	r4, r1, r4	@  copyToRow,  copyToRow
	ldr	r6, [sp, #16]	@  source,  source
	ldr	r5, [sp, #20]	@  dest,  dest
	bge	.L328
	ldr	r3, [sp, #24]	@  sourceColumns,  sourceColumns
	mla	r2, r3, r0, ip	@  sourceColumns,  row,  column
	mov	r1, r4, asl #5	@  copyToRow
	mov	r0, r2, asl #1
.L326:
	mov	r3, ip, asr #31	@  column
	add	r3, ip, r3, lsr #27	@  column
	bic	r3, r3, #31
	rsb	r3, r3, ip	@  column
	ldrh	r2, [r0, r6]	@ movhi	@ * source
	add	r3, r1, r3
	add	ip, ip, #1	@  column,  column
	mov	r3, r3, asl #1
	cmp	ip, lr	@  column,  rightColumn
	strh	r2, [r3, r5]	@ movhi 	@ * dest
	add	r0, r0, #2
	blt	.L326
.L328:
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
	.size	CopyRowToBackground, .-CopyRowToBackground
	.comm	buttons, 40, 32
	.comm	curr_state, 2, 16
	.comm	prev_state, 2, 16
	.comm	bg0map, 4, 32
	.comm	bg1map, 4, 32
	.comm	sprites, 10240, 32
	.comm	numberOfSprites, 4, 32
	.comm	jumpDuration, 4, 32
	.comm	characterSpriteIndex, 4, 32
	.ident	"GCC: (GNU) 3.3.2"
