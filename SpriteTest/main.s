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
	.global	sin_lut
	.section	.rodata
	.align	1
	.type	sin_lut, %object
	.size	sin_lut, 1024
sin_lut:
	.short	0
	.short	50
	.short	100
	.short	150
	.short	200
	.short	251
	.short	301
	.short	351
	.short	401
	.short	451
	.short	501
	.short	551
	.short	601
	.short	650
	.short	700
	.short	749
	.short	799
	.short	848
	.short	897
	.short	946
	.short	995
	.short	1043
	.short	1092
	.short	1140
	.short	1189
	.short	1237
	.short	1284
	.short	1332
	.short	1379
	.short	1427
	.short	1474
	.short	1520
	.short	1567
	.short	1613
	.short	1659
	.short	1705
	.short	1751
	.short	1796
	.short	1841
	.short	1886
	.short	1930
	.short	1975
	.short	2018
	.short	2062
	.short	2105
	.short	2148
	.short	2191
	.short	2233
	.short	2275
	.short	2317
	.short	2358
	.short	2399
	.short	2439
	.short	2480
	.short	2519
	.short	2559
	.short	2598
	.short	2637
	.short	2675
	.short	2713
	.short	2750
	.short	2787
	.short	2824
	.short	2860
	.short	2896
	.short	2931
	.short	2966
	.short	3000
	.short	3034
	.short	3068
	.short	3101
	.short	3134
	.short	3166
	.short	3197
	.short	3229
	.short	3259
	.short	3289
	.short	3319
	.short	3348
	.short	3377
	.short	3405
	.short	3433
	.short	3460
	.short	3487
	.short	3513
	.short	3538
	.short	3563
	.short	3588
	.short	3612
	.short	3635
	.short	3658
	.short	3680
	.short	3702
	.short	3723
	.short	3744
	.short	3764
	.short	3784
	.short	3803
	.short	3821
	.short	3839
	.short	3856
	.short	3873
	.short	3889
	.short	3904
	.short	3919
	.short	3933
	.short	3947
	.short	3960
	.short	3973
	.short	3985
	.short	3996
	.short	4007
	.short	4017
	.short	4026
	.short	4035
	.short	4043
	.short	4051
	.short	4058
	.short	4065
	.short	4071
	.short	4076
	.short	4080
	.short	4084
	.short	4088
	.short	4091
	.short	4093
	.short	4094
	.short	4095
	.short	4095
	.short	4095
	.short	4094
	.short	4093
	.short	4091
	.short	4088
	.short	4084
	.short	4080
	.short	4076
	.short	4071
	.short	4065
	.short	4058
	.short	4051
	.short	4043
	.short	4035
	.short	4026
	.short	4017
	.short	4007
	.short	3996
	.short	3985
	.short	3973
	.short	3960
	.short	3947
	.short	3933
	.short	3919
	.short	3904
	.short	3889
	.short	3873
	.short	3856
	.short	3839
	.short	3821
	.short	3803
	.short	3784
	.short	3764
	.short	3744
	.short	3723
	.short	3702
	.short	3680
	.short	3658
	.short	3635
	.short	3612
	.short	3588
	.short	3563
	.short	3538
	.short	3513
	.short	3487
	.short	3460
	.short	3433
	.short	3405
	.short	3377
	.short	3348
	.short	3319
	.short	3289
	.short	3259
	.short	3229
	.short	3197
	.short	3166
	.short	3134
	.short	3101
	.short	3068
	.short	3034
	.short	3000
	.short	2966
	.short	2931
	.short	2896
	.short	2860
	.short	2824
	.short	2787
	.short	2750
	.short	2713
	.short	2675
	.short	2637
	.short	2598
	.short	2559
	.short	2519
	.short	2480
	.short	2439
	.short	2399
	.short	2358
	.short	2317
	.short	2275
	.short	2233
	.short	2191
	.short	2148
	.short	2105
	.short	2062
	.short	2018
	.short	1975
	.short	1930
	.short	1886
	.short	1841
	.short	1796
	.short	1751
	.short	1705
	.short	1659
	.short	1613
	.short	1567
	.short	1520
	.short	1474
	.short	1427
	.short	1379
	.short	1332
	.short	1284
	.short	1237
	.short	1189
	.short	1140
	.short	1092
	.short	1043
	.short	995
	.short	946
	.short	897
	.short	848
	.short	799
	.short	749
	.short	700
	.short	650
	.short	601
	.short	551
	.short	501
	.short	451
	.short	401
	.short	351
	.short	301
	.short	251
	.short	200
	.short	150
	.short	100
	.short	50
	.short	0
	.short	-50
	.short	-100
	.short	-150
	.short	-200
	.short	-251
	.short	-301
	.short	-351
	.short	-401
	.short	-451
	.short	-501
	.short	-551
	.short	-601
	.short	-650
	.short	-700
	.short	-749
	.short	-799
	.short	-848
	.short	-897
	.short	-946
	.short	-995
	.short	-1043
	.short	-1092
	.short	-1140
	.short	-1189
	.short	-1237
	.short	-1284
	.short	-1332
	.short	-1379
	.short	-1427
	.short	-1474
	.short	-1520
	.short	-1567
	.short	-1613
	.short	-1659
	.short	-1705
	.short	-1751
	.short	-1796
	.short	-1841
	.short	-1886
	.short	-1930
	.short	-1975
	.short	-2018
	.short	-2062
	.short	-2105
	.short	-2148
	.short	-2191
	.short	-2233
	.short	-2275
	.short	-2317
	.short	-2358
	.short	-2399
	.short	-2439
	.short	-2480
	.short	-2519
	.short	-2559
	.short	-2598
	.short	-2637
	.short	-2675
	.short	-2713
	.short	-2750
	.short	-2787
	.short	-2824
	.short	-2860
	.short	-2896
	.short	-2931
	.short	-2966
	.short	-3000
	.short	-3034
	.short	-3068
	.short	-3101
	.short	-3134
	.short	-3166
	.short	-3197
	.short	-3229
	.short	-3259
	.short	-3289
	.short	-3319
	.short	-3348
	.short	-3377
	.short	-3405
	.short	-3433
	.short	-3460
	.short	-3487
	.short	-3513
	.short	-3538
	.short	-3563
	.short	-3588
	.short	-3612
	.short	-3635
	.short	-3658
	.short	-3680
	.short	-3702
	.short	-3723
	.short	-3744
	.short	-3764
	.short	-3784
	.short	-3803
	.short	-3821
	.short	-3839
	.short	-3856
	.short	-3873
	.short	-3889
	.short	-3904
	.short	-3919
	.short	-3933
	.short	-3947
	.short	-3960
	.short	-3973
	.short	-3985
	.short	-3996
	.short	-4007
	.short	-4017
	.short	-4026
	.short	-4035
	.short	-4043
	.short	-4051
	.short	-4058
	.short	-4065
	.short	-4071
	.short	-4076
	.short	-4080
	.short	-4084
	.short	-4088
	.short	-4091
	.short	-4093
	.short	-4094
	.short	-4095
	.short	-4095
	.short	-4095
	.short	-4094
	.short	-4093
	.short	-4091
	.short	-4088
	.short	-4084
	.short	-4080
	.short	-4076
	.short	-4071
	.short	-4065
	.short	-4058
	.short	-4051
	.short	-4043
	.short	-4035
	.short	-4026
	.short	-4017
	.short	-4007
	.short	-3996
	.short	-3985
	.short	-3973
	.short	-3960
	.short	-3947
	.short	-3933
	.short	-3919
	.short	-3904
	.short	-3889
	.short	-3873
	.short	-3856
	.short	-3839
	.short	-3821
	.short	-3803
	.short	-3784
	.short	-3764
	.short	-3744
	.short	-3723
	.short	-3702
	.short	-3680
	.short	-3658
	.short	-3635
	.short	-3612
	.short	-3588
	.short	-3563
	.short	-3538
	.short	-3513
	.short	-3487
	.short	-3460
	.short	-3433
	.short	-3405
	.short	-3377
	.short	-3348
	.short	-3319
	.short	-3289
	.short	-3259
	.short	-3229
	.short	-3197
	.short	-3166
	.short	-3134
	.short	-3101
	.short	-3068
	.short	-3034
	.short	-3000
	.short	-2966
	.short	-2931
	.short	-2896
	.short	-2860
	.short	-2824
	.short	-2787
	.short	-2750
	.short	-2713
	.short	-2675
	.short	-2637
	.short	-2598
	.short	-2559
	.short	-2519
	.short	-2480
	.short	-2439
	.short	-2399
	.short	-2358
	.short	-2317
	.short	-2275
	.short	-2233
	.short	-2191
	.short	-2148
	.short	-2105
	.short	-2062
	.short	-2018
	.short	-1975
	.short	-1930
	.short	-1886
	.short	-1841
	.short	-1796
	.short	-1751
	.short	-1705
	.short	-1659
	.short	-1613
	.short	-1567
	.short	-1520
	.short	-1474
	.short	-1427
	.short	-1379
	.short	-1332
	.short	-1284
	.short	-1237
	.short	-1189
	.short	-1140
	.short	-1092
	.short	-1043
	.short	-995
	.short	-946
	.short	-897
	.short	-848
	.short	-799
	.short	-749
	.short	-700
	.short	-650
	.short	-601
	.short	-551
	.short	-501
	.short	-451
	.short	-401
	.short	-351
	.short	-301
	.short	-251
	.short	-200
	.short	-150
	.short	-100
	.short	-50
	.text
	.align	2
	.global	UpdateSpriteMemory
	.type	UpdateSpriteMemory, %function
UpdateSpriteMemory:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 4
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #4
	mov	r6, #0	@  i
	cmp	r6, r1	@  i,  count
	str	sp, [fp, #-44]
	sub	sp, sp, r1, asl #3	@  count
	mov	r8, r1	@  count
	mov	sl, r0	@  sprites
	mov	r5, #0
	mov	r4, #0	@  sprite
	mov	r9, sp	@  sprites
	bge	.L32
	mov	lr, r6	@  i,  i
	mov	r7, sp	@  sprites
.L30:
	add	ip, lr, sl	@  i,  sprites
	ldrb	r1, [ip, #4]	@ zero_extendqisi2	@  <variable>.y
	ldrh	r3, [ip, #12]	@  <variable>.shape
	mov	r2, r4, lsr #16	@  sprite
	orr	r3, r3, r1
	orr	r3, r3, #8192
	ldrh	r1, [lr, sl]	@  <variable>.x
	mov	r2, r2, asl #16
	orr	r4, r2, r3	@  sprite
	ldrh	r0, [ip, #8]	@  <variable>.size
	bic	r1, r1, #65024
	mov	r2, r4, asl #16	@  sprite
	ldr	r3, [ip, #60]	@  <variable>.hFlip
	orr	r0, r0, r1
	mov	r2, r2, lsr #16
	orr	r4, r2, r0, asl #16	@  sprite
	cmp	r3, #0
	mov	r3, r4, lsr #16	@  sprite
	mov	r3, r3, asl #16
	mov	r2, r4, asl #16	@  sprite
	orr	r3, r3, #268435456
	orrne	r4, r3, r2, lsr #16	@  sprite
	mov	r3, r4, lsr #16	@  sprite
	ldr	r2, [ip, #64]	@  <variable>.vFlip
	mov	r3, r3, asl #16
	cmp	r2, #0
	orr	r3, r3, #536870912
	mov	r1, r4, asl #16	@  sprite
	orrne	r4, r3, r1, lsr #16	@  sprite
	ldrh	r2, [ip, #68]	@  <variable>.location
	mov	r3, r5, lsr #16
	add	r6, r6, #1	@  i,  i
	mov	r3, r3, asl #16
	orr	r5, r3, r2
	cmp	r6, r8	@  i,  count
	add	lr, lr, #144	@  i,  i
	stmia	r7!, {r4-r5}	@  tempSprites,  sprite
	blt	.L30
.L32:
	mov	r0, r9	@  sprites
	mov	r1, #117440512
	mov	r2, #512
	mov	r3, #-2147483648
	bl	DMAFastCopy
	ldr	sp, [fp, #-44]
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
	.size	UpdateSpriteMemory, .-UpdateSpriteMemory
	.align	2
	.global	UpdateSpriteMemorySpace
	.type	UpdateSpriteMemorySpace, %function
UpdateSpriteMemorySpace:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, sl, fp, ip, lr, pc}
	mov	r7, #0	@  i
	sub	fp, ip, #4
	mov	r8, r0	@  spriteHandlers
	mov	r5, r1	@  sprites
	mov	sl, r2	@  obj_aff_buffer
	mov	r6, r7	@  i,  i
.L39:
	add	lr, r6, r8	@  i,  spriteHandlers
	ldrh	r2, [r6, r8]	@  <variable>.x
	ldrb	r0, [lr, #4]	@ zero_extendqisi2	@  <variable>.y
	ldrh	r3, [lr, #12]	@  <variable>.shape
	ldrh	r1, [lr, #8]	@  <variable>.size
	ldr	ip, [lr, #28]	@  <variable>.aff
	mov	r4, r7, asl #3	@  i
	orr	r3, r3, r0
	bic	r2, r2, #65024
	orr	r1, r1, r2
	orr	r3, r3, #8192
	add	r0, r4, r5	@  sprites
	cmp	ip, #1
	add	r7, r7, #1	@  i,  i
	add	r6, r6, #144	@  i,  i
	strh	r3, [r4, r5]	@ movhi 	@  <variable>.attribute0
	strh	r1, [r0, #2]	@ movhi 	@  <variable>.attribute1
	beq	.L49
.L38:
	ldrh	lr, [lr, #68]	@ movhi	@  <variable>.location
	cmp	r7, #127	@  i
	strh	lr, [r0, #4]	@ movhi 	@  <variable>.attribute2
	ble	.L39
	mov	r1, #117440512
	mov	r2, #512
	mov	r3, #-2147483648
	mov	r0, r5	@  sprites
	bl	DMAFastCopy
	mov	r3, #117440512
	mov	r2, sl	@  obj_aff_buffer,  obj_aff_buffer
	add	r3, r3, #6
	mov	r1, #31	@  n
.L44:
	ldrh	r0, [r2, #6]	@ movhi	@  <variable>.pa
	strh	r0, [r3, #0]	@ movhi 
	ldrh	r0, [r2, #14]	@ movhi	@  <variable>.pb
	add	r3, r3, #8
	strh	r0, [r3, #0]	@ movhi 
	ldrh	r0, [r2, #22]	@ movhi	@  <variable>.pc
	add	r3, r3, #8
	strh	r0, [r3, #0]	@ movhi 
	ldrh	r0, [r2, #30]	@ movhi	@  <variable>.pd
	add	r3, r3, #8
	subs	r1, r1, #1	@  n,  n
	strh	r0, [r3, #0]	@ movhi 
	add	r2, r2, #32	@  obj_aff_buffer,  obj_aff_buffer
	add	r3, r3, #8
	bpl	.L44
	ldmea	fp, {r4, r5, r6, r7, r8, sl, fp, sp, lr}
	bx	lr
.L49:
	ldrh	r3, [r4, r5]	@  <variable>.attribute0
	ldrh	r1, [r0, #2]	@  <variable>.attribute1
	ldr	r2, [lr, #32]	@  <variable>.affIndex
	orr	r3, r3, #256
	orr	r1, r1, r2, asl #9
	strh	r3, [r4, r5]	@ movhi 	@  <variable>.attribute0
	strh	r1, [r0, #2]	@ movhi 	@  <variable>.attribute1
	b	.L38
	.size	UpdateSpriteMemorySpace, .-UpdateSpriteMemorySpace
	.align	2
	.global	GetNextFreePosition
	.type	GetNextFreePosition, %function
GetNextFreePosition:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	cmp	r2, r1	@  i,  count
	@ lr needed for prologue
	mov	ip, r2	@  i
	bge	.L58
	add	r2, r2, r2, asl #3	@  i
	add	r2, r0, r2, asl #4	@  sprites
	add	r0, r2, #92
.L56:
	ldr	r3, [r0, #0]	@  <variable>.isRemoved
	cmp	r3, #0
	add	r0, r0, #144
	movne	r0, ip	@  i,  i
	bxne	lr
	add	ip, ip, #1	@  i,  i
	cmp	ip, r1	@  i,  count
	blt	.L56
.L58:
	mvn	r0, #0	@  i
	bx	lr
	.size	GetNextFreePosition, .-GetNextFreePosition
	.align	2
	.global	obj_aff_rotate
	.type	obj_aff_rotate, %function
obj_aff_rotate:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r1, r1, asl #16
	mov	r1, r1, lsr #23
	add	r3, r1, #128
	str	lr, [sp, #-4]!
	ldr	lr, .L62
	mov	r3, r3, asl #23
	mov	r1, r1, asl #1
	ldrh	ip, [r1, lr]	@  sin_lut
	mov	r3, r3, lsr #23
	mov	r3, r3, asl #1
	ldrh	r2, [r3, lr]	@  sin_lut
	mov	ip, ip, asl #16
	mov	r3, ip, asr #16	@  <anonymous>
	mov	r2, r2, asl #16
	rsb	r3, r3, #0	@  <anonymous>
	mov	r2, r2, asr #20
	mov	r3, r3, asr #4
	mov	ip, ip, asr #20
	strh	r2, [r0, #30]	@ movhi 	@  <variable>.pd
	strh	r3, [r0, #14]	@ movhi 	@  <variable>.pb
	strh	ip, [r0, #22]	@ movhi 	@  <variable>.pc
	strh	r2, [r0, #6]	@ movhi 	@  <variable>.pa
	ldr	lr, [sp], #4
	bx	lr
.L63:
	.align	2
.L62:
	.word	sin_lut
	.size	obj_aff_rotate, .-obj_aff_rotate
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
	ldr	r2, .L65
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
	ldr	r3, .L65+4
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
.L66:
	.align	2
.L65:
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
	ldreq	r3, .L84
	@ lr needed for prologue
	ldreq	r0, [r3, #12]	@  button,  buttons
	bxeq	lr
	bgt	.L81
	cmp	r0, #2	@  button
	ldreq	r3, .L84
	ldreq	r0, [r3, #4]	@  button,  buttons
	bxeq	lr
	bgt	.L82
	cmp	r0, #1	@  button
	ldreq	r3, .L84
	ldreq	r0, [r3, #0]	@  button,  buttons
	bxeq	lr
.L68:
	bx	lr
.L82:
	cmp	r0, #4	@  button
	ldreq	r3, .L84
	ldreq	r0, [r3, #28]	@  button,  buttons
	bxeq	lr
	cmp	r0, #8	@  button
	ldreq	r3, .L84
	ldreq	r0, [r3, #24]	@  button,  buttons
	bne	.L68
	bx	lr
.L81:
	cmp	r0, #128	@  button
	ldreq	r3, .L84
	ldreq	r0, [r3, #20]	@  button,  buttons
	bxeq	lr
	bgt	.L83
	cmp	r0, #32	@  button
	ldreq	r3, .L84
	ldreq	r0, [r3, #8]	@  button,  buttons
	bxeq	lr
	cmp	r0, #64	@  button
	ldreq	r3, .L84
	ldreq	r0, [r3, #16]	@  button,  buttons
	bne	.L68
	bx	lr
.L83:
	cmp	r0, #256	@  button
	ldreq	r3, .L84
	ldreq	r0, [r3, #32]	@  button,  buttons
	bxeq	lr
	cmp	r0, #512	@  button
	ldreq	r3, .L84
	ldreq	r0, [r3, #36]	@  button,  buttons
	bne	.L68
	bx	lr
.L85:
	.align	2
.L84:
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
	ldr	r0, .L87
	ldr	r3, .L87+4
	ldr	r2, .L87+8
	ldr	r1, [r3, #0]	@  BUTTONS
	ldrh	r3, [r0, #0]	@ movhi	@  curr_state
	strh	r3, [r2, #0]	@ movhi 	@  prev_state
	ldrh	r3, [r1, #0]
	mvn	r3, r3
	bic	r3, r3, #64512
	@ lr needed for prologue
	strh	r3, [r0, #0]	@ movhi 	@  curr_state
	bx	lr
.L88:
	.align	2
.L87:
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
	ldr	r3, .L90
	ldrh	r2, [r3, #0]	@  curr_state
	and	r2, r2, r0	@  key,  key
	mov	r0, r2	@  key
	@ lr needed for prologue
	bx	lr
.L91:
	.align	2
.L90:
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
	ldr	r3, .L93
	ldrh	r2, [r3, #0]	@  curr_state
	bic	r0, r0, r2	@  key,  key
	@ lr needed for prologue
	bx	lr
.L94:
	.align	2
.L93:
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
	ldr	r3, .L96
	ldrh	r2, [r3, #0]	@  prev_state
	and	r2, r2, r0	@  key,  key
	mov	r0, r2	@  key
	@ lr needed for prologue
	bx	lr
.L97:
	.align	2
.L96:
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
	ldr	r3, .L99
	ldrh	r2, [r3, #0]	@  prev_state
	bic	r0, r0, r2	@  key,  key
	@ lr needed for prologue
	bx	lr
.L100:
	.align	2
.L99:
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
	ldr	r3, .L102
	ldr	r1, .L102+4
	ldrh	r2, [r3, #0]	@  curr_state
	ldrh	r3, [r1, #0]	@  prev_state
	eor	r2, r2, r3
	and	r2, r2, r0	@  key,  key
	mov	r0, r2	@  key
	@ lr needed for prologue
	bx	lr
.L103:
	.align	2
.L102:
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
	ldr	r3, .L105
	ldr	r1, .L105+4
	ldrh	r2, [r3, #0]	@  curr_state
	ldrh	r3, [r1, #0]	@  prev_state
	and	r2, r2, r3
	and	r2, r2, r0	@  key,  key
	mov	r0, r2	@  key
	@ lr needed for prologue
	bx	lr
.L106:
	.align	2
.L105:
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
	ldr	r3, .L108
	ldr	r1, .L108+4
	ldrh	r2, [r3, #0]	@  curr_state
	ldrh	r3, [r1, #0]	@  prev_state
	bic	r2, r2, r3
	and	r2, r2, r0	@  key,  key
	mov	r0, r2	@  key
	@ lr needed for prologue
	bx	lr
.L109:
	.align	2
.L108:
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
	ldr	r3, .L111
	ldr	r2, .L111+4
	ldrh	r1, [r3, #0]	@  curr_state
	ldrh	r3, [r2, #0]	@  prev_state
	bic	r3, r3, r1
	and	r3, r3, r0	@  key,  key
	mov	r0, r3	@  key
	@ lr needed for prologue
	bx	lr
.L112:
	.align	2
.L111:
	.word	curr_state
	.word	prev_state
	.size	keyReleased, .-keyReleased
	.global	philFacingRight3Data
	.section	.rodata
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
	.short	15
	.short	0
	.short	0
	.short	3855
	.short	15
	.short	0
	.short	0
	.short	3855
	.short	15
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
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
	.global	philJumpingData
	.align	1
	.type	philJumpingData, %object
	.size	philJumpingData, 1024
philJumpingData:
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
	.short	3328
	.short	3341
	.short	19456
	.short	0
	.short	16909
	.short	3407
	.short	256
	.short	3328
	.short	20290
	.short	3407
	.short	19712
	.short	3328
	.short	16962
	.short	3407
	.short	19712
	.short	0
	.short	16909
	.short	3394
	.short	0
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
	.short	3328
	.short	3394
	.short	0
	.short	0
	.short	0
	.short	3341
	.short	0
	.short	0
	.short	0
	.short	3328
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	19788
	.short	589
	.short	19789
	.short	0
	.short	19456
	.short	19789
	.short	19714
	.short	0
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
	.global	philJumpingPalette
	.align	1
	.type	philJumpingPalette, %object
	.size	philJumpingPalette, 512
philJumpingPalette:
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
	.global	bg_Palette
	.align	1
	.type	bg_Palette, %object
	.size	bg_Palette, 512
bg_Palette:
	.short	0
	.short	528
	.short	25464
	.short	264
	.short	268
	.short	540
	.short	924
	.short	8328
	.short	8456
	.short	8584
	.short	8588
	.short	8712
	.short	8732
	.short	8968
	.short	8984
	.short	16648
	.short	16656
	.short	16904
	.short	16924
	.short	24580
	.short	24584
	.short	24596
	.short	24840
	.short	25244
	.short	21140
	.short	31
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
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.global	shipBGscrn_Tiles
	.type	shipBGscrn_Tiles, %object
	.size	shipBGscrn_Tiles, 4992
shipBGscrn_Tiles:
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
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	10
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
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
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
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	10
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
	.byte	26
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
	.byte	26
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
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	10
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
	.byte	26
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
	.byte	26
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
	.byte	26
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
	.byte	26
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
	.byte	20
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
	.byte	26
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
	.byte	26
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
	.byte	24
	.byte	24
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	24
	.byte	24
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
	.byte	26
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
	.byte	26
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
	.byte	26
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
	.byte	26
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	26
	.byte	26
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	20
	.byte	26
	.byte	26
	.byte	26
	.byte	0
	.byte	0
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	26
	.byte	0
	.byte	0
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	0
	.byte	20
	.byte	13
	.byte	13
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	0
	.byte	20
	.byte	20
	.byte	13
	.byte	13
	.byte	20
	.byte	13
	.byte	13
	.byte	0
	.byte	20
	.byte	20
	.byte	13
	.byte	13
	.byte	20
	.byte	13
	.byte	13
	.byte	0
	.byte	20
	.byte	20
	.byte	13
	.byte	13
	.byte	13
	.byte	13
	.byte	20
	.byte	26
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	26
	.byte	26
	.byte	20
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	0
	.byte	0
	.byte	0
	.byte	20
	.byte	20
	.byte	13
	.byte	13
	.byte	13
	.byte	0
	.byte	0
	.byte	0
	.byte	20
	.byte	13
	.byte	13
	.byte	13
	.byte	13
	.byte	20
	.byte	0
	.byte	0
	.byte	13
	.byte	20
	.byte	20
	.byte	13
	.byte	13
	.byte	20
	.byte	0
	.byte	0
	.byte	13
	.byte	20
	.byte	20
	.byte	13
	.byte	13
	.byte	20
	.byte	0
	.byte	0
	.byte	20
	.byte	20
	.byte	13
	.byte	13
	.byte	13
	.byte	20
	.byte	0
	.byte	0
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
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
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
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
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
	.byte	6
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
	.byte	26
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	26
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	7
	.byte	9
	.byte	10
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	26
	.byte	26
	.byte	9
	.byte	26
	.byte	26
	.byte	26
	.byte	26
	.byte	26
	.byte	25
	.byte	25
	.byte	9
	.byte	26
	.byte	25
	.byte	26
	.byte	26
	.byte	26
	.byte	25
	.byte	25
	.byte	9
	.byte	26
	.byte	26
	.byte	25
	.byte	26
	.byte	26
	.byte	25
	.byte	25
	.byte	9
	.byte	26
	.byte	26
	.byte	25
	.byte	26
	.byte	26
	.byte	25
	.byte	25
	.byte	9
	.byte	26
	.byte	26
	.byte	26
	.byte	25
	.byte	26
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	23
	.byte	26
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	25
	.byte	26
	.byte	26
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	9
	.byte	10
	.byte	9
	.byte	7
	.byte	26
	.byte	26
	.byte	26
	.byte	26
	.byte	26
	.byte	9
	.byte	26
	.byte	26
	.byte	26
	.byte	26
	.byte	26
	.byte	25
	.byte	26
	.byte	9
	.byte	25
	.byte	25
	.byte	26
	.byte	26
	.byte	25
	.byte	26
	.byte	26
	.byte	9
	.byte	25
	.byte	25
	.byte	26
	.byte	26
	.byte	25
	.byte	26
	.byte	26
	.byte	9
	.byte	25
	.byte	25
	.byte	26
	.byte	25
	.byte	26
	.byte	26
	.byte	26
	.byte	9
	.byte	25
	.byte	25
	.byte	0
	.byte	0
	.byte	20
	.byte	20
	.byte	13
	.byte	13
	.byte	20
	.byte	20
	.byte	0
	.byte	0
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	26
	.byte	26
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
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	0
	.byte	0
	.byte	0
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	0
	.byte	0
	.byte	0
	.byte	20
	.byte	20
	.byte	20
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	26
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
	.byte	26
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	11
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	11
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	11
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	11
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	11
	.byte	11
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	24
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
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
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	26
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
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
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
	.byte	26
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
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	25
	.byte	25
	.byte	9
	.byte	26
	.byte	26
	.byte	26
	.byte	26
	.byte	25
	.byte	25
	.byte	25
	.byte	9
	.byte	26
	.byte	26
	.byte	26
	.byte	26
	.byte	26
	.byte	25
	.byte	25
	.byte	9
	.byte	26
	.byte	26
	.byte	26
	.byte	26
	.byte	25
	.byte	25
	.byte	25
	.byte	9
	.byte	26
	.byte	26
	.byte	26
	.byte	25
	.byte	26
	.byte	25
	.byte	25
	.byte	9
	.byte	26
	.byte	26
	.byte	25
	.byte	26
	.byte	26
	.byte	25
	.byte	25
	.byte	9
	.byte	26
	.byte	26
	.byte	25
	.byte	26
	.byte	26
	.byte	25
	.byte	25
	.byte	9
	.byte	26
	.byte	25
	.byte	26
	.byte	26
	.byte	26
	.byte	26
	.byte	26
	.byte	7
	.byte	26
	.byte	26
	.byte	26
	.byte	26
	.byte	26
	.byte	25
	.byte	26
	.byte	26
	.byte	26
	.byte	26
	.byte	9
	.byte	25
	.byte	25
	.byte	25
	.byte	26
	.byte	26
	.byte	26
	.byte	26
	.byte	9
	.byte	25
	.byte	25
	.byte	25
	.byte	26
	.byte	26
	.byte	26
	.byte	26
	.byte	9
	.byte	25
	.byte	25
	.byte	26
	.byte	25
	.byte	26
	.byte	26
	.byte	26
	.byte	9
	.byte	25
	.byte	25
	.byte	26
	.byte	26
	.byte	25
	.byte	26
	.byte	26
	.byte	9
	.byte	25
	.byte	25
	.byte	26
	.byte	26
	.byte	25
	.byte	26
	.byte	26
	.byte	9
	.byte	25
	.byte	25
	.byte	26
	.byte	26
	.byte	26
	.byte	25
	.byte	26
	.byte	9
	.byte	25
	.byte	25
	.byte	26
	.byte	26
	.byte	26
	.byte	26
	.byte	26
	.byte	7
	.byte	26
	.byte	26
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
	.byte	6
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
	.byte	26
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
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	20
	.byte	20
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	20
	.byte	5
	.byte	20
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	20
	.byte	5
	.byte	20
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	20
	.byte	5
	.byte	5
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
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
	.byte	0
	.byte	0
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	0
	.byte	6
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	6
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	6
	.byte	6
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	6
	.byte	6
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	6
	.byte	6
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	6
	.byte	0
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	14
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	0
	.byte	0
	.byte	0
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	0
	.byte	0
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	0
	.byte	0
	.byte	6
	.byte	6
	.byte	6
	.byte	6
	.byte	14
	.byte	0
	.byte	0
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	0
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	0
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	0
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	6
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	6
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	6
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	6
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
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
	.byte	22
	.byte	15
	.byte	15
	.byte	15
	.byte	15
	.byte	15
	.byte	10
	.byte	11
	.byte	21
	.byte	20
	.byte	19
	.byte	19
	.byte	20
	.byte	21
	.byte	15
	.byte	11
	.byte	20
	.byte	19
	.byte	20
	.byte	20
	.byte	16
	.byte	20
	.byte	15
	.byte	11
	.byte	20
	.byte	19
	.byte	20
	.byte	19
	.byte	20
	.byte	20
	.byte	15
	.byte	11
	.byte	20
	.byte	20
	.byte	16
	.byte	20
	.byte	19
	.byte	20
	.byte	15
	.byte	11
	.byte	20
	.byte	19
	.byte	20
	.byte	19
	.byte	19
	.byte	20
	.byte	10
	.byte	11
	.byte	20
	.byte	19
	.byte	19
	.byte	19
	.byte	19
	.byte	20
	.byte	15
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
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	16
	.byte	22
	.byte	11
	.byte	11
	.byte	12
	.byte	5
	.byte	5
	.byte	5
	.byte	12
	.byte	22
	.byte	11
	.byte	11
	.byte	20
	.byte	20
	.byte	20
	.byte	19
	.byte	20
	.byte	15
	.byte	11
	.byte	11
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	22
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
	.byte	22
	.byte	15
	.byte	15
	.byte	15
	.byte	15
	.byte	15
	.byte	11
	.byte	11
	.byte	21
	.byte	20
	.byte	19
	.byte	19
	.byte	20
	.byte	21
	.byte	11
	.byte	11
	.byte	20
	.byte	19
	.byte	20
	.byte	20
	.byte	16
	.byte	20
	.byte	11
	.byte	11
	.byte	20
	.byte	19
	.byte	20
	.byte	19
	.byte	20
	.byte	20
	.byte	11
	.byte	11
	.byte	20
	.byte	20
	.byte	16
	.byte	20
	.byte	19
	.byte	20
	.byte	11
	.byte	11
	.byte	20
	.byte	19
	.byte	20
	.byte	19
	.byte	19
	.byte	20
	.byte	11
	.byte	11
	.byte	20
	.byte	19
	.byte	19
	.byte	19
	.byte	19
	.byte	20
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	0
	.byte	0
	.byte	0
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
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
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	10
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	10
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
	.byte	20
	.byte	5
	.byte	5
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	20
	.byte	20
	.byte	5
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	20
	.byte	20
	.byte	5
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	20
	.byte	20
	.byte	5
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	5
	.byte	5
	.byte	5
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	20
	.byte	5
	.byte	20
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	0
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	0
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	4
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	6
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	6
	.byte	6
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	6
	.byte	6
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	6
	.byte	0
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	0
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	6
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	6
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	0
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	0
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	0
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	0
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	0
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	6
	.byte	6
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	4
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	6
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	6
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	20
	.byte	19
	.byte	19
	.byte	19
	.byte	19
	.byte	20
	.byte	15
	.byte	11
	.byte	20
	.byte	19
	.byte	19
	.byte	19
	.byte	20
	.byte	20
	.byte	15
	.byte	11
	.byte	20
	.byte	19
	.byte	19
	.byte	20
	.byte	22
	.byte	20
	.byte	15
	.byte	11
	.byte	20
	.byte	19
	.byte	19
	.byte	20
	.byte	22
	.byte	20
	.byte	15
	.byte	11
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	15
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
	.byte	20
	.byte	19
	.byte	19
	.byte	19
	.byte	19
	.byte	20
	.byte	11
	.byte	11
	.byte	20
	.byte	19
	.byte	19
	.byte	19
	.byte	20
	.byte	20
	.byte	11
	.byte	11
	.byte	20
	.byte	19
	.byte	19
	.byte	20
	.byte	22
	.byte	20
	.byte	11
	.byte	11
	.byte	20
	.byte	19
	.byte	19
	.byte	20
	.byte	22
	.byte	20
	.byte	11
	.byte	11
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	20
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
	.byte	2
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	2
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	2
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
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
	.byte	2
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	2
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	2
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	20
	.byte	5
	.byte	20
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	20
	.byte	5
	.byte	20
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	5
	.byte	5
	.byte	5
	.byte	5
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	20
	.byte	5
	.byte	20
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	20
	.byte	5
	.byte	20
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	0
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	0
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	0
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	6
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	6
	.byte	6
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	6
	.byte	6
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	6
	.byte	0
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	0
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	6
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	6
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	6
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	0
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	0
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	0
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	0
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	14
	.byte	6
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	6
	.byte	11
	.byte	20
	.byte	20
	.byte	20
	.byte	20
	.byte	11
	.byte	11
	.byte	0
	.byte	11
	.byte	20
	.byte	19
	.byte	20
	.byte	20
	.byte	11
	.byte	11
	.byte	0
	.byte	11
	.byte	24
	.byte	2
	.byte	18
	.byte	17
	.byte	11
	.byte	11
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	1
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
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
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	24
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	24
	.byte	24
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	24
	.byte	24
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	24
	.byte	24
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	24
	.byte	24
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	24
	.byte	24
	.byte	24
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	20
	.byte	20
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	20
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	0
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	0
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	1
	.byte	24
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	14
	.byte	6
	.byte	24
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	6
	.byte	6
	.byte	24
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	6
	.byte	6
	.byte	24
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	6
	.byte	0
	.byte	24
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	0
	.byte	0
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	6
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	6
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	6
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	0
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	0
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	0
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	0
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	6
	.byte	6
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	6
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	0
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	0
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	3
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	6
	.byte	9
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	6
	.byte	9
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
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
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
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
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	24
	.byte	24
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	24
	.byte	24
	.byte	24
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	11
	.byte	24
	.byte	24
	.byte	24
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	8
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
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
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	24
	.byte	10
	.byte	24
	.byte	24
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
	.byte	10
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
	.global	shipBGscrn_Map
	.align	1
	.type	shipBGscrn_Map, %object
	.size	shipBGscrn_Map, 4000
shipBGscrn_Map:
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
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
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
	.short	2
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
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	4
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	1028
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	6
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	5
	.short	1028
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	7
	.short	0
	.short	8
	.short	0
	.short	0
	.short	0
	.short	9
	.short	0
	.short	0
	.short	0
	.short	1031
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	10
	.short	11
	.short	0
	.short	12
	.short	0
	.short	0
	.short	0
	.short	0
	.short	13
	.short	0
	.short	0
	.short	1031
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	7
	.short	0
	.short	14
	.short	0
	.short	15
	.short	0
	.short	0
	.short	0
	.short	16
	.short	3084
	.short	1031
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	10
	.short	17
	.short	0
	.short	0
	.short	0
	.short	1032
	.short	0
	.short	0
	.short	0
	.short	18
	.short	19
	.short	1031
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	7
	.short	0
	.short	0
	.short	0
	.short	20
	.short	0
	.short	2060
	.short	0
	.short	0
	.short	0
	.short	1031
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	10
	.short	0
	.short	1038
	.short	21
	.short	22
	.short	0
	.short	9
	.short	23
	.short	24
	.short	0
	.short	0
	.short	1031
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	25
	.short	26
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	7
	.short	0
	.short	2065
	.short	0
	.short	0
	.short	3080
	.short	27
	.short	0
	.short	0
	.short	0
	.short	1031
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	28
	.short	29
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	10
	.short	1035
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	30
	.short	31
	.short	0
	.short	32
	.short	1031
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	33
	.short	34
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	7
	.short	35
	.short	35
	.short	36
	.short	35
	.short	35
	.short	35
	.short	37
	.short	36
	.short	35
	.short	1031
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	38
	.short	39
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	10
	.short	40
	.short	0
	.short	41
	.short	8
	.short	3081
	.short	0
	.short	17
	.short	0
	.short	0
	.short	0
	.short	1031
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	42
	.short	43
	.short	44
	.short	45
	.short	46
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	47
	.short	48
	.short	3
	.short	3
	.short	3
	.short	3
	.short	28
	.short	29
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	28
	.short	29
	.short	28
	.short	29
	.short	28
	.short	29
	.short	3
	.short	3
	.short	3
	.short	3
	.short	47
	.short	48
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	49
	.short	48
	.short	3
	.short	3
	.short	3
	.short	3
	.short	28
	.short	29
	.short	3
	.short	50
	.short	51
	.short	51
	.short	51
	.short	51
	.short	51
	.short	51
	.short	51
	.short	51
	.short	51
	.short	51
	.short	52
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	53
	.short	54
	.short	55
	.short	56
	.short	57
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	58
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	38
	.short	39
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	38
	.short	39
	.short	38
	.short	39
	.short	38
	.short	39
	.short	3
	.short	3
	.short	3
	.short	3
	.short	58
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	59
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	38
	.short	39
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	60
	.short	61
	.short	62
	.short	63
	.short	64
	.short	65
	.short	66
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	28
	.short	29
	.short	28
	.short	29
	.short	28
	.short	29
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	28
	.short	29
	.short	28
	.short	29
	.short	28
	.short	29
	.short	28
	.short	29
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	28
	.short	29
	.short	28
	.short	29
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	28
	.short	29
	.short	28
	.short	29
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	3
	.short	67
	.short	68
	.short	69
	.short	70
	.short	71
	.short	72
	.short	73
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	38
	.short	39
	.short	38
	.short	39
	.short	38
	.short	39
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	38
	.short	39
	.short	38
	.short	39
	.short	38
	.short	39
	.short	38
	.short	39
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	38
	.short	39
	.short	38
	.short	39
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	38
	.short	39
	.short	38
	.short	39
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	74
	.short	75
	.short	34
	.short	34
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	76
	.short	77
	.short	76
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
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.global	shipHitMapscrn_Tiles
	.type	shipHitMapscrn_Tiles, %object
	.size	shipHitMapscrn_Tiles, 128
shipHitMapscrn_Tiles:
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
	.global	shipHitMapscrn_Map
	.align	1
	.type	shipHitMapscrn_Map, %object
	.size	shipHitMapscrn_Map, 4000
shipHitMapscrn_Map:
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
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
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
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
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
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
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
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
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
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
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
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
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
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
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
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
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
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
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
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
	.global	hudLifeData
	.align	1
	.type	hudLifeData, %object
	.size	hudLifeData, 128
hudLifeData:
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	79
	.short	0
	.short	79
	.short	0
	.short	79
	.short	0
	.short	79
	.short	0
	.short	79
	.short	0
	.short	79
	.short	0
	.short	79
	.short	0
	.short	79
	.short	0
	.short	79
	.short	0
	.short	79
	.short	0
	.short	79
	.short	0
	.short	79
	.short	0
	.short	20303
	.short	79
	.short	79
	.short	0
	.short	0
	.short	0
	.short	0
	.short	20303
	.short	79
	.short	20303
	.short	79
	.short	79
	.short	0
	.short	79
	.short	0
	.short	79
	.short	0
	.short	79
	.short	0
	.short	20303
	.short	0
	.short	20303
	.short	0
	.short	79
	.short	0
	.short	79
	.short	0
	.short	79
	.short	0
	.short	79
	.short	0
	.short	79
	.short	0
	.short	20303
	.short	79
	.global	hudLifePalette
	.align	1
	.type	hudLifePalette, %object
	.size	hudLifePalette, 512
hudLifePalette:
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
	.global	hudPercentData
	.align	1
	.type	hudPercentData, %object
	.size	hudPercentData, 64
hudPercentData:
	.short	20225
	.short	20303
	.short	257
	.short	257
	.short	20225
	.short	20225
	.short	257
	.short	335
	.short	20225
	.short	20303
	.short	20225
	.short	257
	.short	257
	.short	257
	.short	335
	.short	257
	.short	257
	.short	20225
	.short	257
	.short	257
	.short	257
	.short	335
	.short	20303
	.short	335
	.short	20225
	.short	257
	.short	335
	.short	335
	.short	335
	.short	257
	.short	20303
	.short	335
	.global	hudPercentPalette
	.align	1
	.type	hudPercentPalette, %object
	.size	hudPercentPalette, 512
hudPercentPalette:
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
	.global	hud0Data
	.align	1
	.type	hud0Data, %object
	.size	hud0Data, 64
hud0Data:
	.short	257
	.short	257
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	335
	.short	257
	.short	257
	.short	335
	.short	20225
	.short	257
	.short	257
	.short	335
	.short	20225
	.short	257
	.short	257
	.short	335
	.short	20225
	.short	257
	.short	257
	.short	335
	.short	20225
	.short	257
	.short	257
	.short	335
	.short	20225
	.short	257
	.short	257
	.short	20225
	.short	335
	.short	257
	.global	hud0Palette
	.align	1
	.type	hud0Palette, %object
	.size	hud0Palette, 512
hud0Palette:
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
	.global	hud1Data
	.align	1
	.type	hud1Data, %object
	.size	hud1Data, 64
hud1Data:
	.short	257
	.short	257
	.short	257
	.short	257
	.short	257
	.short	257
	.short	335
	.short	257
	.short	257
	.short	20225
	.short	335
	.short	257
	.short	257
	.short	257
	.short	335
	.short	257
	.short	257
	.short	257
	.short	335
	.short	257
	.short	257
	.short	257
	.short	335
	.short	257
	.short	257
	.short	257
	.short	335
	.short	257
	.short	257
	.short	20225
	.short	20303
	.short	257
	.global	hud1Palette
	.align	1
	.type	hud1Palette, %object
	.size	hud1Palette, 512
hud1Palette:
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
	.global	hud2Data
	.align	1
	.type	hud2Data, %object
	.size	hud2Data, 64
hud2Data:
	.short	257
	.short	257
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	335
	.short	257
	.short	257
	.short	335
	.short	20225
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	257
	.short	257
	.short	257
	.short	335
	.short	257
	.short	257
	.short	20225
	.short	257
	.short	257
	.short	257
	.short	335
	.short	257
	.short	257
	.short	257
	.short	20303
	.short	20303
	.short	257
	.global	hud2Palette
	.align	1
	.type	hud2Palette, %object
	.size	hud2Palette, 512
hud2Palette:
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
	.global	hud3Data
	.align	1
	.type	hud3Data, %object
	.size	hud3Data, 64
hud3Data:
	.short	257
	.short	257
	.short	257
	.short	257
	.short	257
	.short	20303
	.short	335
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	257
	.short	257
	.short	20225
	.short	335
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	257
	.short	257
	.short	20303
	.short	335
	.short	257
	.global	hud3Palette
	.align	1
	.type	hud3Palette, %object
	.size	hud3Palette, 512
hud3Palette:
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
	.global	hud4Data
	.align	1
	.type	hud4Data, %object
	.size	hud4Data, 64
hud4Data:
	.short	257
	.short	257
	.short	257
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	257
	.short	257
	.short	335
	.short	20225
	.short	257
	.short	257
	.short	335
	.short	20225
	.short	257
	.short	257
	.short	20303
	.short	20303
	.short	335
	.short	257
	.short	257
	.short	20225
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	257
	.global	hud4Palette
	.align	1
	.type	hud4Palette, %object
	.size	hud4Palette, 512
hud4Palette:
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
	.global	hud5Data
	.align	1
	.type	hud5Data, %object
	.size	hud5Data, 64
hud5Data:
	.short	257
	.short	257
	.short	257
	.short	257
	.short	257
	.short	20303
	.short	20303
	.short	257
	.short	257
	.short	335
	.short	257
	.short	257
	.short	257
	.short	335
	.short	257
	.short	257
	.short	257
	.short	20303
	.short	335
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	257
	.short	257
	.short	20303
	.short	335
	.short	257
	.global	hud5Palette
	.align	1
	.type	hud5Palette, %object
	.size	hud5Palette, 512
hud5Palette:
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
	.global	hud6Data
	.align	1
	.type	hud6Data, %object
	.size	hud6Data, 64
hud6Data:
	.short	257
	.short	257
	.short	257
	.short	257
	.short	257
	.short	20303
	.short	20303
	.short	257
	.short	257
	.short	335
	.short	257
	.short	257
	.short	257
	.short	335
	.short	257
	.short	257
	.short	257
	.short	20303
	.short	20303
	.short	257
	.short	257
	.short	335
	.short	20225
	.short	257
	.short	257
	.short	335
	.short	20225
	.short	257
	.short	257
	.short	20303
	.short	20303
	.short	257
	.global	hud6Palette
	.align	1
	.type	hud6Palette, %object
	.size	hud6Palette, 512
hud6Palette:
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
	.global	hud7Data
	.align	1
	.type	hud7Data, %object
	.size	hud7Data, 64
hud7Data:
	.short	257
	.short	257
	.short	257
	.short	257
	.short	257
	.short	20303
	.short	20303
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	257
	.global	hud7Palette
	.align	1
	.type	hud7Palette, %object
	.size	hud7Palette, 512
hud7Palette:
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
	.global	hud8Data
	.align	1
	.type	hud8Data, %object
	.size	hud8Data, 64
hud8Data:
	.short	257
	.short	257
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	335
	.short	257
	.short	257
	.short	335
	.short	20225
	.short	257
	.short	257
	.short	335
	.short	20225
	.short	257
	.short	257
	.short	20225
	.short	335
	.short	257
	.short	257
	.short	335
	.short	20225
	.short	257
	.short	257
	.short	335
	.short	20225
	.short	257
	.short	257
	.short	20225
	.short	335
	.short	257
	.global	hud8Palette
	.align	1
	.type	hud8Palette, %object
	.size	hud8Palette, 512
hud8Palette:
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
	.global	hud9Data
	.align	1
	.type	hud9Data, %object
	.size	hud9Data, 64
hud9Data:
	.short	257
	.short	257
	.short	257
	.short	257
	.short	257
	.short	20303
	.short	20303
	.short	257
	.short	257
	.short	335
	.short	20225
	.short	257
	.short	257
	.short	335
	.short	20225
	.short	257
	.short	257
	.short	20303
	.short	20303
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	257
	.short	257
	.short	257
	.short	20225
	.short	257
	.global	hud9Palette
	.align	1
	.type	hud9Palette, %object
	.size	hud9Palette, 512
hud9Palette:
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
	.global	laserPurpleData
	.align	1
	.type	laserPurpleData, %object
	.size	laserPurpleData, 64
laserPurpleData:
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	15677
	.short	15677
	.short	15677
	.short	15677
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.global	laserPurplePalette
	.align	1
	.type	laserPurplePalette, %object
	.size	laserPurplePalette, 512
laserPurplePalette:
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
	.global	enemyData
	.align	1
	.type	enemyData, %object
	.size	enemyData, 512
enemyData:
	.short	0
	.short	0
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
	.short	514
	.short	0
	.short	0
	.short	7168
	.short	7196
	.short	0
	.short	0
	.short	7168
	.short	7196
	.short	0
	.short	0
	.short	256
	.short	7247
	.short	0
	.short	0
	.short	7168
	.short	7196
	.short	512
	.short	514
	.short	0
	.short	0
	.short	2
	.short	0
	.short	0
	.short	0
	.short	0
	.short	514
	.short	0
	.short	0
	.short	512
	.short	0
	.short	0
	.short	0
	.short	7196
	.short	540
	.short	2
	.short	0
	.short	7196
	.short	28
	.short	512
	.short	0
	.short	20225
	.short	540
	.short	0
	.short	0
	.short	7196
	.short	28
	.short	2
	.short	0
	.short	0
	.short	0
	.short	0
	.short	7196
	.short	0
	.short	0
	.short	0
	.short	7168
	.short	0
	.short	0
	.short	0
	.short	7200
	.short	0
	.short	0
	.short	8192
	.short	8224
	.short	0
	.short	0
	.short	8192
	.short	8224
	.short	0
	.short	0
	.short	8192
	.short	8224
	.short	19456
	.short	19789
	.short	19789
	.short	19789
	.short	0
	.short	0
	.short	19789
	.short	19789
	.short	7196
	.short	0
	.short	512
	.short	0
	.short	7196
	.short	0
	.short	0
	.short	0
	.short	7196
	.short	32
	.short	0
	.short	0
	.short	8224
	.short	8224
	.short	0
	.short	0
	.short	7200
	.short	8220
	.short	0
	.short	0
	.short	8224
	.short	7196
	.short	0
	.short	0
	.short	19789
	.short	7245
	.short	19740
	.short	7168
	.short	19789
	.short	7196
	.short	19789
	.short	28
	.short	0
	.short	0
	.short	0
	.short	7245
	.short	0
	.short	0
	.short	0
	.short	8224
	.short	0
	.short	0
	.short	0
	.short	7168
	.short	0
	.short	0
	.short	0
	.short	8224
	.short	0
	.short	0
	.short	8192
	.short	8224
	.short	0
	.short	0
	.short	8192
	.short	8224
	.short	0
	.short	0
	.short	8192
	.short	8224
	.short	0
	.short	0
	.short	8192
	.short	32
	.short	7196
	.short	8220
	.short	19712
	.short	28
	.short	8224
	.short	8224
	.short	0
	.short	28
	.short	7196
	.short	28
	.short	7168
	.short	28
	.short	8224
	.short	8224
	.short	7168
	.short	0
	.short	8224
	.short	8224
	.short	7196
	.short	0
	.short	8224
	.short	8224
	.short	28
	.short	0
	.short	8192
	.short	32
	.short	0
	.short	0
	.short	0
	.short	32
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	8224
	.short	0
	.short	0
	.short	0
	.short	8192
	.short	0
	.short	0
	.short	0
	.short	7196
	.short	0
	.short	0
	.short	7168
	.short	28
	.short	0
	.short	0
	.short	7168
	.short	0
	.short	0
	.short	0
	.short	7168
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	0
	.short	0
	.short	19712
	.short	19789
	.short	77
	.short	0
	.short	8224
	.short	0
	.short	0
	.short	32
	.short	8192
	.short	32
	.short	0
	.short	0
	.short	7196
	.short	0
	.short	0
	.short	7168
	.short	28
	.short	0
	.short	0
	.short	7168
	.short	0
	.short	0
	.short	0
	.short	7168
	.short	0
	.short	0
	.short	0
	.short	19712
	.short	0
	.short	0
	.short	0
	.short	19789
	.short	19789
	.short	0
	.short	0
	.global	enemyPalette
	.align	1
	.type	enemyPalette, %object
	.size	enemyPalette, 512
enemyPalette:
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
	.global	continueData
	.align	1
	.type	continueData, %object
	.size	continueData, 512
continueData:
	.short	20303
	.short	79
	.short	20303
	.short	79
	.short	79
	.short	79
	.short	79
	.short	79
	.short	79
	.short	0
	.short	79
	.short	79
	.short	79
	.short	0
	.short	79
	.short	79
	.short	79
	.short	0
	.short	79
	.short	79
	.short	79
	.short	79
	.short	79
	.short	79
	.short	20303
	.short	79
	.short	20303
	.short	79
	.short	0
	.short	0
	.short	0
	.short	0
	.short	79
	.short	20224
	.short	20224
	.short	20303
	.short	20303
	.short	20224
	.short	0
	.short	79
	.short	79
	.short	20303
	.short	0
	.short	79
	.short	79
	.short	20303
	.short	0
	.short	79
	.short	79
	.short	20224
	.short	0
	.short	79
	.short	79
	.short	20224
	.short	0
	.short	79
	.short	79
	.short	20224
	.short	0
	.short	79
	.short	0
	.short	0
	.short	0
	.short	0
	.short	20224
	.short	20224
	.short	0
	.short	79
	.short	20224
	.short	20224
	.short	79
	.short	79
	.short	20224
	.short	20224
	.short	20224
	.short	79
	.short	20224
	.short	20224
	.short	20224
	.short	79
	.short	20224
	.short	20224
	.short	0
	.short	79
	.short	20224
	.short	20224
	.short	0
	.short	79
	.short	20224
	.short	20224
	.short	0
	.short	79
	.short	0
	.short	0
	.short	0
	.short	0
	.short	79
	.short	79
	.short	20303
	.short	79
	.short	79
	.short	79
	.short	79
	.short	0
	.short	79
	.short	79
	.short	79
	.short	0
	.short	79
	.short	79
	.short	20303
	.short	0
	.short	79
	.short	79
	.short	79
	.short	0
	.short	79
	.short	79
	.short	79
	.short	0
	.short	20303
	.short	79
	.short	20303
	.short	79
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	20303
	.short	79
	.short	20303
	.short	79
	.short	79
	.short	79
	.short	79
	.short	79
	.short	20303
	.short	79
	.short	20303
	.short	79
	.short	79
	.short	0
	.short	20303
	.short	0
	.short	79
	.short	0
	.short	79
	.short	79
	.short	79
	.short	0
	.short	79
	.short	79
	.short	79
	.short	0
	.short	79
	.short	79
	.short	0
	.short	0
	.short	0
	.short	0
	.short	20303
	.short	79
	.short	20303
	.short	79
	.short	79
	.short	0
	.short	79
	.short	0
	.short	20303
	.short	0
	.short	20303
	.short	79
	.short	79
	.short	0
	.short	0
	.short	79
	.short	79
	.short	0
	.short	0
	.short	79
	.short	79
	.short	0
	.short	0
	.short	79
	.short	20303
	.short	79
	.short	20303
	.short	79
	.short	0
	.short	0
	.short	0
	.short	0
	.short	20303
	.short	79
	.short	0
	.short	79
	.short	79
	.short	0
	.short	0
	.short	20224
	.short	20303
	.short	79
	.short	0
	.short	0
	.short	0
	.short	79
	.short	0
	.short	0
	.short	0
	.short	79
	.short	0
	.short	0
	.short	0
	.short	79
	.short	0
	.short	0
	.short	20303
	.short	79
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	0
	.short	20303
	.short	79
	.short	20224
	.short	0
	.short	79
	.short	79
	.short	79
	.short	0
	.short	79
	.short	79
	.short	0
	.short	0
	.short	20303
	.short	79
	.short	0
	.short	0
	.short	79
	.short	79
	.short	0
	.short	0
	.short	79
	.short	79
	.short	0
	.short	0
	.short	79
	.short	79
	.short	0
	.global	continuePalette
	.align	1
	.type	continuePalette, %object
	.size	continuePalette, 512
continuePalette:
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
	.global	mapTiles
	.data
	.align	2
	.type	mapTiles, %object
	.size	mapTiles, 4
mapTiles:
	.word	shipBGscrn_Tiles
	.global	map
	.align	2
	.type	map, %object
	.size	map, 4
map:
	.word	shipBGscrn_Map
	.global	mapPalette
	.align	2
	.type	mapPalette, %object
	.size	mapPalette, 4
mapPalette:
	.word	bg_Palette
	.global	hitMap
	.align	2
	.type	hitMap, %object
	.size	hitMap, 4
hitMap:
	.word	shipHitMapscrn_Map
	.global	hitMapTiles
	.align	2
	.type	hitMapTiles, %object
	.size	hitMapTiles, 4
hitMapTiles:
	.word	shipHitMapscrn_Tiles
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
	.global	shipMapLeft
	.global	shipMapLeft
	.align	2
	.type	shipMapLeft, %object
	.size	shipMapLeft, 4
shipMapLeft:
	.space	4
	.global	shipMapRight
	.data
	.align	2
	.type	shipMapRight, %object
	.size	shipMapRight, 4
shipMapRight:
	.word	255
	.global	shipScreenLeft
	.bss
	.global	shipScreenLeft
	.align	2
	.type	shipScreenLeft, %object
	.size	shipScreenLeft, 4
shipScreenLeft:
	.space	4
	.global	shipScreenRight
	.data
	.align	2
	.type	shipScreenRight, %object
	.size	shipScreenRight, 4
shipScreenRight:
	.word	239
	.global	shipNextColumn
	.bss
	.global	shipNextColumn
	.align	2
	.type	shipNextColumn, %object
	.size	shipNextColumn, 4
shipNextColumn:
	.space	4
	.global	shipPrevColumn
	.global	shipPrevColumn
	.align	2
	.type	shipPrevColumn, %object
	.size	shipPrevColumn, 4
shipPrevColumn:
	.space	4
	.global	shipMapTop
	.global	shipMapTop
	.align	2
	.type	shipMapTop, %object
	.size	shipMapTop, 4
shipMapTop:
	.space	4
	.global	shipMapBottom
	.data
	.align	2
	.type	shipMapBottom, %object
	.size	shipMapBottom, 4
shipMapBottom:
	.word	255
	.global	shipScreenTop
	.bss
	.global	shipScreenTop
	.align	2
	.type	shipScreenTop, %object
	.size	shipScreenTop, 4
shipScreenTop:
	.space	4
	.global	shipScreenBottom
	.data
	.align	2
	.type	shipScreenBottom, %object
	.size	shipScreenBottom, 4
shipScreenBottom:
	.word	159
	.global	shipNextRow
	.bss
	.global	shipNextRow
	.align	2
	.type	shipNextRow, %object
	.size	shipNextRow, 4
shipNextRow:
	.space	4
	.global	shipPrevRow
	.global	shipPrevRow
	.align	2
	.type	shipPrevRow, %object
	.size	shipPrevRow, 4
shipPrevRow:
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
	.global	tookStep
	.global	tookStep
	.align	2
	.type	tookStep, %object
	.size	tookStep, 4
tookStep:
	.space	4
	.global	gameOver
	.global	gameOver
	.align	2
	.type	gameOver, %object
	.size	gameOver, 4
gameOver:
	.space	4
	.global	timeLeft
	.data
	.align	2
	.type	timeLeft, %object
	.size	timeLeft, 4
timeLeft:
	.word	10
	.text
	.align	2
	.global	ShipInitialize
	.type	ShipInitialize, %function
ShipInitialize:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	ldr	r3, .L289
	mov	ip, sp
	mov	r0, #239
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
	str	r0, [r3, #0]	@  shipScreenRight
	ldr	r3, .L289+4
	ldr	r2, .L289+8
	mov	r0, #159
	mov	lr, #255
	str	r0, [r3, #0]	@  shipScreenBottom
	sub	fp, ip, #4
	mov	r3, #67108864
	mov	ip, #4416
	str	lr, [r2, #0]	@  shipMapBottom
	str	ip, [r3, #0]
	ldr	r2, .L289+12
	ldr	r3, .L289+16
	mov	r1, #0	@  n
	str	r1, [r2, #0]	@  n,  shipMapLeft
	str	lr, [r3, #0]	@  shipMapRight
	ldr	r2, .L289+20
	ldr	r3, .L289+24
	str	r1, [r2, #0]	@  n,  shipScreenLeft
	str	r1, [r3, #0]	@  n,  shipNextColumn
	ldr	r2, .L289+28
	ldr	r3, .L289+32
	str	r1, [r2, #0]	@  n,  shipPrevColumn
	str	r1, [r3, #0]	@  n,  shipMapTop
	ldr	r2, .L289+36
	ldr	r3, .L289+40
	str	r1, [r2, #0]	@  n,  shipScreenTop
	str	r1, [r3, #0]	@  n,  shipNextRow
	ldr	r2, .L289+44
	ldr	r3, .L289+48
	str	r1, [r2, #0]	@  n,  shipPrevRow
	str	r1, [r3, #0]	@  n,  regX
	ldr	r2, .L289+52
	ldr	r3, .L289+56
	str	r1, [r2, #0]	@  n,  regY
	str	r1, [r3, #0]	@  n,  tookStep
	mov	r2, #83886080
	ldr	r0, .L289+60
	mov	r5, r1	@  n,  n
	add	r2, r2, #512
.L118:
	mov	r3, r5, asl #1	@  n
	ldrh	r1, [r3, r0]	@ movhi	@  philPalette
	add	r5, r5, #1	@  n,  n
	cmp	r5, #255	@  n
	strh	r1, [r3, r2]	@ movhi 
	ble	.L118
	mov	r1, #508
	mov	r2, #100663296
	ldr	r0, .L289+64
	mov	r5, #0	@  n
	add	r1, r1, #3
	add	r2, r2, #65536
.L123:
	mov	r3, r5, asl #1	@  n
	ldrh	ip, [r3, r0]	@ movhi	@  philData
	add	r5, r5, #1	@  n,  n
	cmp	r5, r1	@  n
	strh	ip, [r3, r2]	@ movhi 
	ble	.L123
	mov	r5, #512	@  n
	mov	r0, #100663296
	ldr	ip, .L289+68
	add	r1, r5, r5	@  n
	add	r0, r0, #65536
	mov	r2, #0
.L128:
	mov	r3, r5, asl #1	@  n
	ldrh	lr, [r2, ip]	@ movhi	@  philFacingRightData
	add	r5, r5, #1	@  n,  n
	cmp	r5, r1	@  n
	strh	lr, [r3, r0]	@ movhi 
	add	r2, r2, #2
	blt	.L128
	add	r3, r5, #512	@  n
	mov	r0, #100663296
	ldr	ip, .L289+72
	mov	r1, r3
	add	r0, r0, #65536
	mov	r2, #0
.L133:
	mov	r3, r5, asl #1	@  n
	ldrh	lr, [r2, ip]	@ movhi	@  philFacingRight2Data
	add	r5, r5, #1	@  n,  n
	cmp	r5, r1	@  n
	strh	lr, [r3, r0]	@ movhi 
	add	r2, r2, #2
	blt	.L133
	add	r3, r5, #512	@  n
	mov	r0, #100663296
	ldr	ip, .L289+76
	mov	r1, r3
	add	r0, r0, #65536
	mov	r2, #0
.L138:
	mov	r3, r5, asl #1	@  n
	ldrh	lr, [r2, ip]	@ movhi	@  philFacingRight3Data
	add	r5, r5, #1	@  n,  n
	cmp	r5, r1	@  n
	strh	lr, [r3, r0]	@ movhi 
	add	r2, r2, #2
	blt	.L138
	add	r3, r5, #512	@  n
	mov	r0, #100663296
	ldr	ip, .L289+80
	mov	r1, r3
	add	r0, r0, #65536
	mov	r2, #0
.L143:
	mov	r3, r5, asl #1	@  n
	ldrh	lr, [r2, ip]	@ movhi	@  philJumpingData
	add	r5, r5, #1	@  n,  n
	cmp	r5, r1	@  n
	strh	lr, [r3, r0]	@ movhi 
	add	r2, r2, #2
	blt	.L143
	add	r3, r5, #512	@  n
	mov	r0, #100663296
	ldr	ip, .L289+84
	mov	r1, r3
	add	r0, r0, #65536
	mov	r2, #0
.L148:
	mov	r3, r5, asl #1	@  n
	ldrh	lr, [r2, ip]	@ movhi	@  enemyData
	add	r5, r5, #1	@  n,  n
	cmp	r5, r1	@  n
	strh	lr, [r3, r0]	@ movhi 
	add	r2, r2, #2
	blt	.L148
	add	r3, r5, #32	@  n
	mov	r0, #100663296
	ldr	ip, .L289+88
	mov	r1, r3
	add	r0, r0, #65536
	mov	r2, #0
.L153:
	mov	r3, r5, asl #1	@  n
	ldrh	lr, [r2, ip]	@ movhi	@  laserPurpleData
	add	r5, r5, #1	@  n,  n
	cmp	r5, r1	@  n
	strh	lr, [r3, r0]	@ movhi 
	add	r2, r2, #2
	blt	.L153
	add	r3, r5, #32	@  n
	mov	r0, #100663296
	ldr	ip, .L289+92
	mov	r1, r3
	add	r0, r0, #65536
	mov	r2, #0
.L158:
	mov	r3, r5, asl #1	@  n
	ldrh	lr, [r2, ip]	@ movhi	@  laserData
	add	r5, r5, #1	@  n,  n
	cmp	r5, r1	@  n
	strh	lr, [r3, r0]	@ movhi 
	add	r2, r2, #2
	blt	.L158
	add	r3, r5, #32	@  n
	mov	r0, #100663296
	ldr	ip, .L289+96
	mov	r1, r3
	add	r0, r0, #65536
	mov	r2, #0
.L163:
	mov	r3, r5, asl #1	@  n
	ldrh	lr, [r2, ip]	@ movhi	@  hud0Data
	add	r5, r5, #1	@  n,  n
	cmp	r5, r1	@  n
	strh	lr, [r3, r0]	@ movhi 
	add	r2, r2, #2
	blt	.L163
	add	r3, r5, #32	@  n
	mov	r0, #100663296
	ldr	ip, .L289+100
	mov	r1, r3
	add	r0, r0, #65536
	mov	r2, #0
.L168:
	mov	r3, r5, asl #1	@  n
	ldrh	lr, [r2, ip]	@ movhi	@  hud1Data
	add	r5, r5, #1	@  n,  n
	cmp	r5, r1	@  n
	strh	lr, [r3, r0]	@ movhi 
	add	r2, r2, #2
	blt	.L168
	add	r3, r5, #32	@  n
	mov	r0, #100663296
	ldr	ip, .L289+104
	mov	r1, r3
	add	r0, r0, #65536
	mov	r2, #0
.L173:
	mov	r3, r5, asl #1	@  n
	ldrh	lr, [r2, ip]	@ movhi	@  hud2Data
	add	r5, r5, #1	@  n,  n
	cmp	r5, r1	@  n
	strh	lr, [r3, r0]	@ movhi 
	add	r2, r2, #2
	blt	.L173
	add	r3, r5, #32	@  n
	mov	r0, #100663296
	ldr	ip, .L289+108
	mov	r1, r3
	add	r0, r0, #65536
	mov	r2, #0
.L178:
	mov	r3, r5, asl #1	@  n
	ldrh	lr, [r2, ip]	@ movhi	@  hud3Data
	add	r5, r5, #1	@  n,  n
	cmp	r5, r1	@  n
	strh	lr, [r3, r0]	@ movhi 
	add	r2, r2, #2
	blt	.L178
	add	r3, r5, #32	@  n
	mov	r0, #100663296
	ldr	ip, .L289+112
	mov	r1, r3
	add	r0, r0, #65536
	mov	r2, #0
.L183:
	mov	r3, r5, asl #1	@  n
	ldrh	lr, [r2, ip]	@ movhi	@  hud4Data
	add	r5, r5, #1	@  n,  n
	cmp	r5, r1	@  n
	strh	lr, [r3, r0]	@ movhi 
	add	r2, r2, #2
	blt	.L183
	add	r3, r5, #32	@  n
	mov	r0, #100663296
	ldr	ip, .L289+116
	mov	r1, r3
	add	r0, r0, #65536
	mov	r2, #0
.L188:
	mov	r3, r5, asl #1	@  n
	ldrh	lr, [r2, ip]	@ movhi	@  hud5Data
	add	r5, r5, #1	@  n,  n
	cmp	r5, r1	@  n
	strh	lr, [r3, r0]	@ movhi 
	add	r2, r2, #2
	blt	.L188
	add	r3, r5, #32	@  n
	mov	r0, #100663296
	ldr	ip, .L289+120
	mov	r1, r3
	add	r0, r0, #65536
	mov	r2, #0
.L193:
	mov	r3, r5, asl #1	@  n
	ldrh	lr, [r2, ip]	@ movhi	@  hud6Data
	add	r5, r5, #1	@  n,  n
	cmp	r5, r1	@  n
	strh	lr, [r3, r0]	@ movhi 
	add	r2, r2, #2
	blt	.L193
	add	r3, r5, #32	@  n
	mov	r0, #100663296
	ldr	ip, .L289+124
	mov	r1, r3
	add	r0, r0, #65536
	mov	r2, #0
.L198:
	mov	r3, r5, asl #1	@  n
	ldrh	lr, [r2, ip]	@ movhi	@  hud7Data
	add	r5, r5, #1	@  n,  n
	cmp	r5, r1	@  n
	strh	lr, [r3, r0]	@ movhi 
	add	r2, r2, #2
	blt	.L198
	add	r3, r5, #32	@  n
	mov	r0, #100663296
	ldr	ip, .L289+128
	mov	r1, r3
	add	r0, r0, #65536
	mov	r2, #0
.L203:
	mov	r3, r5, asl #1	@  n
	ldrh	lr, [r2, ip]	@ movhi	@  hud8Data
	add	r5, r5, #1	@  n,  n
	cmp	r5, r1	@  n
	strh	lr, [r3, r0]	@ movhi 
	add	r2, r2, #2
	blt	.L203
	add	r3, r5, #32	@  n
	mov	r0, #100663296
	ldr	ip, .L289+132
	mov	r1, r3
	add	r0, r0, #65536
	mov	r2, #0
.L208:
	mov	r3, r5, asl #1	@  n
	ldrh	lr, [r2, ip]	@ movhi	@  hud9Data
	add	r5, r5, #1	@  n,  n
	cmp	r5, r1	@  n
	strh	lr, [r3, r0]	@ movhi 
	add	r2, r2, #2
	blt	.L208
	add	r3, r5, #32	@  n
	mov	r0, #100663296
	ldr	ip, .L289+136
	mov	r1, r3
	add	r0, r0, #65536
	mov	r2, #0
.L213:
	mov	r3, r5, asl #1	@  n
	ldrh	lr, [r2, ip]	@ movhi	@  hudPercentData
	add	r5, r5, #1	@  n,  n
	cmp	r5, r1	@  n
	strh	lr, [r3, r0]	@ movhi 
	add	r2, r2, #2
	blt	.L213
	add	r3, r5, #128	@  n
	mov	r0, #100663296
	ldr	ip, .L289+140
	mov	r1, r3
	add	r0, r0, #65536
	mov	r2, #0
.L218:
	mov	r3, r5, asl #1	@  n
	ldrh	lr, [r2, ip]	@ movhi	@  hudLifeData
	add	r5, r5, #1	@  n,  n
	cmp	r5, r1	@  n
	strh	lr, [r3, r0]	@ movhi 
	add	r2, r2, #2
	blt	.L218
	add	r3, r5, #512	@  n
	mov	r0, #100663296
	ldr	ip, .L289+144
	mov	r1, r3
	add	r0, r0, #65536
	mov	r2, #0
.L223:
	mov	r3, r5, asl #1	@  n
	ldrh	lr, [r2, ip]	@ movhi	@  continueData
	add	r5, r5, #1	@  n,  n
	cmp	r5, r1	@  n
	strh	lr, [r3, r0]	@ movhi 
	add	r2, r2, #2
	blt	.L223
	ldr	r9, .L289+148	@  loc
	ldr	r6, .L289+152
	mov	r4, r9	@  loc,  loc
	mov	r5, #127	@  n
.L228:
	mov	r0, r4	@  loc
	mov	lr, pc
	bx	r6
	subs	r5, r5, #1	@  n,  n
	add	r4, r4, #144	@  loc,  loc
	bpl	.L228
	ldr	ip, .L289+156
	mov	r5, #0	@  i
	mov	sl, #8
	mov	r3, #7
	mov	r1, #32
	stmia	ip, {r3, r5, sl}	@ phole stm
	str	r1, [ip, #12]	@  characterStandingRightBBox.ysize
	ldr	r8, .L289+160
	ldmia	ip, {r0, r1, r2, r3}
	ldr	r4, .L289+164
	mov	lr, #96
	mov	ip, #32768
	str	ip, [r9, #8]	@  <variable>.size
	str	lr, [r9, #4]	@  <variable>.y
	str	lr, [r9, #48]	@  <variable>.mapY
	str	r3, [r9, #68]	@  <variable>.location
	str	r5, [r9, #0]	@  i,  <variable>.x
	str	r5, [r9, #44]	@  i,  <variable>.mapX
	str	r5, [r9, #12]	@  i,  <variable>.shape
	mov	ip, r3
	stmia	r8, {r0, r1, r2, r3}
	ldr	r6, .L289+168
	mov	r3, #2
	ldr	r7, .L289+172
	str	r3, [r4, #0]	@  characterWalkingRightBBox.x
	mov	r3, #18
	str	r3, [r6, #0]	@  characterWalkingLeftBBox.x
	mov	r1, lr
	mov	r2, #16
	ldr	lr, .L289+176
	mov	r3, #14
	str	r2, [r6, #8]	@  characterWalkingLeftBBox.xsize
	str	r3, [r7, #0]	@  characterStandingLeftBBox.x
	str	r2, [r4, #8]	@  characterWalkingRightBBox.xsize
	mov	r3, #10
	mov	r2, #1
	str	ip, [r4, #12]	@  characterWalkingRightBBox.ysize
	str	ip, [r6, #12]	@  characterWalkingLeftBBox.ysize
	str	ip, [r7, #12]	@  characterStandingLeftBBox.ysize
	str	r5, [lr, #0]	@  i,  characterSpriteIndex
	str	sl, [r7, #8]	@  characterStandingLeftBBox.xsize
	str	r5, [r4, #4]	@  i,  characterWalkingRightBBox.y
	str	r5, [r6, #4]	@  i,  characterWalkingLeftBBox.y
	str	r5, [r7, #4]	@  i,  characterStandingLeftBBox.y
	mov	r0, #260
	str	r5, [r9, #72]	@  i,  <variable>.noGravity
	str	r5, [r9, #76]	@  i,  <variable>.isProjectile
	str	r3, [r9, #52]	@  <variable>.hits
	str	r2, [r9, #88]	@  <variable>.speed
	str	r2, [r9, #124]	@  <variable>.dir
	ldr	r3, .L289+180
	str	r5, [r9, #92]	@  i,  <variable>.isRemoved
	mov	lr, pc
	bx	r3
	ldr	r3, .L289+184
	mov	ip, r0	@  loc
	mov	r6, #128	@  n
	mov	r1, r6	@  n
	str	ip, [r3, #0]	@  loc,  enemySpriteIndex
	mov	r2, r5	@  i
	sub	r0, r8, #128
	bl	GetNextFreePosition
	add	r3, r0, r0, asl #3	@  loc,  loc
	mov	r3, r3, asl #4
	mov	ip, #4
	add	r4, r3, r9	@  loc
	str	ip, [r3, r9]	@  <variable>.x
	mov	r3, #16384
	mov	lr, #140
	str	r3, [r4, #12]	@  <variable>.shape
	mov	ip, #218
	mov	r3, #1
	mov	r1, r6	@  n
	str	lr, [r4, #4]	@  <variable>.y
	str	ip, [r4, #68]	@  <variable>.location
	str	r3, [r4, #72]	@  <variable>.noGravity
	mov	r2, r5	@  i
	str	r5, [r4, #92]	@  i,  <variable>.isRemoved
	str	r5, [r4, #8]	@  i,  <variable>.size
	str	r5, [r4, #76]	@  i,  <variable>.isProjectile
	sub	r0, r8, #128
	bl	GetNextFreePosition
	ldr	lr, .L289+176
	ldr	r3, [lr, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #3
	add	r3, r9, r3, asl #4	@  loc
	mov	ip, r0	@  loc
	ldr	r2, .L289+188
	ldr	r0, [r3, #52]	@  loc,  <variable>.hits
	ldr	r3, .L289+192
	add	r1, ip, #1	@  loc
	str	ip, [r2, #0]	@  loc,  leftHealthIndex
	str	r1, [r3, #0]	@  rightHealthIndex
	ldr	r3, .L289+196
	mov	lr, pc
	bx	r3
	bl	WaitVBlank
	mov	r1, r6	@  n
	sub	r0, r8, #128
	bl	UpdateSpriteMemory
	ldr	r3, .L289+200
	mov	ip, #100663296
	ldr	r6, .L289+204
	ldr	r7, .L289+208
	mov	r4, ip
	ldr	r0, [r3, #0]	@  loc,  mapPalette
	add	ip, ip, #63488
	mov	r3, #67108864
	mov	r1, #8064	@ movhi
	mov	r2, #7296	@ movhi
	add	r4, r4, #57344
	str	ip, [r6, #0]	@  bg0map
	strh	r1, [r3, #8]	@ movhi 
	str	r4, [r7, #0]	@  bg1map
	strh	r2, [r3, #10]	@ movhi 
	mov	r1, #83886080
	mov	r2, #256
	mov	r3, #-2147483648
	bl	DMAFastCopy
	ldr	r3, .L289+212
	mov	r1, #100663296
	ldr	r0, [r3, #0]	@  loc,  mapTiles
	mov	r2, #1248
	mov	r3, #-2080374784
	bl	DMAFastCopy
	ldr	r3, .L289+216
	mov	r1, #100663296
	ldr	r0, [r3, #0]	@  loc,  hitMapTiles
	mov	r2, #32
	mov	r3, #-2080374784
	add	r1, r1, #32768
	bl	DMAFastCopy
	ldr	r3, .L289+220
	ldr	ip, [r3, #0]	@  map
	ldr	r3, .L289+224
	ldr	r6, [r6, #0]	@  bg0map
	ldr	r7, [r7, #0]	@  bg1map
	ldr	r0, [r3, #0]	@  hitMap
.L238:
	add	r3, r5, r5, asl #2	@  i,  i
	add	r3, r3, r3, asl #2
	mov	r3, r3, asl #3
	mov	r2, r5, asl #6	@  i
	mov	r1, #31	@  j
.L237:
	ldrh	lr, [r3, ip]	@ movhi
	strh	lr, [r2, r6]	@ movhi 
	ldrh	lr, [r3, r0]	@ movhi
	subs	r1, r1, #1	@  j,  j
	strh	lr, [r2, r7]	@ movhi 
	add	r3, r3, #2
	add	r2, r2, #2
	bpl	.L237
	add	r5, r5, #1	@  i,  i
	cmp	r5, #31	@  i
	ble	.L238
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
.L290:
	.align	2
.L289:
	.word	shipScreenRight
	.word	shipScreenBottom
	.word	shipMapBottom
	.word	shipMapLeft
	.word	shipMapRight
	.word	shipScreenLeft
	.word	shipNextColumn
	.word	shipPrevColumn
	.word	shipMapTop
	.word	shipScreenTop
	.word	shipNextRow
	.word	shipPrevRow
	.word	regX
	.word	regY
	.word	tookStep
	.word	philPalette
	.word	philData
	.word	philFacingRightData
	.word	philFacingRight2Data
	.word	philFacingRight3Data
	.word	philJumpingData
	.word	enemyData
	.word	laserPurpleData
	.word	laserData
	.word	hud0Data
	.word	hud1Data
	.word	hud2Data
	.word	hud3Data
	.word	hud4Data
	.word	hud5Data
	.word	hud6Data
	.word	hud7Data
	.word	hud8Data
	.word	hud9Data
	.word	hudPercentData
	.word	hudLifeData
	.word	continueData
	.word	sprites
	.word	RemoveSprite
	.word	characterStandingRightBBox
	.word	sprites+128
	.word	characterWalkingRightBBox
	.word	characterWalkingLeftBBox
	.word	characterStandingLeftBBox
	.word	characterSpriteIndex
	.word	SpawnEnemy
	.word	enemySpriteIndex
	.word	leftHealthIndex
	.word	rightHealthIndex
	.word	ChangePlayerHealth
	.word	mapPalette
	.word	bg0map
	.word	bg1map
	.word	mapTiles
	.word	hitMapTiles
	.word	map
	.word	hitMap
	.size	ShipInitialize, .-ShipInitialize
	.align	2
	.global	ShipUpdate
	.type	ShipUpdate, %function
ShipUpdate:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 144
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #416
	bl	keyPoll
	mov	r0, #64
	bl	keyHit
	cmp	r0, #0
	beq	.L292
	ldr	r2, .L390
	ldr	r0, [r2, #0]	@  isJumping
	cmp	r0, #0
	bne	.L292
	ldr	r4, .L390+4
	ldr	r3, [r4, #0]	@  characterSpriteIndex
	ldr	r2, .L390+8
	add	r3, r3, r3, asl #3
	add	r3, r2, r3, asl #4
	mov	r2, #128
	str	r2, [r3, #68]	@  <variable>.location
	ldr	r2, .L390
	mov	r3, #1
	ldr	r1, .L390+12
	str	r3, [r2, #0]	@  isJumping
	ldr	r2, .L390+16
	str	r0, [r1, #0]	@  walkingCounter
	str	r0, [r2, #0]	@  jumpDuration
.L292:
	ldr	r0, .L390
	ldr	r3, [r0, #0]	@  isJumping
	cmp	r3, #0
	beq	.L293
	ldr	r5, .L390+16
	ldr	r3, [r5, #0]	@  jumpDuration
	cmp	r3, #19
	ble	.L375
.L293:
	ldr	r3, .L390+20
	mov	lr, pc
	bx	r3
.L294:
	mov	r0, #16
	bl	keyHeld
	cmp	r0, #0
	beq	.L295
	ldr	r0, .L390
	ldr	r3, [r0, #0]	@  isJumping
	cmp	r3, #0
	bne	.L363
	ldr	r3, .L390+12
	ldr	r2, .L390+24
	ldr	r1, [r3, #0]	@  walkingCounter
	smull	r3, r0, r2, r1
	mov	r3, r1, asr #31
	rsb	r3, r3, r0, asr #4
	add	r3, r3, r3, asl #2
	sub	r1, r1, r3, asl #3
	cmp	r1, #10
	beq	.L376
	cmp	r1, #20
	beq	.L377
	cmp	r1, #30
	beq	.L378
	cmp	r1, #0
	bne	.L363
	ldr	r4, .L390+4
	ldr	ip, [r4, #0]	@  characterSpriteIndex
	ldr	r0, .L390+8
	add	ip, ip, ip, asl #3
	add	ip, r0, ip, asl #4
.L372:
	mov	r3, #32
	str	r3, [ip, #68]	@  <variable>.location
	ldr	lr, .L390+28
.L367:
	ldmia	lr, {r0, r1, r2, r3}
	add	ip, ip, #128
	stmia	ip, {r0, r1, r2, r3}
.L296:
	ldr	r1, .L390+32
	ldr	r3, [r4, #0]	@  characterSpriteIndex
	ldr	r2, [r1, #0]	@  tookStep
	add	r3, r3, r3, asl #3
	cmp	r2, #0
	ldr	r2, .L390+8
	mov	r3, r3, asl #4
	add	r5, r3, r2
	mov	r6, #1
	mov	r2, #0
	str	r2, [r5, #60]	@  <variable>.hFlip
	str	r6, [r5, #124]	@  <variable>.dir
	ldr	r7, .L390+8
	ldr	sl, .L390+4
	strne	r2, [r1, #0]	@  tookStep
	bne	.L295
	ldr	r3, [r3, r7]	@  <variable>.x
	cmp	r3, #119
	str	r6, [r1, #0]	@  tookStep
	ble	.L306
	ldr	r3, .L390+36
	mov	r2, #796
	ldr	r1, [r3, #0]	@  shipScreenRight
	add	r2, r2, #2
	cmp	r1, r2
	ble	.L305
.L306:
	ldr	r3, .L390+40
	ldr	r1, [r3, #0]	@  enemySpriteIndex
	add	r1, r1, r1, asl #3
	add	r1, r7, r1, asl #4	@  dir
	mov	r2, #144
	ldr	r8, .L390+44
	add	r0, sp, #128
	mov	lr, pc
	bx	r8
	add	r1, r5, #16	@  dir
	mov	r2, #128
	mov	r0, sp
	mov	lr, pc
	bx	r8
	ldmia	r5, {r0, r1, r2, r3}
	ldr	ip, .L390+48
	mov	lr, pc
	bx	ip
	cmp	r0, #0
	beq	.L379
.L295:
	mov	r0, #32
	bl	keyHeld
	cmp	r0, #0
	beq	.L314
	ldr	r0, .L390
	ldr	r3, [r0, #0]	@  isJumping
	cmp	r3, #0
	bne	.L365
	ldr	r3, .L390+12
	ldr	r2, .L390+24
	ldr	r1, [r3, #0]	@  walkingCounter
	smull	r3, r0, r2, r1
	mov	r3, r1, asr #31
	rsb	r3, r3, r0, asr #4
	add	r3, r3, r3, asl #2
	sub	r1, r1, r3, asl #3
	cmp	r1, #10
	beq	.L380
	cmp	r1, #20
	beq	.L381
	cmp	r1, #30
	beq	.L382
	cmp	r1, #0
	bne	.L365
	ldr	r4, .L390+4
	ldr	ip, [r4, #0]	@  characterSpriteIndex
	ldr	r0, .L390+8
	add	ip, ip, ip, asl #3
	add	ip, r0, ip, asl #4
.L374:
	mov	r3, #32
	str	r3, [ip, #68]	@  <variable>.location
	ldr	lr, .L390+52
.L368:
	ldmia	lr, {r0, r1, r2, r3}
	add	ip, ip, #128
	stmia	ip, {r0, r1, r2, r3}
.L315:
	ldr	r1, .L390+32
	ldr	r3, [r4, #0]	@  characterSpriteIndex
	ldr	r2, [r1, #0]	@  tookStep
	add	r3, r3, r3, asl #3
	cmp	r2, #0
	ldr	r2, .L390+8
	mov	r3, r3, asl #4
	add	r5, r3, r2
	mov	r6, #0
	mov	r2, #1
	str	r2, [r5, #60]	@  <variable>.hFlip
	str	r6, [r5, #124]	@  <variable>.dir
	ldr	r7, .L390+8
	ldr	sl, .L390+4
	strne	r6, [r1, #0]	@  tookStep
	bne	.L314
	ldr	r3, [r3, r7]	@  <variable>.x
	cmp	r3, #120
	str	r2, [r1, #0]	@  tookStep
	bgt	.L325
	ldr	r3, .L390+56
	ldr	r2, [r3, #0]	@  shipScreenLeft
	cmp	r2, r6
	bne	.L324
.L325:
	ldr	r3, .L390+40
	ldr	r1, [r3, #0]	@  enemySpriteIndex
	add	r1, r1, r1, asl #3
	add	r1, r7, r1, asl #4	@  dir
	mov	r2, #144
	ldr	r8, .L390+44
	add	r0, sp, #128
	mov	lr, pc
	bx	r8
	add	r1, r5, #16	@  dir
	mov	r2, #128
	mov	r0, sp
	mov	lr, pc
	bx	r8
	ldmia	r5, {r0, r1, r2, r3}
	ldr	ip, .L390+48
	mov	lr, pc
	bx	ip
	cmp	r0, #0
	beq	.L383
.L314:
	mov	r0, #1
	bl	keyHit
	cmp	r0, #0
	bne	.L384
.L332:
	ldr	r0, .L390+60
	mov	lr, pc
	bx	r0
	ldr	r2, .L390+64
	smull	r3, r1, r2, r0
	mov	r3, r0, asr #31
	rsb	r3, r3, r1, asr #4
	add	r3, r3, r3, asl #2
	add	r3, r3, r3, asl #2
	cmp	r0, r3, asl #1
	beq	.L385
.L336:
	ldr	r9, .L390+68
	ldr	r5, .L390+8
	mov	r6, #0	@  i
.L346:
	ldr	r3, [r5, #76]	@  <variable>.isProjectile
	cmp	r3, #0
	beq	.L339
	ldr	r3, [r5, #92]	@  <variable>.isRemoved
	cmp	r3, #0
	add	r1, r5, #8	@  dir
	ldr	r7, .L390+44
	mov	r0, sp
	mov	r2, #136
	beq	.L386
.L339:
	add	r6, r6, #1	@  i,  i
	cmp	r6, #127	@  i
	add	r5, r5, #144
	ble	.L346
	mov	r0, #32
	bl	keyHeld
	cmp	r0, #0
	bne	.L347
	mov	r0, #16
	bl	keyHeld
	cmp	r0, #0
	bne	.L347
	ldr	r0, .L390
	ldr	r3, [r0, #0]	@  isJumping
	cmp	r3, #0
	bne	.L347
	ldr	r3, .L390+4
	ldr	r2, [r3, #0]	@  characterSpriteIndex
	ldr	r3, .L390+8
	add	r2, r2, r2, asl #3
	add	lr, r3, r2, asl #4
	ldr	r2, [lr, #124]	@  <variable>.dir
	mov	r3, #32
	cmp	r2, #1
	str	r3, [lr, #68]	@  <variable>.location
	ldreq	ip, .L390+28
	beq	.L370
	cmp	r2, #0
	bne	.L347
	ldr	ip, .L390+52
.L370:
	ldmia	ip, {r0, r1, r2, r3}
	add	lr, lr, #128
	stmia	lr, {r0, r1, r2, r3}
.L347:
	bl	WaitVBlank
	ldr	r0, .L390+8
	mov	r1, #128
	bl	UpdateSpriteMemory
	ldr	r3, .L390+72
	ldr	r2, .L390+76
	ldrh	r0, [r3, #0]	@  regY
	ldrh	r1, [r2, #0]	@  regX
	mov	r3, #67108864
	strh	r0, [r3, #18]	@ movhi 
	strh	r1, [r3, #16]	@ movhi 
	mov	r3, #29952	@  n
	add	r3, r3, #48	@  n,  n
.L355:
	subs	r3, r3, #1	@  n,  n
	bne	.L355
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
.L386:
	ldr	r4, [r5, #124]	@  dir,  <variable>.dir
	mov	lr, pc
	bx	r7
	ldmia	r5, {r2, r3}
	mov	r0, r5
	mov	r1, r4	@  dir
	ldr	ip, .L390+80
	mov	lr, pc
	bx	ip
	ldr	r3, [r5, #84]	@  <variable>.isEnemy
	cmp	r3, #0
	ldr	r8, .L390+4
	ldr	sl, .L390+40
	add	r0, sp, #128
	mov	r2, #144
	beq	.L387
.L366:
	ldr	r1, [r8, #0]	@  characterSpriteIndex
	ldr	r3, .L390+8
	add	r1, r1, r1, asl #3
	add	r1, r3, r1, asl #4	@  dir
	mov	r2, #144
	add	r0, sp, #128
	mov	lr, pc
	bx	r7
	add	r1, r5, #16	@  dir
	mov	r2, #128
	mov	r0, sp
	mov	lr, pc
	bx	r7
	ldmia	r5, {r0, r1, r2, r3}
	ldr	ip, .L390+48
	mov	lr, pc
	bx	ip
	mov	r3, r0
	cmp	r3, #0
	mov	r0, r5
	beq	.L339
	mov	lr, pc
	bx	r9
	ldr	r3, [r8, #0]	@  characterSpriteIndex
	ldr	r0, .L390+8
	add	r3, r3, r3, asl #3
	add	r3, r0, r3, asl #4
	ldr	r0, [r3, #52]	@  <variable>.hits
	sub	r0, r0, #1
	str	r0, [r3, #52]	@  <variable>.hits
	ldr	r2, .L390+84
	mov	lr, pc
	bx	r2
	ldr	r3, [r8, #0]	@  characterSpriteIndex
	ldr	r2, .L390+8
	add	r3, r3, r3, asl #3
	add	r3, r2, r3, asl #4
	ldr	r2, [r3, #52]	@  <variable>.hits
	cmp	r2, #0
	bne	.L339
	ldr	r3, .L390+88
	mov	lr, pc
	bx	r3
	b	.L339
.L387:
	ldr	r1, [sl, #0]	@  enemySpriteIndex
	ldr	r3, .L390+8
	add	r1, r1, r1, asl #3
	add	r1, r3, r1, asl #4	@  dir
	mov	lr, pc
	bx	r7
	add	r1, r5, #16	@  dir
	mov	r2, #128
	mov	r0, sp
	mov	lr, pc
	bx	r7
	ldmia	r5, {r0, r1, r2, r3}
	ldr	ip, .L390+48
	mov	lr, pc
	bx	ip
	mov	r3, r0
	cmp	r3, #0
	mov	r0, r5
	bne	.L388
	ldr	r3, [r5, #84]	@  <variable>.isEnemy
	cmp	r3, #0
	beq	.L339
	b	.L366
.L388:
	mov	lr, pc
	bx	r9
	ldr	r0, [sl, #0]	@  enemySpriteIndex
	ldr	r2, .L390+8
	add	r0, r0, r0, asl #3
	add	r0, r2, r0, asl #4
	mov	lr, pc
	bx	r9
	b	.L339
.L385:
	ldr	r3, .L390+40
	ldr	r1, [r3, #0]	@  enemySpriteIndex
	ldr	r0, .L390+8
	add	r1, r1, r1, asl #3
	add	r1, r0, r1, asl #4	@  dir
	mov	r2, #144
	ldr	r3, .L390+44
	sub	r0, fp, #184
	mov	lr, pc
	bx	r3
	ldr	ip, [fp, #-60]	@  enemy.dir
	ldr	r1, [fp, #-180]	@  enemy.y
	ldr	r3, [fp, #-136]	@  enemy.mapY
	str	ip, [sp, #0]
	mov	lr, #194
	mov	ip, #1
	add	r1, r1, #12	@  dir
	add	r3, r3, #12
	ldr	r0, [fp, #-184]	@  enemy.x
	ldr	r2, [fp, #-140]	@  enemy.mapX
	str	lr, [sp, #4]
	str	ip, [sp, #8]
	ldr	r4, .L390+92
	mov	lr, pc
	bx	r4
	b	.L336
.L384:
	ldr	r3, .L390+4
	ldr	r1, [r3, #0]	@  characterSpriteIndex
	ldr	r3, .L390+8
	add	r1, r1, r1, asl #3
	add	r1, r3, r1, asl #4	@  dir
	sub	r0, fp, #184
	mov	r2, #144
	ldr	r3, .L390+44
	mov	lr, pc
	bx	r3
	ldr	lr, [fp, #-60]	@  character.dir
	cmp	lr, #1
	beq	.L389
	cmp	lr, #0
	bne	.L332
	sub	r0, fp, #184
	ldmia	r0, {r0, r1}	@ phole ldm
	sub	r2, fp, #140
	ldmia	r2, {r2, r3}	@ phole ldm
	mov	ip, #192
	stmib	sp, {ip, lr}	@ phole stm
	str	lr, [sp, #0]
	add	r0, r0, #2
	add	r1, r1, #7	@  dir
	add	r2, r2, #2
	add	r3, r3, #7
.L369:
	ldr	ip, .L390+92
	mov	lr, pc
	bx	ip
	b	.L332
.L389:
	sub	r0, fp, #184
	ldmia	r0, {r0, r1}	@ phole ldm
	sub	r2, fp, #140
	ldmia	r2, {r2, r3}	@ phole ldm
	str	lr, [sp, #0]
	mov	ip, #192
	mov	lr, #0
	add	r0, r0, #20
	add	r1, r1, #7	@  dir
	add	r2, r2, #20
	add	r3, r3, #7
	stmib	sp, {ip, lr}	@ phole stm
	b	.L369
.L383:
	ldr	r3, [sl, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #3
	mov	r3, r3, asl #4
	add	r4, r3, r7
	ldr	r5, [r4, #124]	@  dir,  <variable>.dir
	add	r1, r4, #8	@  dir
	mov	r2, #136
	mov	r0, sp
	ldr	r6, [r3, r7]	@  prevX,  <variable>.x
	mov	lr, pc
	bx	r8
	ldmia	r4, {r2, r3}
	mov	r0, r4
	mov	r1, r5	@  dir
	ldr	ip, .L390+80
	mov	lr, pc
	bx	ip
	ldr	r3, [sl, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #3
	ldr	r2, [r7, r3, asl #4]	@  <variable>.x
	cmp	r6, r2	@  prevX
	ldrne	r2, .L390+12
	ldrne	r3, [r2, #0]	@  walkingCounter
	addne	r3, r3, #1
	strne	r3, [r2, #0]	@  walkingCounter
	b	.L314
.L324:
	ldr	r3, .L390+40
	ldr	r1, [r3, #0]	@  enemySpriteIndex
	add	r1, r1, r1, asl #3
	add	r1, r7, r1, asl #4	@  dir
	mov	r2, #144
	ldr	r4, .L390+44
	add	r0, sp, #128
	mov	lr, pc
	bx	r4
	add	r1, r5, #16	@  dir
	mov	r2, #128
	mov	r0, sp
	mov	lr, pc
	bx	r4
	ldmia	r5, {r0, r1, r2, r3}
	ldr	ip, .L390+48
	mov	lr, pc
	bx	ip
	cmp	r0, #0
	bne	.L314
	ldr	r3, [sl, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #3
	add	r3, r7, r3, asl #4
	str	r6, [r3, #124]	@  <variable>.dir
	ldr	r2, .L390+96
	ldr	r6, [r3, #44]	@  prevX,  <variable>.mapX
	mov	lr, pc
	bx	r2
	ldr	r3, [sl, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #3
	add	r3, r7, r3, asl #4
	ldr	r0, [r3, #44]	@  <variable>.mapX
	cmp	r6, r0	@  prevX
	beq	.L314
	ldr	r1, .L390+12
	ldr	r3, [r1, #0]	@  walkingCounter
	add	r3, r3, #1
	rsb	r0, r0, r6	@  prevX
	str	r3, [r1, #0]	@  walkingCounter
	ldr	r2, .L390+100
	mov	lr, pc
	bx	r2
	b	.L314
.L365:
	ldr	r4, .L390+4
	b	.L315
.L382:
	ldr	r4, .L390+4
	ldr	ip, [r4, #0]	@  characterSpriteIndex
	ldr	r3, .L390+8
	add	ip, ip, ip, asl #3
	add	ip, r3, ip, asl #4
	mov	r3, #96
.L373:
	ldr	lr, .L390+104
	str	r3, [ip, #68]	@  <variable>.location
	b	.L368
.L381:
	ldr	r4, .L390+4
	ldr	ip, [r4, #0]	@  characterSpriteIndex
	ldr	r2, .L390+8
	add	ip, ip, ip, asl #3
	add	ip, r2, ip, asl #4
	b	.L374
.L380:
	ldr	r4, .L390+4
	ldr	ip, [r4, #0]	@  characterSpriteIndex
	ldr	r0, .L390+8
	add	ip, ip, ip, asl #3
	add	ip, r0, ip, asl #4
	mov	r3, #64
	b	.L373
.L379:
	ldr	r3, [sl, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #3
	mov	r3, r3, asl #4
	add	r4, r3, r7
	ldr	r5, [r4, #124]	@  dir,  <variable>.dir
	add	r1, r4, #8	@  dir
	mov	r2, #136
	mov	r0, sp
	ldr	r6, [r3, r7]	@  prevX,  <variable>.x
	mov	lr, pc
	bx	r8
	ldmia	r4, {r2, r3}
	mov	r1, r5	@  dir
	mov	r0, r4
	ldr	ip, .L390+80
	mov	lr, pc
	bx	ip
	ldr	r3, [sl, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #3
	mov	r1, r3, asl #4
	ldr	r2, [r1, r7]	@  <variable>.x
	cmp	r6, r2	@  prevX
	ldrne	r2, .L390+12
	ldrne	r3, [r2, #0]	@  walkingCounter
	addne	r3, r3, #1
	strne	r3, [r2, #0]	@  walkingCounter
	ldr	r3, [r1, r7]	@  <variable>.x
	cmp	r3, #200
	ble	.L295
	ldr	r3, .L390+88
	mov	lr, pc
	bx	r3
	b	.L295
.L305:
	ldr	r3, .L390+40
	ldr	r1, [r3, #0]	@  enemySpriteIndex
	add	r1, r1, r1, asl #3
	add	r1, r7, r1, asl #4	@  dir
	mov	r2, #144
	ldr	r4, .L390+44
	add	r0, sp, #128
	mov	lr, pc
	bx	r4
	add	r1, r5, #16	@  dir
	mov	r2, #128
	mov	r0, sp
	mov	lr, pc
	bx	r4
	ldmia	r5, {r0, r1, r2, r3}
	ldr	ip, .L390+48
	mov	lr, pc
	bx	ip
	cmp	r0, #0
	bne	.L295
	ldr	r3, [sl, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #3
	add	r3, r7, r3, asl #4
	str	r6, [r3, #124]	@  <variable>.dir
	ldr	r2, .L390+108
	ldr	r6, [r3, #44]	@  prevX,  <variable>.mapX
	mov	lr, pc
	bx	r2
	ldr	r3, [sl, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #3
	add	r3, r7, r3, asl #4
	ldr	r0, [r3, #44]	@  <variable>.mapX
	cmp	r6, r0	@  prevX
	beq	.L295
	ldr	r1, .L390+12
	ldr	r3, [r1, #0]	@  walkingCounter
	add	r3, r3, #1
	rsb	r0, r0, r6	@  prevX
	str	r3, [r1, #0]	@  walkingCounter
	ldr	r2, .L390+100
	mov	lr, pc
	bx	r2
	b	.L295
.L363:
	ldr	r4, .L390+4
	b	.L296
.L378:
	ldr	r4, .L390+4
	ldr	ip, [r4, #0]	@  characterSpriteIndex
	ldr	r3, .L390+8
	add	ip, ip, ip, asl #3
	add	ip, r3, ip, asl #4
	mov	r3, #96
.L371:
	ldr	lr, .L390+112
	str	r3, [ip, #68]	@  <variable>.location
	b	.L367
.L377:
	ldr	r4, .L390+4
	ldr	ip, [r4, #0]	@  characterSpriteIndex
	ldr	r2, .L390+8
	add	ip, ip, ip, asl #3
	add	ip, r2, ip, asl #4
	b	.L372
.L376:
	ldr	r4, .L390+4
	ldr	ip, [r4, #0]	@  characterSpriteIndex
	ldr	r0, .L390+8
	add	ip, ip, ip, asl #3
	add	ip, r0, ip, asl #4
	mov	r3, #64
	b	.L371
.L375:
	ldr	r4, .L390+4
	ldr	r4, [r4, #0]	@  characterSpriteIndex
	ldr	r2, .L390+8
	add	r4, r4, r4, asl #3
	add	r4, r2, r4, asl #4
	add	r1, r4, #8	@  dir
	mov	r2, #136
	ldr	r3, .L390+44
	mov	r0, sp
	mov	lr, pc
	bx	r3
	ldmia	r4, {r2, r3}
	mov	r0, r4
	mov	r1, #2
	ldr	ip, .L390+80
	mov	lr, pc
	bx	ip
	ldr	r3, [r5, #0]	@  jumpDuration
	add	r3, r3, #1
	str	r3, [r5, #0]	@  jumpDuration
	b	.L294
.L391:
	.align	2
.L390:
	.word	isJumping
	.word	characterSpriteIndex
	.word	sprites
	.word	walkingCounter
	.word	jumpDuration
	.word	Gravity
	.word	1717986919
	.word	characterStandingRightBBox
	.word	tookStep
	.word	shipScreenRight
	.word	enemySpriteIndex
	.word	memcpy
	.word	HitTest
	.word	characterStandingLeftBBox
	.word	shipScreenLeft
	.word	rand
	.word	1374389535
	.word	RemoveSprite
	.word	regY
	.word	regX
	.word	Move
	.word	ChangePlayerHealth
	.word	InitializeContinueGame
	.word	Shoot
	.word	MoveMapLeft
	.word	CounterPlayerMovement
	.word	characterWalkingLeftBBox
	.word	MoveMapRight
	.word	characterWalkingRightBBox
	.size	ShipUpdate, .-ShipUpdate
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	sub	fp, ip, #4
	bl	ShipInitialize
	ldr	r4, .L401
	ldr	r5, .L401+4
.L399:
	ldr	r3, [r4, #0]	@  gameOver
	cmp	r3, #0
	beq	.L400
	mov	lr, pc
	bx	r5
	b	.L399
.L400:
	bl	ShipUpdate
	b	.L399
.L402:
	.align	2
.L401:
	.word	gameOver
	.word	GameOverUpdate
	.size	main, .-main
	.align	2
	.global	Gravity
	.type	Gravity, %function
Gravity:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	ldr	r5, .L419
	sub	fp, ip, #4
	sub	sp, sp, #128
	mov	r6, #0	@  i
	mov	r4, r5
.L414:
	ldr	r3, [r4, #72]	@  <variable>.noGravity
	cmp	r3, #0
	bne	.L406
	ldr	r3, [r4, #92]	@  <variable>.isRemoved
	cmp	r3, #0
	add	r1, r5, #16
	mov	r2, #128
	mov	r0, sp
	beq	.L417
.L406:
	add	r6, r6, #1	@  i,  i
	cmp	r6, #127	@  i
	add	r5, r5, #144
	add	r4, r4, #144
	ble	.L414
.L405:
	ldmea	fp, {r4, r5, r6, r7, fp, sp, lr}
	bx	lr
.L417:
	ldr	r3, .L419+4
	mov	lr, pc
	bx	r3
	ldmia	r5, {r0, r1, r2, r3}
	ldr	ip, .L419+8
	mov	lr, pc
	bx	ip
	cmp	r0, #0
	beq	.L418
	ldr	r3, [r4, #4]	@  <variable>.y
	ldr	r2, [r4, #48]	@  <variable>.mapY
	add	r3, r3, #1
	add	r2, r2, #1
	str	r3, [r4, #4]	@  <variable>.y
	str	r2, [r4, #48]	@  <variable>.mapY
	b	.L406
.L418:
	ldr	r7, .L419+12
	ldr	r3, [r7, #0]	@  isJumping
	cmp	r3, #0
	beq	.L405
	ldr	r3, .L419+16
	ldr	r2, [r3, #0]	@  characterSpriteIndex
	cmp	r6, r2	@  i
	bne	.L405
	ldr	r2, [r4, #124]	@  <variable>.dir
	mov	r3, #32
	cmp	r2, #1
	str	r3, [r4, #68]	@  <variable>.location
	ldreq	ip, .L419+20
	beq	.L416
	cmp	r2, #0
	bne	.L412
	ldr	ip, .L419+24
.L416:
	ldmia	ip, {r0, r1, r2, r3}
	add	lr, r5, #128
	stmia	lr, {r0, r1, r2, r3}
.L412:
	mov	r3, #0
	str	r3, [r7, #0]	@  isJumping
	b	.L405
.L420:
	.align	2
.L419:
	.word	sprites
	.word	memcpy
	.word	CanMoveDown
	.word	isJumping
	.word	characterSpriteIndex
	.word	characterStandingRightBBox
	.word	characterStandingLeftBBox
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
	add	r3, r1, r3, lsr #24	@  y
	mov	r2, r0, asr #31	@  x
	bic	r3, r3, #255
	add	r2, r0, r2, lsr #24	@  x
	rsb	r1, r3, r1	@  y,  y
	bic	r2, r2, #255
	rsb	r0, r2, r0	@  x,  x
	mov	r3, r1, asr #31	@  y
	add	r1, r1, r3, lsr #29	@  y
	mov	r3, r0, asr #31	@  x
	add	r0, r0, r3, lsr #29	@  x
	mov	r1, r1, asr #3
	ldr	r3, .L422
	mov	r1, r1, asl #5
	add	r1, r1, r0, asr #3
	ldr	r2, [r3, #0]	@  bg1map
	mov	r1, r1, asl #1
	ldrh	r0, [r1, r2]	@  x
	@ lr needed for prologue
	bx	lr
.L423:
	.align	2
.L422:
	.word	bg1map
	.size	GetNextTile, .-GetNextTile
	.align	2
	.global	Shoot
	.type	Shoot, %function
Shoot:
	@ Function supports interworking.
	@ args = 12, pretend = 0, frame = 20
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #20
	mov	r9, r0	@  startX
	mov	r7, r1	@  startY
	str	r2, [fp, #-60]	@  mapX
	mov	r1, #128
	mov	r2, #10
	ldr	r0, .L425
	mov	sl, r3	@  mapY
	bl	GetNextFreePosition
	mov	r3, #4
	str	r3, [fp, #-52]	@  laserBBox.y
	mov	r6, #0
	mov	r2, #8
	mov	r3, #2
	str	r3, [fp, #-44]	@  laserBBox.ysize
	str	r2, [fp, #-48]	@  laserBBox.xsize
	str	r6, [fp, #-56]	@  laserBBox.x
	add	r4, r0, r0, asl #3	@  location,  location
	ldr	r3, .L425
	mov	r4, r4, asl #4
	sub	ip, fp, #56
	add	lr, r4, r3
	ldmia	ip, {r0, r1, r2, r3}
	ldr	ip, .L425
	str	r9, [r4, ip]	@  startX,  <variable>.x
	ldr	ip, [fp, #-60]	@  mapX
	str	ip, [lr, #44]	@  <variable>.mapX
	ldr	ip, [fp, #8]	@  spriteLoc,  spriteLoc
	add	r5, lr, #128
	str	r7, [lr, #4]	@  startY,  <variable>.y
	str	sl, [lr, #48]	@  mapY,  <variable>.mapY
	str	ip, [lr, #68]	@  spriteLoc,  <variable>.location
	str	r6, [lr, #8]	@  <variable>.size
	str	r6, [lr, #12]	@  <variable>.shape
	stmia	r5, {r0, r1, r2, r3}
	ldr	r3, [fp, #12]	@  isEnemy,  isEnemy
	str	r3, [lr, #84]	@  isEnemy,  <variable>.isEnemy
	mov	r3, #5
	str	r3, [lr, #88]	@  <variable>.speed
	ldr	r3, [fp, #4]	@  dir,  dir
	mov	r8, #1
	str	r8, [lr, #76]	@  <variable>.isProjectile
	str	r6, [lr, #92]	@  <variable>.isRemoved
	str	r3, [lr, #124]	@  dir,  <variable>.dir
	str	r8, [lr, #72]	@  <variable>.noGravity
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
.L426:
	.align	2
.L425:
	.word	sprites
	.size	Shoot, .-Shoot
	.align	2
	.global	Move
	.type	Move, %function
Move:
	@ Function supports interworking.
	@ args = 144, pretend = 8, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	sub	sp, sp, #8
	stmfd	sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub	fp, ip, #12
	sub	sp, sp, #128
	add	r4, fp, #4	@  direction
	cmp	r1, #1	@  direction
	mov	r5, r0	@  direction
	stmia	r4, {r2, r3}	@  direction
	beq	.L434
	bcc	.L429
	cmp	r1, #2	@  direction
	beq	.L439
.L445:
	ldr	r6, .L449
.L428:
	mov	r1, r4	@  direction
	mov	r0, r5	@  direction
	mov	r2, #144
	mov	lr, pc
	bx	r6
	mov	r0, r5	@  direction
	ldmea	fp, {r4, r5, r6, fp, sp, lr}
	bx	lr
.L439:
	ldr	r3, [fp, #52]	@  sprite.mapY
	cmp	r3, #0
	ble	.L445
	add	r1, fp, #20
	mov	r2, #128
	mov	r0, sp
	ldr	r6, .L449
	mov	lr, pc
	bx	r6
	ldmia	r4, {r0, r1, r2, r3}	@  direction
	ldr	ip, .L449+4
	mov	lr, pc
	bx	ip
	cmp	r0, #0	@  direction
	beq	.L428
	ldr	r2, [fp, #8]	@  sprite.y
	ldr	r3, [fp, #52]	@  sprite.mapY
	sub	r2, r2, #1
	sub	r3, r3, #1
	str	r2, [fp, #8]	@  sprite.y
	str	r3, [fp, #52]	@  sprite.mapY
	b	.L428
.L429:
	ldr	r3, [fp, #48]	@  sprite.mapX
	cmp	r3, #0
	ble	.L444
	add	r1, fp, #20
	mov	r2, #128
	mov	r0, sp
	ldr	r6, .L449
	mov	lr, pc
	bx	r6
	ldmia	r4, {r0, r1, r2, r3}	@  direction
	ldr	ip, .L449+8
	mov	lr, pc
	bx	ip
	cmp	r0, #0	@  direction
	beq	.L435
	ldr	r0, [fp, #92]	@  sprite.speed
	ldr	r1, [fp, #48]	@  sprite.mapX
	ldr	r2, [fp, #4]	@  sprite.x
	ldr	r3, [fp, #80]	@  sprite.isProjectile
	rsb	r1, r0, r1
	rsb	r2, r0, r2
	cmp	r3, #0
	str	r1, [fp, #48]	@  sprite.mapX
	str	r2, [fp, #4]	@  sprite.x
	beq	.L428
	cmp	r2, #0
	bne	.L428
.L447:
	mov	r0, r4	@  direction
.L446:
	ldr	r3, .L449+12
	mov	lr, pc
	bx	r3
	b	.L428
.L435:
	ldr	r3, [fp, #80]	@  sprite.isProjectile
	cmp	r3, #0
	beq	.L428
	add	r0, fp, #4
	b	.L446
.L444:
	ldr	r6, .L449
	b	.L435
.L434:
	mov	r3, #796
	ldr	r2, [fp, #48]	@  sprite.mapX
	add	r3, r3, #2
	cmp	r2, r3
	bgt	.L444
	add	r1, fp, #20
	mov	r2, #128
	mov	r0, sp
	ldr	r6, .L449
	mov	lr, pc
	bx	r6
	ldmia	r4, {r0, r1, r2, r3}	@  direction
	ldr	ip, .L449+16
	mov	lr, pc
	bx	ip
	cmp	r0, #0	@  direction
	beq	.L435
	ldr	r0, [fp, #92]	@  sprite.speed
	ldr	r1, [fp, #48]	@  sprite.mapX
	ldr	r2, [fp, #4]	@  sprite.x
	ldr	r3, [fp, #80]	@  sprite.isProjectile
	add	r1, r1, r0
	add	r2, r2, r0
	cmp	r3, #0
	str	r1, [fp, #48]	@  sprite.mapX
	str	r2, [fp, #4]	@  sprite.x
	beq	.L428
	cmp	r2, #240
	ble	.L428
	b	.L447
.L450:
	.align	2
.L449:
	.word	memcpy
	.word	CanMoveUp
	.word	CanMoveLeft
	.word	RemoveSprite
	.word	CanMoveRight
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
	sub	sp, sp, #128
	ldr	r9, .L456
	ldr	r3, [r9, #0]	@  shipScreenLeft
	cmp	r3, #0
	ldr	r5, .L456+4
	ldr	r6, .L456+8
	mov	r2, #128
	mov	r0, sp
	ble	.L451
	ldr	r4, [r5, #0]	@  characterSpriteIndex
	add	r4, r4, r4, asl #3
	add	r4, r6, r4, asl #4
	add	r1, r4, #16
	ldr	r3, .L456+12
	mov	lr, pc
	bx	r3
	ldmia	r4, {r0, r1, r2, r3}
	ldr	ip, .L456+16
	mov	lr, pc
	bx	ip
	cmp	r0, #0
	beq	.L451
	ldr	r2, .L456+20
	ldr	ip, [r9, #0]	@  shipScreenLeft
	ldr	r3, [r5, #0]	@  characterSpriteIndex
	ldr	r4, [r2, #0]	@  shipMapLeft
	ldr	r2, .L456+24
	sub	r7, ip, #1
	add	r3, r3, r3, asl #3
	ldr	lr, [r2, #0]	@  regX
	add	r8, r6, r3, asl #4
	ldr	r2, .L456+28
	mov	r3, r7, asr #31
	add	r3, r7, r3, lsr #29
	ldr	r5, [r2, #0]	@  shipScreenRight
	mov	r6, r3, asr #3
	mov	r2, ip, asr #31
	ldr	r3, .L456+24
	add	ip, ip, r2, lsr #29
	sub	lr, lr, #1
	cmp	r4, #0
	mov	r0, r7
	mov	r1, r6
	mov	sl, ip, asr #3
	sub	r5, r5, #1
	sub	r4, r4, #1
	str	lr, [r3, #0]	@  regX
	ble	.L453
	ldr	ip, .L456+32
	ldr	r3, [ip, #0]	@  shipMapRight
	ldr	lr, .L456+20
	sub	r3, r3, #1
	str	r4, [lr, #0]	@  shipMapLeft
	str	r3, [ip, #0]	@  shipMapRight
.L453:
	ldr	r2, .L456+28
	ldr	r3, [r8, #44]	@  <variable>.mapX
	ldr	ip, [r8, #88]	@  <variable>.speed
	ldr	lr, .L456+36
	str	r5, [r2, #0]	@  shipScreenRight
	ldr	r2, .L456+40
	rsb	r3, ip, r3
	cmp	r6, sl
	str	sl, [r2, #0]	@  shipPrevColumn
	str	r7, [r9, #0]	@  shipScreenLeft
	str	r6, [lr, #0]	@  shipNextColumn
	str	r3, [r8, #44]	@  <variable>.mapX
	blt	.L455
.L451:
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
.L455:
	ldr	r3, .L456+44
	ldr	ip, .L456+48
	ldr	r2, [r3, #0]	@  shipMapTop
	ldr	lr, .L456+52
	ldr	r3, [ip, #0]	@  shipMapBottom
	ldr	ip, .L456+56
	ldr	r4, [ip, #0]	@  map
	ldr	ip, [lr, #0]	@  bg0map
	mov	lr, #100
	stmia	sp, {r4, ip, lr}	@ phole stm
	ldr	ip, .L456+60
	mov	lr, pc
	bx	ip
	ldr	lr, .L456+36
	ldr	r3, .L456+44
	ldr	ip, .L456+48
	ldr	r1, [lr, #0]	@  shipNextColumn
	ldr	r2, [r3, #0]	@  shipMapTop
	ldr	lr, .L456+64
	ldr	r3, [ip, #0]	@  shipMapBottom
	ldr	ip, .L456+68
	ldr	r4, [ip, #0]	@  hitMap
	ldr	ip, [lr, #0]	@  bg1map
	mov	lr, #100
	str	ip, [sp, #4]
	ldr	r0, [r9, #0]	@  shipScreenLeft
	str	r4, [sp, #0]
	str	lr, [sp, #8]
	ldr	ip, .L456+60
	mov	lr, pc
	bx	ip
	b	.L451
.L457:
	.align	2
.L456:
	.word	shipScreenLeft
	.word	characterSpriteIndex
	.word	sprites
	.word	memcpy
	.word	CanMoveLeft
	.word	shipMapLeft
	.word	regX
	.word	shipScreenRight
	.word	shipMapRight
	.word	shipNextColumn
	.word	shipPrevColumn
	.word	shipMapTop
	.word	shipMapBottom
	.word	bg0map
	.word	map
	.word	CopyColumnToBackground
	.word	bg1map
	.word	hitMap
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
	sub	sp, sp, #128
	ldr	r7, .L463
	ldr	r3, [r7, #0]	@  shipScreenRight
	mov	r5, #796
	add	r5, r5, #2
	cmp	r3, r5
	ldr	r6, .L463+4
	ldr	r8, .L463+8
	mov	r2, #128
	mov	r0, sp
	ble	.L462
.L458:
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
.L462:
	ldr	r4, [r6, #0]	@  characterSpriteIndex
	add	r4, r4, r4, asl #3
	add	r4, r8, r4, asl #4
	add	r1, r4, #16
	ldr	r3, .L463+12
	mov	lr, pc
	bx	r3
	ldmia	r4, {r0, r1, r2, r3}
	ldr	ip, .L463+16
	mov	lr, pc
	bx	ip
	cmp	r0, #0
	ldr	lr, .L463+20
	ldr	r4, .L463+24
	ldr	sl, .L463+28
	beq	.L458
	ldr	r0, [r4, #0]	@  shipMapRight
	ldr	r3, [r6, #0]	@  characterSpriteIndex
	ldr	r9, .L463+32
	cmp	r0, r5
	add	r3, r3, r3, asl #3
	add	r6, r8, r3, asl #4
	ldr	r2, [lr, #0]	@  regX
	ldrle	r3, [r9, #0]	@  shipMapLeft
	add	ip, r0, #1
	addle	r3, r3, #1
	add	r2, r2, #1
	str	r2, [lr, #0]	@  regX
	strle	ip, [r4, #0]	@  shipMapRight
	strle	r3, [r9, #0]	@  shipMapLeft
	ldr	ip, [r7, #0]	@  shipScreenRight
	ldr	r4, [r6, #44]	@  <variable>.mapX
	ldr	r5, [r6, #88]	@  <variable>.speed
	add	lr, ip, #1
	ldr	r1, [sl, #0]	@  shipScreenLeft
	mov	r3, ip, asr #31
	add	ip, ip, r3, lsr #29
	mov	r2, lr, asr #31
	ldr	r3, .L463+36
	add	r1, r1, #1
	mov	ip, ip, asr #3
	add	r2, lr, r2, lsr #29
	add	r4, r4, r5
	mov	r2, r2, asr #3
	str	r1, [sl, #0]	@  shipScreenLeft
	str	r4, [r6, #44]	@  <variable>.mapX
	str	ip, [r3, #0]	@  shipPrevColumn
	ldr	r3, .L463+40
	cmp	r2, ip
	mov	r0, lr
	mov	r1, r2
	str	lr, [r7, #0]	@  shipScreenRight
	str	r2, [r3, #0]	@  shipNextColumn
	ble	.L458
	ldr	ip, .L463+44
	ldr	lr, .L463+48
	ldr	r2, [ip, #0]	@  shipMapTop
	ldr	r3, [lr, #0]	@  shipMapBottom
	ldr	ip, .L463+52
	ldr	lr, .L463+56
	ldr	r4, [ip, #0]	@  map
	ldr	ip, [lr, #0]	@  bg0map
	mov	lr, #100
	stmia	sp, {r4, ip, lr}	@ phole stm
	ldr	ip, .L463+60
	mov	lr, pc
	bx	ip
	ldr	lr, .L463+40
	ldr	r3, .L463+44
	ldr	ip, .L463+48
	ldr	r1, [lr, #0]	@  shipNextColumn
	ldr	r2, [r3, #0]	@  shipMapTop
	ldr	lr, .L463+64
	ldr	r3, [ip, #0]	@  shipMapBottom
	ldr	ip, .L463+68
	ldr	r4, [ip, #0]	@  hitMap
	ldr	ip, [lr, #0]	@  bg1map
	mov	lr, #100
	str	ip, [sp, #4]
	ldr	r0, [r7, #0]	@  shipScreenRight
	str	r4, [sp, #0]
	str	lr, [sp, #8]
	ldr	ip, .L463+60
	mov	lr, pc
	bx	ip
	b	.L458
.L464:
	.align	2
.L463:
	.word	shipScreenRight
	.word	characterSpriteIndex
	.word	sprites
	.word	memcpy
	.word	CanMoveRight
	.word	regX
	.word	shipMapRight
	.word	shipScreenLeft
	.word	shipMapLeft
	.word	shipPrevColumn
	.word	shipNextColumn
	.word	shipMapTop
	.word	shipMapBottom
	.word	map
	.word	bg0map
	.word	CopyColumnToBackground
	.word	bg1map
	.word	hitMap
	.size	MoveMapRight, .-MoveMapRight
	.align	2
	.global	CanMove
	.type	CanMove, %function
CanMove:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {fp, ip, lr, pc}
	sub	fp, ip, #4
	bl	GetNextTile
	subs	r0, r0, #1	@  x,  x
	movne	r0, #1	@  x
	ldmea	fp, {fp, sp, lr}
	bx	lr
	.size	CanMove, .-CanMove
	.align	2
	.global	CanMoveRight
	.type	CanMoveRight, %function
CanMoveRight:
	@ Function supports interworking.
	@ args = 144, pretend = 16, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	sub	sp, sp, #16
	stmfd	sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub	fp, ip, #20
	add	ip, fp, #4
	stmia	ip, {r0, r1, r2, r3}
	ldr	r2, [fp, #140]	@  sprite.boundingBox.xsize
	ldr	r3, [fp, #48]	@  sprite.mapX
	ldr	r1, [fp, #132]	@  sprite.boundingBox.x
	add	r3, r3, r2
	add	r3, r3, r1	@  x
	ldr	r5, [fp, #52]	@  y,  sprite.mapY
	add	r6, r3, #1	@  x
	mov	r1, r5	@  y
	mov	r0, r6
	bl	CanMove
	mov	r3, r0
	cmp	r3, #0
	mov	r0, r6
	beq	.L466
	ldr	r4, [fp, #144]	@  sprite.boundingBox.ysize
	add	r4, r4, r4, lsr #31
	mov	r4, r4, asr #1	@  halfYSize
	add	r5, r5, r4	@  y,  y,  halfYSize
	mov	r1, r5	@  y
	bl	CanMove
	add	r4, r5, r4	@  y,  halfYSize
	mov	r3, r0
	sub	r5, r4, #1	@  y
	cmp	r3, #0
	mov	r0, r6
	mov	r1, r5	@  y
	beq	.L466
	bl	CanMove
	cmp	r0, #0
	movne	r3, #1
	moveq	r3, #0
.L466:
	mov	r0, r3
	ldmea	fp, {r4, r5, r6, fp, sp, lr}
	bx	lr
	.size	CanMoveRight, .-CanMoveRight
	.align	2
	.global	CanMoveLeft
	.type	CanMoveLeft, %function
CanMoveLeft:
	@ Function supports interworking.
	@ args = 144, pretend = 16, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	sub	sp, sp, #16
	stmfd	sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub	fp, ip, #20
	add	ip, fp, #4
	stmia	ip, {r0, r1, r2, r3}
	ldr	r2, [fp, #132]	@  sprite.boundingBox.x
	add	r3, fp, #48
	ldmia	r3, {r3, r5}	@ phole ldm
	add	r3, r3, r2	@  x
	sub	r6, r3, #1	@  x
	mov	r1, r5	@  y
	mov	r0, r6
	bl	CanMove
	mov	r3, r0
	cmp	r3, #0
	mov	r0, r6
	beq	.L470
	ldr	r4, [fp, #144]	@  sprite.boundingBox.ysize
	add	r4, r4, r4, lsr #31
	mov	r4, r4, asr #1	@  halfYSize
	add	r5, r5, r4	@  y,  y,  halfYSize
	mov	r1, r5	@  y
	bl	CanMove
	add	r4, r5, r4	@  y,  halfYSize
	mov	r3, r0
	sub	r5, r4, #1	@  y
	cmp	r3, #0
	mov	r0, r6
	mov	r1, r5	@  y
	beq	.L470
	bl	CanMove
	cmp	r0, #0
	movne	r3, #1
	moveq	r3, #0
.L470:
	mov	r0, r3
	ldmea	fp, {r4, r5, r6, fp, sp, lr}
	bx	lr
	.size	CanMoveLeft, .-CanMoveLeft
	.align	2
	.global	CanMoveUp
	.type	CanMoveUp, %function
CanMoveUp:
	@ Function supports interworking.
	@ args = 144, pretend = 16, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	sub	sp, sp, #16
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	sub	fp, ip, #20
	add	ip, fp, #4
	stmia	ip, {r0, r1, r2, r3}
	ldr	r3, [fp, #132]	@  sprite.boundingBox.x
	add	r2, fp, #48
	ldmia	r2, {r2, r5}	@ phole ldm
	add	r4, r2, r3	@  x
	mov	r1, r5	@  y
	mov	r0, r4	@  x
	bl	CanMove
	cmp	r0, #0	@  x
	mov	r1, r5	@  y
	mov	r3, r0	@  x,  x
	beq	.L474
	ldr	r3, [fp, #140]	@  sprite.boundingBox.xsize
	add	r3, r3, r3, lsr #31
	mov	r3, r3, asr #1	@  halfXSize
	add	r4, r4, r3	@  x,  x,  halfXSize
	mov	r0, r4	@  x
	add	r4, r4, r3	@  x,  x,  halfXSize
	bl	CanMove
	mov	r3, r0	@  x
	cmp	r3, #0	@  x
	mov	r0, r4	@  x
	mov	r1, r5	@  y
	beq	.L474
	bl	CanMove
	cmp	r0, #0	@  x
	movne	r3, #1	@  x
	moveq	r3, #0	@  x
.L474:
	mov	r0, r3	@  x
	ldmea	fp, {r4, r5, fp, sp, lr}
	bx	lr
	.size	CanMoveUp, .-CanMoveUp
	.align	2
	.global	CanMoveDown
	.type	CanMoveDown, %function
CanMoveDown:
	@ Function supports interworking.
	@ args = 144, pretend = 16, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	sub	sp, sp, #16
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	sub	fp, ip, #20
	add	ip, fp, #4
	stmia	ip, {r0, r1, r2, r3}
	ldr	r2, [fp, #52]	@  sprite.mapY
	ldr	r3, [fp, #144]	@  sprite.boundingBox.ysize
	ldr	r1, [fp, #48]	@  sprite.mapX
	add	r5, r2, r3	@  y
	ldr	r3, [fp, #132]	@  sprite.boundingBox.x
	add	r4, r1, r3	@  x
	mov	r0, r4	@  x
	mov	r1, r5	@  y
	bl	CanMove
	cmp	r0, #0	@  x
	mov	r1, r5	@  y
	mov	r3, r0	@  x,  x
	beq	.L478
	ldr	r3, [fp, #140]	@  sprite.boundingBox.xsize
	add	r3, r3, r3, lsr #31
	mov	r3, r3, asr #1	@  halfXSize
	add	r4, r4, r3	@  x,  x,  halfXSize
	mov	r0, r4	@  x
	add	r4, r4, r3	@  x,  x,  halfXSize
	bl	CanMove
	mov	r3, r0	@  x
	cmp	r3, #0	@  x
	mov	r0, r4	@  x
	mov	r1, r5	@  y
	beq	.L478
	bl	CanMove
	cmp	r0, #0	@  x
	movne	r3, #1	@  x
	moveq	r3, #0	@  x
.L478:
	mov	r0, r3	@  x
	ldmea	fp, {r4, r5, fp, sp, lr}
	bx	lr
	.size	CanMoveDown, .-CanMoveDown
	.align	2
	.global	RemoveSprite
	.type	RemoveSprite, %function
RemoveSprite:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r3, #1
	str	r3, [r0, #92]	@  <variable>.isRemoved
	mov	r2, #240
	mov	r3, #160
	@ lr needed for prologue
	stmia	r0, {r2, r3}	@ phole stm
	bx	lr
	.size	RemoveSprite, .-RemoveSprite
	.align	2
	.global	SpawnEnemy
	.type	SpawnEnemy, %function
SpawnEnemy:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, sl, fp, ip, lr, pc}
	ldr	r4, .L486	@  mapX
	mov	r8, r0	@  mapX
	sub	fp, ip, #4
	mov	sl, r1	@  mapY
	mov	r2, #0
	mov	r1, #128
	mov	r0, r4	@  mapX
	bl	GetNextFreePosition
	ldr	r3, .L486+4
	mov	ip, r0, asl #3	@  location
	ldr	r1, [r3, #0]	@  shipScreenRight
	add	r2, ip, r0	@  location
	mov	r3, #96
	cmp	r8, r1	@  mapX
	add	r1, r4, r2, asl #4	@  mapX
	str	r3, [r1, #4]	@  <variable>.y
	ldrle	r3, .L486+8
	ldrle	r2, [r3, #0]	@  shipScreenLeft
	movgt	r3, #240
	rsble	r3, r2, r8	@  mapX
	mov	r7, r0	@  location
	str	r3, [r1, #0]	@  <variable>.x
	ldr	lr, .L486+12
	add	ip, ip, r7	@  location
	ldmia	lr, {r0, r1, r2, r3}
	add	ip, r4, ip, asl #4	@  mapX
	mov	r6, #32768
	add	r4, ip, #128
	mov	lr, #160
	mov	r5, #0
	str	r8, [ip, #44]	@  mapX,  <variable>.mapX
	str	sl, [ip, #48]	@  mapY,  <variable>.mapY
	str	r6, [ip, #12]	@  <variable>.shape
	str	lr, [ip, #68]	@  <variable>.location
	str	r6, [ip, #8]	@  <variable>.size
	stmia	r4, {r0, r1, r2, r3}
	mov	r3, #1
	mov	r0, r7	@  location
	str	r5, [ip, #124]	@  <variable>.dir
	str	r3, [ip, #88]	@  <variable>.speed
	str	r5, [ip, #72]	@  <variable>.noGravity
	str	r5, [ip, #76]	@  <variable>.isProjectile
	str	r5, [ip, #92]	@  <variable>.isRemoved
	ldmea	fp, {r4, r5, r6, r7, r8, sl, fp, sp, lr}
	bx	lr
.L487:
	.align	2
.L486:
	.word	sprites
	.word	shipScreenRight
	.word	shipScreenLeft
	.word	characterWalkingLeftBBox
	.size	SpawnEnemy, .-SpawnEnemy
	.align	2
	.global	HitTest
	.type	HitTest, %function
HitTest:
	@ Function supports interworking.
	@ args = 288, pretend = 16, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #16
	stmia	sp, {r0, r1, r2, r3}
	ldr	r3, [sp, #136]	@  sprite1.boundingBox.xsize
	ldr	r1, [sp, #144]	@  sprite2.x
	add	r2, r0, r3
	cmp	r2, r1
	@ lr needed for prologue
	blt	.L489
	ldr	r3, [sp, #280]	@  sprite2.boundingBox.xsize
	add	r3, r1, r3
	cmp	r2, r3
	bgt	.L489
	ldr	r1, [sp, #4]	@  sprite1.y
	ldr	r2, [sp, #148]	@  sprite2.y
	cmp	r1, r2
	blt	.L489
	ldr	r3, [sp, #284]	@  sprite2.boundingBox.ysize
	add	r3, r2, r3
	cmp	r1, r3
	mov	r0, #1
	ble	.L488
.L489:
	mov	r0, #0
.L488:
	add	sp, sp, #16
	bx	lr
	.size	HitTest, .-HitTest
	.align	2
	.global	CounterPlayerMovement
	.type	CounterPlayerMovement, %function
CounterPlayerMovement:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, lr}
	mov	lr, #0	@  i
	ldr	r4, .L501
	mov	r5, r0	@  amount
	mov	r0, lr	@  i,  i
.L498:
	add	ip, r0, r4	@  i
	ldr	r3, [ip, #92]	@  <variable>.isRemoved
	cmp	r3, #0
	bne	.L494
	ldr	r3, .L501+4
	ldr	r2, [r3, #0]	@  characterSpriteIndex
	cmp	lr, r2	@  i
	beq	.L494
	ldr	r3, [ip, #80]	@  <variable>.isHUD
	cmp	r3, #0
	bne	.L494
	ldr	r3, .L501+8
	ldr	r1, [ip, #136]	@  <variable>.boundingBox.xsize
	ldr	r2, [r3, #0]	@  shipScreenLeft
	ldr	ip, [ip, #44]	@  <variable>.mapX
	rsb	r2, r1, r2
	cmp	ip, r2
	ble	.L494
	ldr	r3, .L501+12
	ldr	r2, [r3, #0]	@  shipScreenRight
	cmp	ip, r2
	ldrlt	r3, [r0, r4]	@  <variable>.x
	addlt	r3, r3, r5	@  amount
	strlt	r3, [r0, r4]	@  <variable>.x
.L494:
	add	lr, lr, #1	@  i,  i
	cmp	lr, #127	@  i
	add	r0, r0, #144	@  i,  i
	ble	.L498
	ldmfd	sp!, {r4, r5, lr}
	bx	lr
.L502:
	.align	2
.L501:
	.word	sprites
	.word	characterSpriteIndex
	.word	shipScreenLeft
	.word	shipScreenRight
	.size	CounterPlayerMovement, .-CounterPlayerMovement
	.align	2
	.global	ChangePlayerHealth
	.type	ChangePlayerHealth, %function
ChangePlayerHealth:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, sl, lr}
	cmp	r0, #10	@  health
	ldrls	pc, [pc, r0, asl #2]	@  health
	b	.L504
	.p2align 2
.L516:
	.word	.L515
	.word	.L514
	.word	.L513
	.word	.L512
	.word	.L511
	.word	.L510
	.word	.L509
	.word	.L508
	.word	.L507
	.word	.L506
	.word	.L505
.L505:
	mov	sl, #198	@  leftNum
	mov	r8, #196	@  rightNum
.L504:
	ldr	r3, .L518
	ldr	r2, .L518+4
	ldr	r1, [r3, #0]	@  leftHealthIndex
	ldr	r0, [r2, #0]	@  rightHealthIndex
	ldr	r5, .L518+8
	add	r1, r1, r1, asl #3
	add	r0, r0, r0, asl #3
	mov	r1, r1, asl #4
	mov	r0, r0, asl #4
	add	ip, r1, r5
	mov	r4, #0
	add	lr, r0, r5
	mov	r6, #1
	mov	r7, #148
	mov	r3, #4
	mov	r2, #12
	str	r3, [r1, r5]	@  <variable>.x
	str	sl, [ip, #68]	@  leftNum,  <variable>.location
	str	r6, [ip, #80]	@  <variable>.isHUD
	str	r7, [ip, #4]	@  <variable>.y
	str	r4, [ip, #8]	@  <variable>.size
	str	r4, [ip, #12]	@  <variable>.shape
	str	r6, [ip, #72]	@  <variable>.noGravity
	str	r4, [ip, #76]	@  <variable>.isProjectile
	str	r4, [ip, #92]	@  <variable>.isRemoved
	str	r2, [r0, r5]	@  <variable>.x
	str	r6, [lr, #80]	@  <variable>.isHUD
	str	r8, [lr, #68]	@  rightNum,  <variable>.location
	str	r7, [lr, #4]	@  <variable>.y
	str	r4, [lr, #92]	@  <variable>.isRemoved
	str	r4, [lr, #8]	@  <variable>.size
	str	r4, [lr, #12]	@  <variable>.shape
	str	r6, [lr, #72]	@  <variable>.noGravity
	str	r4, [lr, #76]	@  <variable>.isProjectile
	ldmfd	sp!, {r4, r5, r6, r7, r8, sl, lr}
	bx	lr
.L515:
	mov	r8, #196	@  rightNum
	mov	sl, r8	@  leftNum,  rightNum
	b	.L504
.L514:
	mov	sl, #196	@  leftNum
	mov	r8, #198	@  rightNum
	b	.L504
.L513:
	mov	sl, #196	@  leftNum
	mov	r8, #200	@  rightNum
	b	.L504
.L512:
	mov	sl, #196	@  leftNum
	mov	r8, #202	@  rightNum
	b	.L504
.L511:
	mov	sl, #196	@  leftNum
	mov	r8, #204	@  rightNum
	b	.L504
.L510:
	mov	sl, #196	@  leftNum
	mov	r8, #206	@  rightNum
	b	.L504
.L509:
	mov	sl, #196	@  leftNum
	mov	r8, #208	@  rightNum
	b	.L504
.L508:
	mov	sl, #196	@  leftNum
	mov	r8, #210	@  rightNum
	b	.L504
.L507:
	mov	sl, #196	@  leftNum
	mov	r8, #212	@  rightNum
	b	.L504
.L506:
	mov	sl, #196	@  leftNum
	mov	r8, #214	@  rightNum
	b	.L504
.L519:
	.align	2
.L518:
	.word	leftHealthIndex
	.word	rightHealthIndex
	.word	sprites
	.size	ChangePlayerHealth, .-ChangePlayerHealth
	.align	2
	.global	InitializeContinueGame
	.type	InitializeContinueGame, %function
InitializeContinueGame:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	ldr	r3, .L521
	ldr	r6, .L521+4	@  location
	sub	fp, ip, #4
	mov	ip, #1
	str	ip, [r3, #0]	@  gameOver
	mov	r1, #128
	mov	r2, #0
	mov	r0, r6	@  location
	bl	GetNextFreePosition
	add	r5, r0, #1	@  location
	add	r0, r0, r0, asl #3	@  location,  location
	mov	r0, r0, asl #4
	add	ip, r5, r5, asl #3
	add	lr, r0, r6	@  location
	mov	ip, ip, asl #4
	mov	r3, #112
	mov	r2, #226
	add	r1, ip, r6	@  location
	str	r3, [r0, r6]	@  <variable>.x
	str	r2, [lr, #68]	@  <variable>.location
	mov	r3, #116
	mov	r2, #196
	str	r3, [ip, r6]	@  <variable>.x
	str	r2, [r1, #212]	@  <variable>.location
	mov	r3, #60
	mov	r2, #32768
	str	r3, [lr, #4]	@  <variable>.y
	str	r2, [lr, #8]	@  <variable>.size
	mov	r3, #16384
	ldr	r2, .L521+8
	str	r3, [lr, #12]	@  <variable>.shape
	mov	r3, #198
	str	r5, [r2, #0]	@  timeLeftIndex
	mov	r4, #0
	mov	r7, #78
	str	r3, [r1, #68]	@  <variable>.location
	mov	r3, #122
	str	r7, [r1, #148]	@  <variable>.y
	str	r3, [r1, #144]	@  <variable>.x
	str	r4, [r1, #156]	@  <variable>.shape
	str	r7, [r1, #4]	@  <variable>.y
	str	r4, [r1, #8]	@  <variable>.size
	str	r4, [r1, #12]	@  <variable>.shape
	str	r4, [r1, #152]	@  <variable>.size
	bl	WaitVBlank
	mov	r0, r6	@  location
	mov	r1, #128
	ldmea	fp, {r4, r5, r6, r7, fp, sp, lr}
	b	UpdateSpriteMemory
.L522:
	.align	2
.L521:
	.word	gameOver
	.word	sprites
	.word	timeLeftIndex
	.size	InitializeContinueGame, .-InitializeContinueGame
	.align	2
	.global	GameOverUpdate
	.type	GameOverUpdate, %function
GameOverUpdate:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, fp, ip, lr, pc}
	sub	fp, ip, #4
	bl	keyPoll
	mov	r0, #1
	bl	keyHit
	cmp	r0, #0
	bne	.L547
	ldr	r5, .L548
	ldr	r3, [r5, #0]	@  timeLeft
	cmp	r3, #0
	blt	.L523
	cmp	r3, #10
	ldrls	pc, [pc, r3, asl #2]
	b	.L527
	.p2align 2
.L539:
	.word	.L538
	.word	.L537
	.word	.L536
	.word	.L535
	.word	.L534
	.word	.L533
	.word	.L532
	.word	.L531
	.word	.L530
	.word	.L529
	.word	.L528
.L528:
	mov	r7, #198	@  leftNum
	mov	r6, #196	@  rightNum
.L527:
	ldr	r2, .L548+4
	ldr	r3, [r2, #0]	@  timeLeftIndex
	ldr	r0, [r5, #0]	@  timeLeft
	ldr	r4, .L548+8
	add	r3, r3, r3, asl #3
	mov	r3, r3, asl #4
	mov	r1, #116
	add	r2, r3, r4
	mov	ip, #0	@  n
	mov	lr, #78
	str	r1, [r3, r4]	@  <variable>.x
	sub	r0, r0, #1
	mov	r3, #122
	str	r0, [r5, #0]	@  timeLeft
	str	r3, [r2, #144]	@  <variable>.x
	str	r6, [r2, #212]	@  rightNum,  <variable>.location
	str	r7, [r2, #68]	@  leftNum,  <variable>.location
	str	lr, [r2, #148]	@  <variable>.y
	str	ip, [r2, #156]	@  n,  <variable>.shape
	str	lr, [r2, #4]	@  <variable>.y
	str	ip, [r2, #8]	@  n,  <variable>.size
	str	ip, [r2, #12]	@  n,  <variable>.shape
	str	ip, [r2, #152]	@  n,  <variable>.size
	bl	WaitVBlank
	mov	r0, r4
	mov	r1, #128
	bl	UpdateSpriteMemory
	mov	r3, #1998848	@  n
	add	r3, r3, #1152	@  n,  n
.L545:
	subs	r3, r3, #1	@  n,  n
	bne	.L545
.L523:
	ldmea	fp, {r4, r5, r6, r7, fp, sp, lr}
	bx	lr
.L538:
	mov	r6, #196	@  rightNum
	mov	r7, r6	@  leftNum,  rightNum
	b	.L527
.L537:
	mov	r7, #196	@  leftNum
	mov	r6, #198	@  rightNum
	b	.L527
.L536:
	mov	r7, #196	@  leftNum
	mov	r6, #200	@  rightNum
	b	.L527
.L535:
	mov	r7, #196	@  leftNum
	mov	r6, #202	@  rightNum
	b	.L527
.L534:
	mov	r7, #196	@  leftNum
	mov	r6, #204	@  rightNum
	b	.L527
.L533:
	mov	r7, #196	@  leftNum
	mov	r6, #206	@  rightNum
	b	.L527
.L532:
	mov	r7, #196	@  leftNum
	mov	r6, #208	@  rightNum
	b	.L527
.L531:
	mov	r7, #196	@  leftNum
	mov	r6, #210	@  rightNum
	b	.L527
.L530:
	mov	r7, #196	@  leftNum
	mov	r6, #212	@  rightNum
	b	.L527
.L529:
	mov	r7, #196	@  leftNum
	mov	r6, #214	@  rightNum
	b	.L527
.L547:
	ldr	r3, .L548+12
	mov	r2, #0
	str	r2, [r3, #0]	@  gameOver
	bl	ShipInitialize
	ldr	r3, .L548
	mov	r2, #10
	str	r2, [r3, #0]	@  timeLeft
	b	.L523
.L549:
	.align	2
.L548:
	.word	timeLeft
	.word	timeLeftIndex
	.word	sprites
	.word	gameOver
	.size	GameOverUpdate, .-GameOverUpdate
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
	bge	.L557
	mla	r2, r1, ip, r0	@  sourceColumns,  row,  column
	ldr	r3, [sp, #12]	@  source,  source
	mov	r1, r1, asl #1	@  sourceColumns
	add	r0, r3, r2, asl #1	@  source
.L555:
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
	blt	.L555
.L557:
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
	bge	.L565
	ldr	r3, [sp, #24]	@  sourceColumns,  sourceColumns
	mla	r2, r3, r0, ip	@  sourceColumns,  row,  column
	mov	r1, r4, asl #5	@  copyToRow
	mov	r0, r2, asl #1
.L563:
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
	blt	.L563
.L565:
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
	.size	CopyRowToBackground, .-CopyRowToBackground
	.align	2
	.global	Sin_val
	.type	Sin_val, %function
Sin_val:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r0, r0, lsr #6	@  angle
	bic	r0, r0, #1
	ldr	r3, .L567
	mov	r0, r0, asl #22
	mov	r0, r0, lsr #22
	ldrsh	r0, [r0, r3]	@  angle,  sin_lut
	@ lr needed for prologue
	bx	lr
.L568:
	.align	2
.L567:
	.word	sin_lut
	.size	Sin_val, .-Sin_val
	.align	2
	.global	Cos_val
	.type	Cos_val, %function
Cos_val:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	mov	r0, r0, lsr #7	@  angle
	add	r0, r0, #128
	mov	r0, r0, asl #23
	ldr	r3, .L570
	mov	r0, r0, lsr #23
	mov	r0, r0, asl #1
	ldrsh	r0, [r0, r3]	@  angle,  sin_lut
	@ lr needed for prologue
	bx	lr
.L571:
	.align	2
.L570:
	.word	sin_lut
	.size	Cos_val, .-Cos_val
	.comm	buttons, 40, 32
	.comm	curr_state, 2, 16
	.comm	prev_state, 2, 16
	.comm	bg0map, 4, 32
	.comm	bg1map, 4, 32
	.comm	sprites, 18432, 32
	.comm	jumpDuration, 4, 32
	.comm	characterSpriteIndex, 4, 32
	.comm	enemySpriteIndex, 4, 32
	.comm	leftHealthIndex, 4, 32
	.comm	rightHealthIndex, 4, 32
	.comm	timeLeftIndex, 4, 32
	.comm	characterWalkingRightBBox, 16, 32
	.comm	characterStandingRightBBox, 16, 32
	.comm	characterWalkingLeftBBox, 16, 32
	.comm	characterStandingLeftBBox, 16, 32
	.comm	characterGunBBox, 16, 32
	.ident	"GCC: (GNU) 3.3.2"
