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
	ldrh	r2, [ip, #12]	@  <variable>.shape
	mov	r3, r4, lsr #16	@  sprite
	orr	r2, r2, r1
	orr	r2, r2, #8192
	mov	r3, r3, asl #16
	orr	r4, r3, r2	@  sprite
	mov	r3, r4, asl #16	@  sprite
	ldrh	r0, [ip, #8]	@  <variable>.size
	mov	r3, r3, lsr #16
	orr	r4, r3, r0, asl #16	@  sprite
	mov	r2, r4, lsr #16	@  sprite
	ldr	r1, [ip, #60]	@  <variable>.hFlip
	mov	r2, r2, asl #16
	mov	r3, r4, asl #16	@  sprite
	cmp	r1, #0
	orr	r2, r2, #268435456
	orrne	r4, r2, r3, lsr #16	@  sprite
	mov	r3, r4, lsr #16	@  sprite
	ldr	r2, [ip, #64]	@  <variable>.vFlip
	mov	r3, r3, asl #16
	mov	r1, r4, asl #16	@  sprite
	cmp	r2, #0
	orr	r3, r3, #536870912
	orrne	r4, r3, r1, lsr #16	@  sprite
	ldrh	r1, [lr, r8]	@  <variable>.x
	mov	r2, r4, asl #16	@  sprite
	mov	r3, r5, lsr #16
	ldrh	r0, [ip, #68]	@  <variable>.location
	mov	r2, r2, lsr #16
	orr	r1, r1, r4, lsr #16	@  sprite
	mov	r3, r3, asl #16
	orr	r4, r2, r1, asl #16	@  sprite
	orr	r5, r3, r0
	subs	r6, r6, #1	@  i,  i
	add	lr, lr, #136	@  i,  i
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
	add	r6, r6, #136	@  i,  i
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
	mov	r2, #1	@  i
	cmp	r2, r1	@  i,  count
	@ lr needed for prologue
	bge	.L58
	add	r0, r0, #220	@  sprites
.L56:
	ldr	r3, [r0, #0]	@  <variable>.isRemoved
	cmp	r3, #0
	add	r0, r0, #136
	movne	r0, r2	@  i,  i
	bxne	lr
	add	r2, r2, #1	@  i,  i
	cmp	r2, r1	@  i,  count
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
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	mov	r2, #4416
	mov	r3, #67108864
	mov	r1, #83886080
	ldr	r0, .L184
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
	add	r1, r1, #512
	str	r2, [r3, #0]
	sub	fp, ip, #4
	mov	r2, #0	@  n
.L118:
	mov	r3, r2, asl #1	@  n
	ldrh	r4, [r3, r0]	@ movhi	@  philPalette
	add	r2, r2, #1	@  n,  n
	cmp	r2, #255	@  n
	strh	r4, [r3, r1]	@ movhi 
	ble	.L118
	mov	r0, #508
	mov	r1, #100663296
	ldr	ip, .L184+4
	mov	r2, #0	@  n
	add	r0, r0, #3
	add	r1, r1, #65536
.L123:
	mov	r3, r2, asl #1	@  n
	ldrh	lr, [r3, ip]	@ movhi	@  philData
	add	r2, r2, #1	@  n,  n
	cmp	r2, r0	@  n
	strh	lr, [r3, r1]	@ movhi 
	ble	.L123
	mov	r2, #512	@  n
	mov	ip, #100663296
	ldr	lr, .L184+8
	add	r0, r2, r2	@  n
	add	ip, ip, #65536
	mov	r1, #0
.L128:
	mov	r3, r2, asl #1	@  n
	ldrh	r4, [r1, lr]	@ movhi	@  philFacingRightData
	add	r2, r2, #1	@  n,  n
	cmp	r2, r0	@  n
	strh	r4, [r3, ip]	@ movhi 
	add	r1, r1, #2
	blt	.L128
	add	r3, r2, #512	@  n
	mov	ip, #100663296
	ldr	lr, .L184+12
	mov	r0, r3
	add	ip, ip, #65536
	mov	r1, #0
.L133:
	mov	r3, r2, asl #1	@  n
	ldrh	r4, [r1, lr]	@ movhi	@  philFacingRight2Data
	add	r2, r2, #1	@  n,  n
	cmp	r2, r0	@  n
	strh	r4, [r3, ip]	@ movhi 
	add	r1, r1, #2
	blt	.L133
	add	r3, r2, #512	@  n
	mov	ip, #100663296
	ldr	lr, .L184+16
	mov	r0, r3
	add	ip, ip, #65536
	mov	r1, #0
.L138:
	mov	r3, r2, asl #1	@  n
	ldrh	r4, [r1, lr]	@ movhi	@  philFacingRight3Data
	add	r2, r2, #1	@  n,  n
	cmp	r2, r0	@  n
	strh	r4, [r3, ip]	@ movhi 
	add	r1, r1, #2
	blt	.L138
	add	r3, r2, #512	@  n
	mov	ip, #100663296
	ldr	lr, .L184+20
	mov	r0, r3
	add	ip, ip, #65536
	mov	r1, #0
.L143:
	mov	r3, r2, asl #1	@  n
	ldrh	r4, [r1, lr]	@ movhi	@  philJumpingData
	add	r2, r2, #1	@  n,  n
	cmp	r2, r0	@  n
	strh	r4, [r3, ip]	@ movhi 
	add	r1, r1, #2
	blt	.L143
	add	r3, r2, #32	@  n
	mov	ip, #100663296
	ldr	lr, .L184+24
	mov	r0, r3
	add	ip, ip, #65536
	mov	r1, #0
.L148:
	mov	r3, r2, asl #1	@  n
	ldrh	r4, [r1, lr]	@ movhi	@  laserData
	add	r2, r2, #1	@  n,  n
	cmp	r2, r0	@  n
	strh	r4, [r3, ip]	@ movhi 
	add	r1, r1, #2
	blt	.L148
	ldr	r9, .L184+28
	mov	r0, #160
	mov	r8, #240
	mov	sl, #1
	mov	r1, #0	@  n
	mov	r2, #127	@  n
.L153:
	add	r3, r1, r9	@  n
	subs	r2, r2, #1	@  n,  n
	str	r8, [r1, r9]	@  <variable>.x
	str	sl, [r3, #84]	@  <variable>.isRemoved
	str	r0, [r3, #4]	@  <variable>.y
	add	r1, r1, #136	@  n,  n
	bpl	.L153
	ldr	ip, .L184+32
	mov	r5, #0	@  i
	mov	lr, #32
	mov	r3, #7
	mov	r2, #8
	str	lr, [ip, #12]	@  characterStandingRightBBox.ysize
	stmia	ip, {r3, r5}	@ phole stm
	str	r2, [ip, #8]	@  characterStandingRightBBox.xsize
	ldr	r4, .L184+36
	ldmia	ip, {r0, r1, r2, r3}
	mov	ip, #32768
	str	ip, [r9, #8]	@  <variable>.size
	ldr	r6, .L184+40
	mov	ip, #2
	str	lr, [r9, #68]	@  <variable>.location
	str	ip, [r4, #0]	@  characterWalkingRightBBox.x
	mov	ip, #18
	str	ip, [r6, #0]	@  characterWalkingLeftBBox.x
	ldr	r7, .L184+44
	mov	ip, #16
	str	ip, [r6, #8]	@  characterWalkingLeftBBox.xsize
	mov	ip, #14
	str	lr, [r4, #12]	@  characterWalkingRightBBox.ysize
	str	lr, [r6, #12]	@  characterWalkingLeftBBox.ysize
	str	ip, [r7, #0]	@  characterStandingLeftBBox.x
	str	lr, [r7, #12]	@  characterStandingLeftBBox.ysize
	ldr	ip, .L184+48
	ldr	lr, .L184+52
	str	r5, [ip, #0]	@  i,  characterSpriteIndex
	str	r2, [r7, #8]	@  characterStandingLeftBBox.xsize
	str	r5, [r9, #4]	@  i,  <variable>.y
	str	r5, [r9, #0]	@  i,  <variable>.x
	str	r5, [r9, #44]	@  i,  <variable>.mapX
	str	r5, [r9, #48]	@  i,  <variable>.mapY
	str	r5, [r9, #12]	@  i,  <variable>.shape
	stmia	lr, {r0, r1, r2, r3}
	mov	r2, #16
	str	r2, [r4, #8]	@  characterWalkingRightBBox.xsize
	str	r5, [r4, #4]	@  i,  characterWalkingRightBBox.y
	ldr	r4, .L184+56
	str	r5, [r6, #4]	@  i,  characterWalkingLeftBBox.y
	str	r5, [r7, #4]	@  i,  characterStandingLeftBBox.y
	str	r5, [r9, #72]	@  i,  <variable>.noGravity
	str	r5, [r9, #76]	@  i,  <variable>.isProjectile
	ldr	r3, [r4, #0]	@  numberOfSprites
	add	r3, r3, #1
	str	r3, [r4, #0]	@  numberOfSprites
	mov	r0, #60
	ldr	r3, .L184+60
	str	sl, [r9, #116]	@  <variable>.dir
	str	sl, [r9, #80]	@  <variable>.speed
	str	r5, [r9, #84]	@  i,  <variable>.isRemoved
	mov	lr, pc
	bx	r3
	ldr	r3, .L184+64
	str	r0, [r3, #0]	@  enemySpriteIndex
	bl	WaitVBlank
	ldr	ip, .L184+52
	mov	r1, #128
	sub	r0, ip, #120
	bl	UpdateSpriteMemory
	ldr	r3, .L184+68
	mov	ip, #100663296
	ldr	r6, .L184+72
	ldr	r7, .L184+76
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
	ldr	r3, .L184+80
	mov	r1, #100663296
	ldr	r0, [r3, #0]	@  mapTiles
	mov	r2, #192
	mov	r3, #-2080374784
	bl	DMAFastCopy
	ldr	r3, .L184+84
	mov	r1, #100663296
	ldr	r0, [r3, #0]	@  hitMapTiles
	mov	r2, r8
	mov	r3, #-2080374784
	add	r1, r1, #32768
	bl	DMAFastCopy
	ldr	r3, .L184+88
	ldr	ip, [r3, #0]	@  map
	ldr	r3, .L184+92
	ldr	r6, [r6, #0]	@  bg0map
	ldr	r7, [r7, #0]	@  bg1map
	ldr	r3, [r3, #0]	@  hitMap
	mov	lr, r5	@  i,  i
.L163:
	mov	r1, lr, asl #1	@  i
	mov	r2, lr	@  i,  i
	mov	r0, #31	@  j
.L162:
	ldrh	r4, [r1, ip]	@ movhi
	strh	r4, [r2, r6]	@ movhi 
	ldrh	r4, [r1, r3]	@ movhi
	subs	r0, r0, #1	@  j,  j
	strh	r4, [r2, r7]	@ movhi 
	add	r1, r1, #2
	add	r2, r2, #2	@  i,  i
	bpl	.L162
	add	r5, r5, #1	@  i,  i
	cmp	r5, #31	@  i
	add	lr, lr, #64	@  i,  i
	ble	.L163
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
.L185:
	.align	2
.L184:
	.word	philPalette
	.word	philData
	.word	philFacingRightData
	.word	philFacingRight2Data
	.word	philFacingRight3Data
	.word	philJumpingData
	.word	laserData
	.word	sprites
	.word	characterStandingRightBBox
	.word	characterWalkingRightBBox
	.word	characterWalkingLeftBBox
	.word	characterStandingLeftBBox
	.word	characterSpriteIndex
	.word	sprites+120
	.word	numberOfSprites
	.word	SpawnEnemy
	.word	enemySpriteIndex
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
	@ args = 0, pretend = 0, frame = 140
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #396
	bl	keyPoll
	mov	r0, #64
	bl	keyHit
	mov	r1, #0
	cmp	r0, #0
	str	r1, [fp, #-180]	@  projectileMoveCounter
	beq	.L187
	ldr	r2, .L280
	ldr	r3, [r2, #0]	@  isJumping
	cmp	r3, r1
	bne	.L187
	ldr	r4, .L280+4
	ldr	r3, [r4, #0]	@  characterSpriteIndex
	ldr	r1, .L280+8
	add	r3, r3, r3, asl #4
	add	r3, r1, r3, asl #3
	mov	r2, #128
	str	r2, [r3, #68]	@  <variable>.location
	ldr	r2, .L280
	mov	r1, #1
	str	r1, [r2, #0]	@  isJumping
	ldr	r3, .L280+12
	ldr	r2, .L280+16
	mov	r1, #0
	str	r1, [r3, #0]	@  jumpDuration
	str	r1, [r2, #0]	@  walkingCounter
.L187:
	ldr	r2, .L280
	ldr	r3, [r2, #0]	@  isJumping
	cmp	r3, #0
	beq	.L188
	ldr	r5, .L280+12
	ldr	r3, [r5, #0]	@  jumpDuration
	cmp	r3, #19
	ble	.L268
.L188:
	ldr	r3, .L280+20
	mov	lr, pc
	bx	r3
.L189:
	mov	r0, #16
	bl	keyHeld
	cmp	r0, #0
	beq	.L190
	ldr	r1, .L280
	ldr	r3, [r1, #0]	@  isJumping
	cmp	r3, #0
	bne	.L254
	ldr	r3, .L280+16
	ldr	r2, .L280+24
	ldr	r1, [r3, #0]	@  walkingCounter
	smull	r3, r0, r2, r1
	mov	r3, r1, asr #31
	rsb	r3, r3, r0, asr #4
	add	r3, r3, r3, asl #2
	sub	r1, r1, r3, asl #3
	cmp	r1, #10
	beq	.L269
	cmp	r1, #20
	beq	.L270
	cmp	r1, #30
	beq	.L271
	cmp	r1, #0
	bne	.L254
	ldr	r4, .L280+4
	ldr	ip, [r4, #0]	@  characterSpriteIndex
	ldr	r1, .L280+8
	add	ip, ip, ip, asl #4
	add	ip, r1, ip, asl #3
.L264:
	mov	r3, #32
	str	r3, [ip, #68]	@  <variable>.location
	ldr	lr, .L280+28
.L257:
	ldmia	lr, {r0, r1, r2, r3}
	add	ip, ip, #120
	stmia	ip, {r0, r1, r2, r3}
.L191:
	ldr	r3, [r4, #0]	@  characterSpriteIndex
	ldr	r2, .L280+8
	add	r3, r3, r3, asl #4
	mov	r3, r3, asl #3
	ldr	ip, [r3, r2]	@  prevX,  <variable>.x
	add	r4, r3, r2
	mov	r6, #1	@  dir
	mov	r3, #0
	cmp	ip, #119	@  prevX
	str	r3, [r4, #60]	@  <variable>.hFlip
	str	r6, [r4, #116]	@  dir,  <variable>.dir
	mov	r7, r2
	ldr	r8, .L280+4
	ble	.L200
	ldr	r3, .L280+32
	mov	r2, #508
	ldr	r1, [r3, #0]	@  screenRight
	add	r2, r2, #2
	cmp	r1, r2
	ble	.L199
.L200:
	add	r1, r4, #8	@  dir
	mov	r2, #128
	ldr	r3, .L280+36
	mov	r0, sp
	mov	r5, ip	@  prevX,  prevX
	mov	lr, pc
	bx	r3
	ldmia	r4, {r2, r3}
	mov	r0, r4
	mov	r1, r6	@  dir
	ldr	ip, .L280+40
	mov	lr, pc
	bx	ip
	ldr	r3, [r8, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #4
	ldr	r2, [r7, r3, asl #3]	@  <variable>.x
	cmp	r5, r2	@  prevX
	ldrne	r2, .L280+16
	ldrne	r3, [r2, #0]	@  walkingCounter
	addne	r3, r3, #1
	strne	r3, [r2, #0]	@  walkingCounter
.L190:
	mov	r0, #32
	bl	keyHeld
	cmp	r0, #0
	beq	.L204
	ldr	r1, .L280
	ldr	r3, [r1, #0]	@  isJumping
	cmp	r3, #0
	bne	.L256
	ldr	r3, .L280+16
	ldr	r2, .L280+24
	ldr	r1, [r3, #0]	@  walkingCounter
	smull	r3, r0, r2, r1
	mov	r3, r1, asr #31
	rsb	r3, r3, r0, asr #4
	add	r3, r3, r3, asl #2
	sub	r1, r1, r3, asl #3
	cmp	r1, #10
	beq	.L272
	cmp	r1, #20
	beq	.L273
	cmp	r1, #30
	beq	.L274
	cmp	r1, #0
	bne	.L256
	ldr	r4, .L280+4
	ldr	ip, [r4, #0]	@  characterSpriteIndex
	ldr	r1, .L280+8
	add	ip, ip, ip, asl #4
	add	ip, r1, ip, asl #3
.L266:
	mov	r3, #32
	str	r3, [ip, #68]	@  <variable>.location
	ldr	lr, .L280+44
.L258:
	ldmia	lr, {r0, r1, r2, r3}
	add	ip, ip, #120
	stmia	ip, {r0, r1, r2, r3}
.L205:
	ldr	r3, [r4, #0]	@  characterSpriteIndex
	ldr	r2, .L280+8
	add	r3, r3, r3, asl #4
	mov	r3, r3, asl #3
	ldr	ip, [r3, r2]	@  prevX,  <variable>.x
	add	r4, r3, r2
	mov	r6, #0	@  dir
	mov	r3, #1
	cmp	ip, #120	@  prevX
	str	r3, [r4, #60]	@  <variable>.hFlip
	str	r6, [r4, #116]	@  dir,  <variable>.dir
	mov	r7, r2
	ldr	r8, .L280+4
	bgt	.L214
	ldr	r3, .L280+48
	ldr	r2, [r3, #0]	@  screenLeft
	cmp	r2, r6
	bne	.L213
.L214:
	add	r1, r4, #8	@  dir
	mov	r2, #128
	ldr	r3, .L280+36
	mov	r0, sp
	mov	r5, ip	@  prevX,  prevX
	mov	lr, pc
	bx	r3
	ldmia	r4, {r2, r3}
	mov	r0, r4
	mov	r1, r6	@  dir
	ldr	ip, .L280+40
	mov	lr, pc
	bx	ip
	ldr	r3, [r8, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #4
	ldr	r2, [r7, r3, asl #3]	@  <variable>.x
	cmp	r5, r2	@  prevX
	ldrne	r2, .L280+16
	ldrne	r3, [r2, #0]	@  walkingCounter
	addne	r3, r3, #1
	strne	r3, [r2, #0]	@  walkingCounter
.L204:
	mov	r0, #1
	bl	keyHit
	cmp	r0, #0
	bne	.L275
.L218:
	ldr	sl, .L280+8
	mov	r6, #0	@  i
	mov	r5, sl
	mov	r7, #127	@  i
.L237:
	ldr	r3, [r5, #76]	@  <variable>.isProjectile
	cmp	r3, #0
	beq	.L224
	ldr	r3, [r5, #84]	@  <variable>.isRemoved
	cmp	r3, #0
	beq	.L276
.L224:
	subs	r7, r7, #1	@  i,  i
	add	r6, r6, #136	@  i,  i
	add	r5, r5, #136
	bpl	.L237
	mov	r0, #32
	bl	keyHeld
	cmp	r0, #0
	bne	.L238
	mov	r0, #16
	bl	keyHeld
	cmp	r0, #0
	bne	.L238
	ldr	r1, .L280
	ldr	r3, [r1, #0]	@  isJumping
	cmp	r3, #0
	bne	.L238
	ldr	r3, .L280+4
	ldr	r2, [r3, #0]	@  characterSpriteIndex
	ldr	r3, .L280+8
	add	r2, r2, r2, asl #4
	add	lr, r3, r2, asl #3
	ldr	r2, [lr, #116]	@  <variable>.dir
	mov	r3, #32
	cmp	r2, #1
	str	r3, [lr, #68]	@  <variable>.location
	ldreq	ip, .L280+28
	beq	.L262
	cmp	r2, #0
	bne	.L238
	ldr	ip, .L280+44
.L262:
	ldmia	ip, {r0, r1, r2, r3}
	add	lr, lr, #120
	stmia	lr, {r0, r1, r2, r3}
.L238:
	bl	WaitVBlank
	ldr	r0, .L280+8
	mov	r1, #128
	bl	UpdateSpriteMemory
	ldr	r3, .L280+52
	ldr	r2, .L280+56
	ldrh	r0, [r3, #0]	@  regY
	ldrh	r1, [r2, #0]	@  regX
	mov	r3, #67108864
	strh	r0, [r3, #18]	@ movhi 
	strh	r1, [r3, #16]	@ movhi 
	mov	r3, #39936	@  n
	add	r3, r3, #64	@  n,  n
.L246:
	subs	r3, r3, #1	@  n,  n
	bne	.L246
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
.L276:
	ldr	r4, [r5, #116]	@  dir,  <variable>.dir
	add	r1, r5, #8	@  dir
	mov	r2, #128
	mov	r0, sp
	ldr	r8, .L280+36
	mov	lr, pc
	bx	r8
	mov	r1, r4	@  dir
	mov	r0, r5
	ldmia	r5, {r2, r3}
	ldr	ip, .L280+40
	mov	lr, pc
	bx	ip
	cmp	r9, #1	@  mapMoved
	beq	.L277
	cmp	r9, #0	@  mapMoved
	bne	.L231
	ldr	r3, [r5, #116]	@  <variable>.dir
	cmp	r3, #1
	beq	.L267
	cmp	r3, #0
	bne	.L231
	ldr	r1, [fp, #-180]	@  projectileMoveCounter
	ldr	r3, [r6, sl]	@  <variable>.x
	ldr	r2, [r5, #44]	@  <variable>.mapX
	rsb	r3, r1, r3
	rsb	r2, r1, r2
.L260:
	str	r3, [r6, sl]	@  <variable>.x
.L261:
	str	r2, [r5, #44]	@  <variable>.mapX
.L231:
	ldr	r4, .L280+60
	ldr	r1, [r4, #0]	@  enemySpriteIndex
	ldr	r2, .L280+8
	add	r1, r1, r1, asl #4
	add	r1, r2, r1, asl #3	@  dir
	add	r0, sp, #120
	mov	r2, #136
	mov	lr, pc
	bx	r8
	add	r1, r5, #16	@  dir
	mov	r2, #120
	mov	r0, sp
	mov	lr, pc
	bx	r8
	ldmia	r5, {r0, r1, r2, r3}
	ldr	ip, .L280+64
	mov	lr, pc
	bx	ip
	cmp	r0, #0
	beq	.L224
	mov	r0, r5
	ldr	r3, .L280+68
	mov	lr, pc
	bx	r3
	ldr	r0, [r4, #0]	@  enemySpriteIndex
	ldr	r1, .L280+8
	add	r0, r0, r0, asl #4
	add	r0, r1, r0, asl #3
	ldr	r2, .L280+68
	mov	lr, pc
	bx	r2
	b	.L224
.L267:
	ldr	r1, [fp, #-180]	@  projectileMoveCounter
	ldr	r3, [r6, sl]	@  <variable>.x
	ldr	r2, [r5, #44]	@  <variable>.mapX
	add	r3, r3, r1
	add	r2, r2, r1
	b	.L260
.L277:
	ldr	r3, [r5, #116]	@  <variable>.dir
	cmp	r3, #1
	beq	.L278
	cmp	r3, #0
	bne	.L231
	b	.L267
.L278:
	ldr	r1, .L280+8
	ldr	r2, [r5, #44]	@  <variable>.mapX
	ldr	r3, [r6, r1]	@  <variable>.x
	ldr	r1, [fp, #-180]	@  projectileMoveCounter
	rsb	r3, r1, r3
	rsb	r2, r1, r2
	ldr	r1, .L280+8
	str	r3, [r6, r1]	@  <variable>.x
	b	.L261
.L275:
	ldr	r3, .L280+4
	ldr	r1, [r3, #0]	@  characterSpriteIndex
	ldr	r3, .L280+8
	add	r1, r1, r1, asl #4
	add	r1, r3, r1, asl #3	@  dir
	sub	r0, fp, #176
	mov	r2, #136
	ldr	r3, .L280+36
	mov	lr, pc
	bx	r3
	ldr	ip, [fp, #-60]	@  character.dir
	cmp	ip, #1
	beq	.L279
	cmp	ip, #0
	bne	.L218
	sub	r0, fp, #176
	ldmia	r0, {r0, r1}	@ phole ldm
	ldr	r2, [fp, #-132]	@  character.mapX
	add	r0, r0, #2
	add	r1, r1, #7	@  dir
	add	r2, r2, #2
.L259:
	ldr	r3, [fp, #-128]	@  character.mapY
	str	ip, [sp, #0]
	add	r3, r3, #7
	ldr	ip, .L280+72
	mov	lr, pc
	bx	ip
	b	.L218
.L279:
	sub	r0, fp, #176
	ldmia	r0, {r0, r1}	@ phole ldm
	ldr	r2, [fp, #-132]	@  character.mapX
	add	r0, r0, #20
	add	r1, r1, #7	@  dir
	add	r2, r2, #20
	b	.L259
.L213:
	str	r6, [r4, #116]	@  dir,  <variable>.dir
	ldr	r2, .L280+76
	ldr	r5, [r4, #44]	@  prevX,  <variable>.mapX
	mov	lr, pc
	bx	r2
	ldr	r3, [r8, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #4
	add	r3, r7, r3, asl #3
	ldr	r1, [r3, #44]	@  <variable>.mapX
	cmp	r5, r1	@  prevX
	beq	.L204
	ldr	r2, .L280+16
	ldr	r3, [r2, #0]	@  walkingCounter
	rsb	r5, r1, r5	@  prevX
	add	r3, r3, #1
	str	r3, [r2, #0]	@  walkingCounter
	str	r5, [fp, #-180]	@  projectileMoveCounter
	mov	r9, r6	@  mapMoved,  dir
	b	.L204
.L256:
	ldr	r4, .L280+4
	b	.L205
.L274:
	ldr	r4, .L280+4
	ldr	ip, [r4, #0]	@  characterSpriteIndex
	ldr	r3, .L280+8
	add	ip, ip, ip, asl #4
	add	ip, r3, ip, asl #3
	mov	r3, #96
.L265:
	ldr	lr, .L280+80
	str	r3, [ip, #68]	@  <variable>.location
	b	.L258
.L273:
	ldr	r4, .L280+4
	ldr	ip, [r4, #0]	@  characterSpriteIndex
	ldr	r2, .L280+8
	add	ip, ip, ip, asl #4
	add	ip, r2, ip, asl #3
	b	.L266
.L272:
	ldr	r4, .L280+4
	ldr	ip, [r4, #0]	@  characterSpriteIndex
	ldr	r1, .L280+8
	add	ip, ip, ip, asl #4
	add	ip, r1, ip, asl #3
	mov	r3, #64
	b	.L265
.L199:
	str	r6, [r4, #116]	@  dir,  <variable>.dir
	ldr	r2, .L280+84
	ldr	r5, [r4, #44]	@  prevX,  <variable>.mapX
	mov	lr, pc
	bx	r2
	ldr	r3, [r8, #0]	@  characterSpriteIndex
	add	r3, r3, r3, asl #4
	add	r3, r7, r3, asl #3
	ldr	r1, [r3, #44]	@  <variable>.mapX
	cmp	r5, r1	@  prevX
	beq	.L190
	ldr	r2, .L280+16
	ldr	r3, [r2, #0]	@  walkingCounter
	rsb	r1, r5, r1	@  prevX
	add	r3, r3, #1
	str	r3, [r2, #0]	@  walkingCounter
	str	r1, [fp, #-180]	@  projectileMoveCounter
	mov	r9, r6	@  mapMoved,  dir
	b	.L190
.L254:
	ldr	r4, .L280+4
	b	.L191
.L271:
	ldr	r4, .L280+4
	ldr	ip, [r4, #0]	@  characterSpriteIndex
	ldr	r3, .L280+8
	add	ip, ip, ip, asl #4
	add	ip, r3, ip, asl #3
	mov	r3, #96
.L263:
	ldr	lr, .L280+88
	str	r3, [ip, #68]	@  <variable>.location
	b	.L257
.L270:
	ldr	r4, .L280+4
	ldr	ip, [r4, #0]	@  characterSpriteIndex
	ldr	r2, .L280+8
	add	ip, ip, ip, asl #4
	add	ip, r2, ip, asl #3
	b	.L264
.L269:
	ldr	r4, .L280+4
	ldr	ip, [r4, #0]	@  characterSpriteIndex
	ldr	r1, .L280+8
	add	ip, ip, ip, asl #4
	add	ip, r1, ip, asl #3
	mov	r3, #64
	b	.L263
.L268:
	ldr	r4, .L280+4
	ldr	r4, [r4, #0]	@  characterSpriteIndex
	ldr	r3, .L280+8
	add	r4, r4, r4, asl #4
	add	r4, r3, r4, asl #3
	add	r1, r4, #8	@  dir
	mov	r2, #128
	ldr	r3, .L280+36
	mov	r0, sp
	mov	lr, pc
	bx	r3
	ldmia	r4, {r2, r3}
	mov	r0, r4
	mov	r1, #2
	ldr	ip, .L280+40
	mov	lr, pc
	bx	ip
	ldr	r3, [r5, #0]	@  jumpDuration
	add	r3, r3, #1
	str	r3, [r5, #0]	@  jumpDuration
	b	.L189
.L281:
	.align	2
.L280:
	.word	isJumping
	.word	characterSpriteIndex
	.word	sprites
	.word	jumpDuration
	.word	walkingCounter
	.word	Gravity
	.word	1717986919
	.word	characterStandingRightBBox
	.word	screenRight
	.word	memcpy
	.word	Move
	.word	characterStandingLeftBBox
	.word	screenLeft
	.word	regY
	.word	regX
	.word	enemySpriteIndex
	.word	HitTest
	.word	RemoveSprite
	.word	Shoot
	.word	MoveMapLeft
	.word	characterWalkingLeftBBox
	.word	MoveMapRight
	.word	characterWalkingRightBBox
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
.L286:
	bl	Update
	b	.L286
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
	sub	fp, ip, #4
	sub	sp, sp, #120
	ldr	r6, .L303
	ldr	r3, [r6, #0]	@  numberOfSprites
	mov	r5, #0	@  i
	cmp	r5, r3	@  i
	bge	.L289
	ldr	r4, .L303+4
	mov	r7, r4
.L298:
	ldr	r3, [r4, #72]	@  <variable>.noGravity
	cmp	r3, #0
	add	r1, r4, #16
	mov	r2, #120
	mov	r0, sp
	add	r5, r5, #1	@  i,  i
	beq	.L301
.L290:
	ldr	r3, [r6, #0]	@  numberOfSprites
	cmp	r5, r3	@  i
	add	r4, r4, #136
	blt	.L298
.L289:
	ldmea	fp, {r4, r5, r6, r7, fp, sp, lr}
	bx	lr
.L301:
	ldr	r3, .L303+8
	mov	lr, pc
	bx	r3
	ldmia	r4, {r0, r1, r2, r3}
	ldr	ip, .L303+12
	mov	lr, pc
	bx	ip
	cmp	r0, #0
	beq	.L302
	ldr	r3, [r4, #4]	@  <variable>.y
	ldr	r2, [r4, #48]	@  <variable>.mapY
	add	r3, r3, #1
	add	r2, r2, #1
	str	r3, [r4, #4]	@  <variable>.y
	str	r2, [r4, #48]	@  <variable>.mapY
	b	.L290
.L302:
	ldr	r4, .L303+16
	ldr	r3, [r4, #0]	@  isJumping
	cmp	r3, #0
	beq	.L289
	ldr	r3, .L303+20
	ldr	r2, [r3, #0]	@  characterSpriteIndex
	add	r2, r2, r2, asl #4
	add	lr, r7, r2, asl #3
	ldr	r2, [lr, #116]	@  <variable>.dir
	mov	r3, #32
	cmp	r2, #1
	str	r3, [lr, #68]	@  <variable>.location
	ldreq	ip, .L303+24
	beq	.L300
	cmp	r2, #0
	bne	.L296
	ldr	ip, .L303+28
.L300:
	ldmia	ip, {r0, r1, r2, r3}
	add	lr, lr, #120
	stmia	lr, {r0, r1, r2, r3}
.L296:
	mov	r3, #0
	str	r3, [r4, #0]	@  isJumping
	b	.L289
.L304:
	.align	2
.L303:
	.word	numberOfSprites
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
	ldr	r3, .L306
	mov	r1, r1, asl #5
	add	r1, r1, r0, asr #3
	ldr	r2, [r3, #0]	@  bg1map
	mov	r1, r1, asl #1
	ldrh	r0, [r1, r2]	@  x
	@ lr needed for prologue
	bx	lr
.L307:
	.align	2
.L306:
	.word	bg1map
	.size	GetNextTile, .-GetNextTile
	.align	2
	.global	Shoot
	.type	Shoot, %function
Shoot:
	@ Function supports interworking.
	@ args = 4, pretend = 0, frame = 28
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
	sub	fp, ip, #4
	sub	sp, sp, #28
	str	r0, [fp, #-60]	@  startX
	str	r1, [fp, #-64]	@  startY
	ldr	r0, .L309
	mov	r1, #128
	mov	r8, r2	@  mapX
	str	r3, [fp, #-68]	@  mapY
	bl	GetNextFreePosition
	ldr	sl, .L309+4
	mov	r7, #0
	ldr	r5, [sl, #0]	@  numberOfSprites
	mov	r3, #8
	str	r3, [fp, #-44]	@  laserBBox.ysize
	str	r3, [fp, #-48]	@  laserBBox.xsize
	str	r7, [fp, #-56]	@  laserBBox.x
	str	r7, [fp, #-52]	@  laserBBox.y
	add	r4, r0, r0, asl #4	@  location,  location
	ldr	r3, .L309
	mov	r4, r4, asl #3
	sub	ip, fp, #56
	add	r5, r5, #1
	add	lr, r4, r3
	ldmia	ip, {r0, r1, r2, r3}
	str	r5, [sl, #0]	@  numberOfSprites
	ldr	ip, [fp, #-60]	@  startX
	ldr	r5, .L309
	str	ip, [r4, r5]	@  <variable>.x
	ldr	ip, [fp, #-68]	@  mapY
	ldr	r5, [fp, #-64]	@  startY
	str	ip, [lr, #48]	@  <variable>.mapY
	add	r6, lr, #120
	mov	ip, #160
	str	r5, [lr, #4]	@  <variable>.y
	str	r8, [lr, #44]	@  mapX,  <variable>.mapX
	str	ip, [lr, #68]	@  <variable>.location
	str	r7, [lr, #8]	@  <variable>.size
	str	r7, [lr, #12]	@  <variable>.shape
	stmia	r6, {r0, r1, r2, r3}
	ldr	r3, [fp, #4]	@  dir,  dir
	mov	r9, #1
	str	r3, [lr, #116]	@  dir,  <variable>.dir
	mov	r3, #5
	str	r9, [lr, #76]	@  <variable>.isProjectile
	str	r3, [lr, #80]	@  <variable>.speed
	str	r7, [lr, #84]	@  <variable>.isRemoved
	str	r9, [lr, #72]	@  <variable>.noGravity
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
.L310:
	.align	2
.L309:
	.word	sprites
	.word	numberOfSprites
	.size	Shoot, .-Shoot
	.align	2
	.global	Move
	.type	Move, %function
Move:
	@ Function supports interworking.
	@ args = 136, pretend = 8, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	sub	sp, sp, #8
	stmfd	sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub	fp, ip, #12
	sub	sp, sp, #120
	add	r4, fp, #4	@  direction
	cmp	r1, #1	@  direction
	mov	r5, r0	@  direction
	stmia	r4, {r2, r3}	@  direction
	beq	.L318
	bcc	.L313
	cmp	r1, #2	@  direction
	beq	.L322
.L328:
	ldr	r6, .L331
.L312:
	mov	r1, r4	@  direction
	mov	r0, r5	@  direction
	mov	r2, #136
	mov	lr, pc
	bx	r6
	mov	r0, r5	@  direction
	ldmea	fp, {r4, r5, r6, fp, sp, lr}
	bx	lr
.L322:
	ldr	r3, [fp, #52]	@  sprite.mapY
	cmp	r3, #0
	ble	.L328
	add	r1, fp, #20
	mov	r2, #120
	mov	r0, sp
	ldr	r6, .L331
	mov	lr, pc
	bx	r6
	ldmia	r4, {r0, r1, r2, r3}	@  direction
	ldr	ip, .L331+4
	mov	lr, pc
	bx	ip
	cmp	r0, #0	@  direction
	beq	.L312
	ldr	r2, [fp, #8]	@  sprite.y
	ldr	r3, [fp, #52]	@  sprite.mapY
	sub	r2, r2, #1
	sub	r3, r3, #1
	str	r2, [fp, #8]	@  sprite.y
	str	r3, [fp, #52]	@  sprite.mapY
	b	.L312
.L313:
	ldr	r3, [fp, #48]	@  sprite.mapX
	cmp	r3, #0
	ble	.L327
	add	r1, fp, #20
	mov	r2, #120
	mov	r0, sp
	ldr	r6, .L331
	mov	lr, pc
	bx	r6
	ldmia	r4, {r0, r1, r2, r3}	@  direction
	ldr	ip, .L331+8
	mov	lr, pc
	bx	ip
	cmp	r0, #0	@  direction
	beq	.L319
	ldr	r0, [fp, #84]	@  sprite.speed
	ldr	r1, [fp, #48]	@  sprite.mapX
	ldr	r2, [fp, #4]	@  sprite.x
	ldr	r3, [fp, #80]	@  sprite.isProjectile
	rsb	r1, r0, r1
	rsb	r2, r0, r2
	cmp	r3, #0
	str	r1, [fp, #48]	@  sprite.mapX
	str	r2, [fp, #4]	@  sprite.x
	beq	.L312
	cmp	r2, #0
	moveq	r0, r4	@  direction
	bne	.L312
.L330:
	ldr	r3, .L331+12
	mov	lr, pc
	bx	r3
	b	.L312
.L319:
	ldr	r3, [fp, #80]	@  sprite.isProjectile
	cmp	r3, #0
	beq	.L312
	add	r0, fp, #4
	b	.L330
.L327:
	ldr	r6, .L331
	b	.L319
.L318:
	mov	r3, #508
	ldr	r2, [fp, #48]	@  sprite.mapX
	add	r3, r3, #2
	cmp	r2, r3
	bgt	.L327
	add	r1, fp, #20
	mov	r2, #120
	mov	r0, sp
	ldr	r6, .L331
	mov	lr, pc
	bx	r6
	ldmia	r4, {r0, r1, r2, r3}	@  direction
	ldr	ip, .L331+16
	mov	lr, pc
	bx	ip
	cmp	r0, #0	@  direction
	beq	.L319
	ldr	r1, [fp, #84]	@  sprite.speed
	ldr	r2, [fp, #48]	@  sprite.mapX
	ldr	r3, [fp, #4]	@  sprite.x
	add	r2, r2, r1
	add	r3, r3, r1
	str	r3, [fp, #4]	@  sprite.x
	str	r2, [fp, #48]	@  sprite.mapX
	b	.L312
.L332:
	.align	2
.L331:
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
	sub	sp, sp, #120
	ldr	r9, .L338
	ldr	r3, [r9, #0]	@  screenLeft
	cmp	r3, #0
	ldr	r5, .L338+4
	ldr	r6, .L338+8
	mov	r2, #120
	mov	r0, sp
	ble	.L333
	ldr	r4, [r5, #0]	@  characterSpriteIndex
	add	r4, r4, r4, asl #4
	add	r4, r6, r4, asl #3
	add	r1, r4, #16
	ldr	r3, .L338+12
	mov	lr, pc
	bx	r3
	ldmia	r4, {r0, r1, r2, r3}
	ldr	ip, .L338+16
	mov	lr, pc
	bx	ip
	cmp	r0, #0
	beq	.L333
	ldr	r2, .L338+20
	ldr	ip, [r9, #0]	@  screenLeft
	ldr	r3, [r5, #0]	@  characterSpriteIndex
	ldr	r4, [r2, #0]	@  mapLeft
	ldr	r2, .L338+24
	sub	r7, ip, #1
	add	r3, r3, r3, asl #4
	ldr	lr, [r2, #0]	@  regX
	add	r8, r6, r3, asl #3
	ldr	r2, .L338+28
	mov	r3, r7, asr #31
	add	r3, r7, r3, lsr #29
	ldr	r5, [r2, #0]	@  screenRight
	mov	r6, r3, asr #3
	mov	r2, ip, asr #31
	ldr	r3, .L338+24
	add	ip, ip, r2, lsr #29
	sub	lr, lr, #1
	cmp	r4, #0
	mov	r0, r7
	mov	r1, r6
	mov	sl, ip, asr #3
	sub	r5, r5, #1
	sub	r4, r4, #1
	str	lr, [r3, #0]	@  regX
	ble	.L335
	ldr	ip, .L338+32
	ldr	r3, [ip, #0]	@  mapRight
	ldr	lr, .L338+20
	sub	r3, r3, #1
	str	r4, [lr, #0]	@  mapLeft
	str	r3, [ip, #0]	@  mapRight
.L335:
	ldr	r2, .L338+28
	ldr	r3, [r8, #44]	@  <variable>.mapX
	ldr	ip, [r8, #80]	@  <variable>.speed
	ldr	lr, .L338+36
	str	r5, [r2, #0]	@  screenRight
	ldr	r2, .L338+40
	rsb	r3, ip, r3
	cmp	r6, sl
	str	sl, [r2, #0]	@  prevColumn
	str	r7, [r9, #0]	@  screenLeft
	str	r6, [lr, #0]	@  nextColumn
	str	r3, [r8, #44]	@  <variable>.mapX
	blt	.L337
.L333:
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
.L337:
	ldr	r3, .L338+44
	ldr	ip, .L338+48
	ldr	r2, [r3, #0]	@  mapTop
	ldr	lr, .L338+52
	ldr	r3, [ip, #0]	@  mapBottom
	ldr	ip, .L338+56
	ldr	r4, [ip, #0]	@  map
	ldr	ip, [lr, #0]	@  bg0map
	mov	lr, #64
	stmia	sp, {r4, ip, lr}	@ phole stm
	ldr	ip, .L338+60
	mov	lr, pc
	bx	ip
	ldr	lr, .L338+36
	ldr	r3, .L338+44
	ldr	ip, .L338+48
	ldr	r1, [lr, #0]	@  nextColumn
	ldr	r2, [r3, #0]	@  mapTop
	ldr	lr, .L338+64
	ldr	r3, [ip, #0]	@  mapBottom
	ldr	ip, .L338+68
	ldr	r4, [ip, #0]	@  hitMap
	ldr	ip, [lr, #0]	@  bg1map
	mov	lr, #64
	str	ip, [sp, #4]
	ldr	r0, [r9, #0]	@  screenLeft
	str	r4, [sp, #0]
	str	lr, [sp, #8]
	ldr	ip, .L338+60
	mov	lr, pc
	bx	ip
	b	.L333
.L339:
	.align	2
.L338:
	.word	screenLeft
	.word	characterSpriteIndex
	.word	sprites
	.word	memcpy
	.word	CanMoveLeft
	.word	mapLeft
	.word	regX
	.word	screenRight
	.word	mapRight
	.word	nextColumn
	.word	prevColumn
	.word	mapTop
	.word	mapBottom
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
	sub	sp, sp, #120
	ldr	r7, .L345
	ldr	r3, [r7, #0]	@  screenRight
	mov	r5, #508
	add	r5, r5, #2
	cmp	r3, r5
	ldr	r6, .L345+4
	ldr	r8, .L345+8
	mov	r2, #120
	mov	r0, sp
	ble	.L344
.L340:
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
.L344:
	ldr	r4, [r6, #0]	@  characterSpriteIndex
	add	r4, r4, r4, asl #4
	add	r4, r8, r4, asl #3
	add	r1, r4, #16
	ldr	r3, .L345+12
	mov	lr, pc
	bx	r3
	ldmia	r4, {r0, r1, r2, r3}
	ldr	ip, .L345+16
	mov	lr, pc
	bx	ip
	cmp	r0, #0
	ldr	lr, .L345+20
	ldr	r4, .L345+24
	ldr	sl, .L345+28
	beq	.L340
	ldr	r0, [r4, #0]	@  mapRight
	ldr	r3, [r6, #0]	@  characterSpriteIndex
	ldr	r9, .L345+32
	cmp	r0, r5
	add	r3, r3, r3, asl #4
	add	r6, r8, r3, asl #3
	ldr	r2, [lr, #0]	@  regX
	ldrle	r3, [r9, #0]	@  mapLeft
	add	ip, r0, #1
	addle	r3, r3, #1
	add	r2, r2, #1
	str	r2, [lr, #0]	@  regX
	strle	ip, [r4, #0]	@  mapRight
	strle	r3, [r9, #0]	@  mapLeft
	ldr	ip, [r7, #0]	@  screenRight
	ldr	r4, [r6, #44]	@  <variable>.mapX
	ldr	r5, [r6, #80]	@  <variable>.speed
	add	lr, ip, #1
	ldr	r1, [sl, #0]	@  screenLeft
	mov	r3, ip, asr #31
	add	ip, ip, r3, lsr #29
	mov	r2, lr, asr #31
	ldr	r3, .L345+36
	add	r1, r1, #1
	mov	ip, ip, asr #3
	add	r2, lr, r2, lsr #29
	add	r4, r4, r5
	mov	r2, r2, asr #3
	str	r1, [sl, #0]	@  screenLeft
	str	r4, [r6, #44]	@  <variable>.mapX
	str	ip, [r3, #0]	@  prevColumn
	ldr	r3, .L345+40
	cmp	r2, ip
	mov	r0, lr
	mov	r1, r2
	str	lr, [r7, #0]	@  screenRight
	str	r2, [r3, #0]	@  nextColumn
	ble	.L340
	ldr	ip, .L345+44
	ldr	lr, .L345+48
	ldr	r2, [ip, #0]	@  mapTop
	ldr	r3, [lr, #0]	@  mapBottom
	ldr	ip, .L345+52
	ldr	lr, .L345+56
	ldr	r4, [ip, #0]	@  map
	ldr	ip, [lr, #0]	@  bg0map
	mov	lr, #64
	stmia	sp, {r4, ip, lr}	@ phole stm
	ldr	ip, .L345+60
	mov	lr, pc
	bx	ip
	ldr	lr, .L345+40
	ldr	r3, .L345+44
	ldr	ip, .L345+48
	ldr	r1, [lr, #0]	@  nextColumn
	ldr	r2, [r3, #0]	@  mapTop
	ldr	lr, .L345+64
	ldr	r3, [ip, #0]	@  mapBottom
	ldr	ip, .L345+68
	ldr	r4, [ip, #0]	@  hitMap
	ldr	ip, [lr, #0]	@  bg1map
	mov	lr, #64
	str	ip, [sp, #4]
	ldr	r0, [r7, #0]	@  screenRight
	str	r4, [sp, #0]
	str	lr, [sp, #8]
	ldr	ip, .L345+60
	mov	lr, pc
	bx	ip
	b	.L340
.L346:
	.align	2
.L345:
	.word	screenRight
	.word	characterSpriteIndex
	.word	sprites
	.word	memcpy
	.word	CanMoveRight
	.word	regX
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
	.word	bg1map
	.word	hitMap
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
	b	.L347
	.p2align 2
.L365:
	.word	.L349
	.word	.L373
	.word	.L357
	.word	.L374
.L349:
	ldr	r4, .L380
	ldr	r0, [r4, #0]	@  screenLeft
	cmp	r0, #0
	ble	.L373
	ldr	r2, .L380+4
	ldr	ip, .L380+8
	ldr	r3, [r2, #0]	@  regX
	ldr	r1, [ip, #0]	@  mapLeft
	sub	r3, r3, #1
	cmp	r1, #0
	str	r3, [r2, #0]	@  regX
	ble	.L351
	ldr	r3, .L380+12
	ldr	r2, [r3, #0]	@  mapRight
	sub	r1, r1, #1
	sub	r2, r2, #1
	str	r1, [ip, #0]	@  mapLeft
	str	r2, [r3, #0]	@  mapRight
.L351:
	sub	ip, r0, #1
	ldr	lr, .L380+16
	mov	r2, r0, asr #31
	mov	r1, ip, asr #31
	add	r2, r0, r2, lsr #29
	ldr	r3, .L380+20
	add	r1, ip, r1, lsr #29
	ldr	r0, [lr, #0]	@  screenRight
	mov	r2, r2, asr #3
	mov	r1, r1, asr #3
	cmp	r1, r2
	str	r2, [r3, #0]	@  prevColumn
	ldr	r3, .L380+24
	sub	r0, r0, #1
	movlt	r7, #1	@  moveLeft
	str	ip, [r4, #0]	@  screenLeft
	str	r0, [lr, #0]	@  screenRight
	str	r1, [r3, #0]	@  nextColumn
.L353:
	ldr	r4, [lr, #0]	@  screenRight
	mov	r0, #508
	add	r0, r0, #2
	cmp	r4, r0
	bgt	.L357
	ldr	r2, .L380+4
	ldr	ip, .L380+12
	ldr	r3, [r2, #0]	@  regX
	ldr	r1, [ip, #0]	@  mapRight
	add	r3, r3, #1
	cmp	r1, r0
	str	r3, [r2, #0]	@  regX
	bgt	.L355
	ldr	r3, .L380+8
	ldr	r2, [r3, #0]	@  mapLeft
	add	r1, r1, #1
	add	r2, r2, #1
	str	r1, [ip, #0]	@  mapRight
	str	r2, [r3, #0]	@  mapLeft
.L355:
	ldr	lr, .L380
	mov	r0, r4, asr #31
	ldr	r3, [lr, #0]	@  screenLeft
	add	ip, r4, #1
	ldr	r2, .L380+20
	add	r0, r4, r0, lsr #29
	mov	r0, r0, asr #3
	add	r3, r3, #1
	mov	r1, ip, asr #31
	add	r1, ip, r1, lsr #29
	str	r3, [lr, #0]	@  screenLeft
	str	r0, [r2, #0]	@  prevColumn
	ldr	r3, .L380+16
	ldr	r2, .L380+24
	mov	r1, r1, asr #3
	cmp	r1, r0
	str	ip, [r3, #0]	@  screenRight
	str	r1, [r2, #0]	@  nextColumn
	movgt	r5, #1	@  moveRight
.L357:
	ldr	r4, .L380+28
	ldr	r0, [r4, #0]	@  screenTop
	cmp	r0, #0
	ble	.L374
	ldr	r2, .L380+32
	ldr	ip, .L380+36
	ldr	r3, [r2, #0]	@  regY
	ldr	r1, [ip, #0]	@  mapTop
	sub	r3, r3, #1
	cmp	r1, #0
	str	r3, [r2, #0]	@  regY
	ble	.L359
	ldr	r3, .L380+40
	ldr	r2, [r3, #0]	@  mapBottom
	sub	r1, r1, #1
	sub	r2, r2, #1
	str	r1, [ip, #0]	@  mapTop
	str	r2, [r3, #0]	@  mapBottom
.L359:
	sub	ip, r0, #1
	ldr	lr, .L380+44
	mov	r2, r0, asr #31
	mov	r1, ip, asr #31
	add	r2, r0, r2, lsr #29
	ldr	r3, .L380+48
	add	r1, ip, r1, lsr #29
	ldr	r0, [lr, #0]	@  screenBottom
	mov	r2, r2, asr #3
	mov	r1, r1, asr #3
	cmp	r1, r2
	str	r2, [r3, #0]	@  prevRow
	ldr	r3, .L380+52
	sub	r0, r0, #1
	movlt	r8, #1	@  moveUp
	str	ip, [r4, #0]	@  screenTop
	str	r0, [lr, #0]	@  screenBottom
	str	r1, [r3, #0]	@  nextRow
.L361:
	ldr	r4, [lr, #0]	@  screenBottom
	mov	r0, #508
	add	r0, r0, #2
	cmp	r4, r0
	bgt	.L348
	ldr	r2, .L380+32
	ldr	ip, .L380+40
	ldr	r3, [r2, #0]	@  regY
	ldr	r1, [ip, #0]	@  mapBottom
	add	r3, r3, #1
	cmp	r1, r0
	str	r3, [r2, #0]	@  regY
	bgt	.L363
	ldr	r3, .L380+36
	ldr	r2, [r3, #0]	@  mapTop
	add	r1, r1, #1
	add	r2, r2, #1
	str	r2, [r3, #0]	@  mapTop
	str	r1, [ip, #0]	@  mapBottom
.L363:
	ldr	lr, .L380+28
	mov	r0, r4, asr #31
	ldr	r3, [lr, #0]	@  screenTop
	add	ip, r4, #1
	ldr	r2, .L380+48
	add	r0, r4, r0, lsr #29
	mov	r0, r0, asr #3
	add	r3, r3, #1
	mov	r1, ip, asr #31
	add	r1, ip, r1, lsr #29
	str	r3, [lr, #0]	@  screenTop
	str	r0, [r2, #0]	@  prevRow
	ldr	r3, .L380+44
	ldr	r2, .L380+52
	mov	r1, r1, asr #3
	cmp	r1, r0
	str	ip, [r3, #0]	@  screenBottom
	str	r1, [r2, #0]	@  nextRow
	movgt	r6, #1	@  moveDown
.L348:
	cmp	r7, #0	@  moveLeft
	bne	.L376
.L367:
	cmp	r5, #0	@  moveRight
	bne	.L377
.L368:
	cmp	r8, #0	@  moveUp
	bne	.L378
.L369:
	cmp	r6, #0	@  moveDown
	bne	.L379
.L347:
	ldmea	fp, {r4, r5, r6, r7, r8, fp, sp, lr}
	bx	lr
.L379:
	ldr	r3, .L380+44
	ldr	r2, .L380+52
	ldr	r0, [r3, #0]	@  direction,  screenBottom
	ldr	ip, .L380+12
	ldr	r3, .L380+8
	ldr	r1, [r2, #0]	@  nextRow
	ldr	lr, .L380+56
	ldr	r2, [r3, #0]	@  mapLeft
	ldr	r3, [ip, #0]	@  mapRight
	ldr	ip, .L380+60
	ldr	r4, [lr, #0]	@  map
	ldr	lr, [ip, #0]	@  bg0map
	mov	ip, #64
	stmia	sp, {r4, lr}	@ phole stm
	str	ip, [sp, #8]
	ldr	r4, .L380+64
	mov	lr, pc
	bx	r4
	b	.L347
.L378:
	ldr	r3, .L380+28
	ldr	r2, .L380+52
	ldr	r0, [r3, #0]	@  direction,  screenTop
	ldr	ip, .L380+12
	ldr	r3, .L380+8
	ldr	r1, [r2, #0]	@  nextRow
	ldr	lr, .L380+56
	ldr	r2, [r3, #0]	@  mapLeft
	ldr	r3, [ip, #0]	@  mapRight
	ldr	ip, .L380+60
	ldr	r4, [lr, #0]	@  map
	ldr	lr, [ip, #0]	@  bg0map
	mov	ip, #64
	stmia	sp, {r4, lr}	@ phole stm
	str	ip, [sp, #8]
	ldr	r4, .L380+64
	mov	lr, pc
	bx	r4
	b	.L369
.L377:
	ldr	r3, .L380+16
	ldr	r2, .L380+24
	ldr	r0, [r3, #0]	@  direction,  screenRight
	ldr	ip, .L380+40
	ldr	r3, .L380+36
	ldr	r1, [r2, #0]	@  nextColumn
	ldr	lr, .L380+56
	ldr	r2, [r3, #0]	@  mapTop
	ldr	r3, [ip, #0]	@  mapBottom
	ldr	ip, .L380+60
	ldr	r4, [lr, #0]	@  map
	ldr	lr, [ip, #0]	@  bg0map
	mov	ip, #64
	stmia	sp, {r4, lr}	@ phole stm
	str	ip, [sp, #8]
	ldr	r4, .L380+68
	mov	lr, pc
	bx	r4
	b	.L368
.L376:
	ldr	r3, .L380
	ldr	r2, .L380+24
	ldr	r0, [r3, #0]	@  direction,  screenLeft
	ldr	ip, .L380+40
	ldr	r3, .L380+36
	ldr	r1, [r2, #0]	@  nextColumn
	ldr	lr, .L380+56
	ldr	r2, [r3, #0]	@  mapTop
	ldr	r3, [ip, #0]	@  mapBottom
	ldr	ip, .L380+60
	ldr	r4, [lr, #0]	@  map
	ldr	lr, [ip, #0]	@  bg0map
	mov	ip, #64
	stmia	sp, {r4, lr}	@ phole stm
	str	ip, [sp, #8]
	ldr	r4, .L380+68
	mov	lr, pc
	bx	r4
	b	.L367
.L374:
	ldr	lr, .L380+44
	b	.L361
.L373:
	ldr	lr, .L380+16
	b	.L353
.L381:
	.align	2
.L380:
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
	subs	r0, r0, #2	@  x,  x
	movne	r0, #1	@  x
	ldmea	fp, {fp, sp, lr}
	bx	lr
	.size	CanMove, .-CanMove
	.align	2
	.global	CanMoveRight
	.type	CanMoveRight, %function
CanMoveRight:
	@ Function supports interworking.
	@ args = 136, pretend = 16, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	sub	sp, sp, #16
	stmfd	sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub	fp, ip, #20
	add	ip, fp, #4
	stmia	ip, {r0, r1, r2, r3}
	ldr	r2, [fp, #132]	@  sprite.boundingBox.xsize
	ldr	r3, [fp, #48]	@  sprite.mapX
	ldr	r1, [fp, #124]	@  sprite.boundingBox.x
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
	beq	.L383
	ldr	r4, [fp, #136]	@  sprite.boundingBox.ysize
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
	beq	.L383
	bl	CanMove
	cmp	r0, #0
	movne	r3, #1
	moveq	r3, #0
.L383:
	mov	r0, r3
	ldmea	fp, {r4, r5, r6, fp, sp, lr}
	bx	lr
	.size	CanMoveRight, .-CanMoveRight
	.align	2
	.global	CanMoveLeft
	.type	CanMoveLeft, %function
CanMoveLeft:
	@ Function supports interworking.
	@ args = 136, pretend = 16, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	sub	sp, sp, #16
	stmfd	sp!, {r4, r5, r6, fp, ip, lr, pc}
	sub	fp, ip, #20
	add	ip, fp, #4
	stmia	ip, {r0, r1, r2, r3}
	ldr	r2, [fp, #124]	@  sprite.boundingBox.x
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
	beq	.L387
	ldr	r4, [fp, #136]	@  sprite.boundingBox.ysize
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
	beq	.L387
	bl	CanMove
	cmp	r0, #0
	movne	r3, #1
	moveq	r3, #0
.L387:
	mov	r0, r3
	ldmea	fp, {r4, r5, r6, fp, sp, lr}
	bx	lr
	.size	CanMoveLeft, .-CanMoveLeft
	.align	2
	.global	CanMoveUp
	.type	CanMoveUp, %function
CanMoveUp:
	@ Function supports interworking.
	@ args = 136, pretend = 16, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	sub	sp, sp, #16
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	sub	fp, ip, #20
	add	ip, fp, #4
	stmia	ip, {r0, r1, r2, r3}
	ldr	r3, [fp, #124]	@  sprite.boundingBox.x
	add	r2, fp, #48
	ldmia	r2, {r2, r5}	@ phole ldm
	add	r4, r2, r3	@  x
	mov	r1, r5	@  y
	mov	r0, r4	@  x
	bl	CanMove
	cmp	r0, #0	@  x
	mov	r1, r5	@  y
	mov	r3, r0	@  x,  x
	beq	.L391
	ldr	r3, [fp, #132]	@  sprite.boundingBox.xsize
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
	beq	.L391
	bl	CanMove
	cmp	r0, #0	@  x
	movne	r3, #1	@  x
	moveq	r3, #0	@  x
.L391:
	mov	r0, r3	@  x
	ldmea	fp, {r4, r5, fp, sp, lr}
	bx	lr
	.size	CanMoveUp, .-CanMoveUp
	.align	2
	.global	CanMoveDown
	.type	CanMoveDown, %function
CanMoveDown:
	@ Function supports interworking.
	@ args = 136, pretend = 16, frame = 0
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	sub	sp, sp, #16
	stmfd	sp!, {r4, r5, fp, ip, lr, pc}
	sub	fp, ip, #20
	add	ip, fp, #4
	stmia	ip, {r0, r1, r2, r3}
	ldr	r2, [fp, #52]	@  sprite.mapY
	ldr	r3, [fp, #136]	@  sprite.boundingBox.ysize
	ldr	r1, [fp, #48]	@  sprite.mapX
	add	r5, r2, r3	@  y
	ldr	r3, [fp, #124]	@  sprite.boundingBox.x
	add	r4, r1, r3	@  x
	mov	r0, r4	@  x
	mov	r1, r5	@  y
	bl	CanMove
	cmp	r0, #0	@  x
	mov	r1, r5	@  y
	mov	r3, r0	@  x,  x
	beq	.L395
	ldr	r3, [fp, #132]	@  sprite.boundingBox.xsize
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
	beq	.L395
	bl	CanMove
	cmp	r0, #0	@  x
	movne	r3, #1	@  x
	moveq	r3, #0	@  x
.L395:
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
	str	r3, [r0, #84]	@  <variable>.isRemoved
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
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 1, uses_anonymous_args = 0
	mov	ip, sp
	stmfd	sp!, {r4, r5, r6, r7, r8, r9, sl, fp, ip, lr, pc}
	ldr	r8, .L401	@  mapX
	sub	fp, ip, #4
	sub	sp, sp, #8
	str	r0, [fp, #-44]	@  mapX
	str	r1, [fp, #-48]	@  mapY
	mov	r0, r8	@  mapX
	mov	r1, #128
	bl	GetNextFreePosition
	ldr	r9, .L401+4
	ldr	ip, .L401+8
	add	lr, r0, r0, asl #4	@  location,  location
	ldr	r5, [r9, #0]	@  numberOfSprites
	mov	sl, r0	@  location
	mov	lr, lr, asl #3
	ldmia	ip, {r0, r1, r2, r3}
	mov	ip, #60
	str	ip, [lr, r8]	@  <variable>.x
	ldr	ip, [fp, #-44]	@  mapX
	add	r4, lr, r8	@  mapX
	add	r5, r5, #1
	str	r5, [r9, #0]	@  numberOfSprites
	str	ip, [r4, #44]	@  <variable>.mapX
	ldr	ip, [fp, #-48]	@  mapY
	mov	r7, #0
	str	ip, [r4, #48]	@  <variable>.mapY
	add	r6, r4, #120
	mov	ip, #32768
	mov	lr, #32
	str	ip, [r4, #8]	@  <variable>.size
	str	lr, [r4, #68]	@  <variable>.location
	str	r7, [r4, #4]	@  <variable>.y
	str	r7, [r4, #12]	@  <variable>.shape
	stmia	r6, {r0, r1, r2, r3}
	mov	r3, #1
	mov	r0, sl	@  location
	str	r3, [r4, #116]	@  <variable>.dir
	str	r7, [r4, #84]	@  <variable>.isRemoved
	str	r7, [r4, #72]	@  <variable>.noGravity
	str	r7, [r4, #76]	@  <variable>.isProjectile
	str	r3, [r4, #80]	@  <variable>.speed
	ldmea	fp, {r4, r5, r6, r7, r8, r9, sl, fp, sp, lr}
	bx	lr
.L402:
	.align	2
.L401:
	.word	sprites
	.word	numberOfSprites
	.word	characterStandingRightBBox
	.size	SpawnEnemy, .-SpawnEnemy
	.align	2
	.global	HitTest
	.type	HitTest, %function
HitTest:
	@ Function supports interworking.
	@ args = 272, pretend = 16, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	sub	sp, sp, #16
	stmia	sp, {r0, r1, r2, r3}
	ldr	r1, [sp, #136]	@  sprite2.x
	cmp	r0, r1
	@ lr needed for prologue
	ble	.L404
	ldr	r3, [sp, #264]	@  sprite2.boundingBox.xsize
	add	r3, r1, r3
	cmp	r0, r3
	bge	.L404
	ldr	r1, [sp, #4]	@  sprite1.y
	ldr	r2, [sp, #140]	@  sprite2.y
	cmp	r1, r2
	ble	.L404
	ldr	r3, [sp, #268]	@  sprite2.boundingBox.ysize
	add	r3, r2, r3
	cmp	r1, r3
	mov	r0, #1
	blt	.L403
.L404:
	mov	r0, #0
.L403:
	add	sp, sp, #16
	bx	lr
	.size	HitTest, .-HitTest
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
	bge	.L413
	mla	r2, r1, ip, r0	@  sourceColumns,  row,  column
	ldr	r3, [sp, #12]	@  source,  source
	mov	r1, r1, asl #1	@  sourceColumns
	add	r0, r3, r2, asl #1	@  source
.L411:
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
	blt	.L411
.L413:
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
	bge	.L421
	ldr	r3, [sp, #24]	@  sourceColumns,  sourceColumns
	mla	r2, r3, r0, ip	@  sourceColumns,  row,  column
	mov	r1, r4, asl #5	@  copyToRow
	mov	r0, r2, asl #1
.L419:
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
	blt	.L419
.L421:
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
	ldr	r3, .L423
	mov	r0, r0, asl #22
	mov	r0, r0, lsr #22
	ldrsh	r0, [r0, r3]	@  angle,  sin_lut
	@ lr needed for prologue
	bx	lr
.L424:
	.align	2
.L423:
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
	ldr	r3, .L426
	mov	r0, r0, lsr #23
	mov	r0, r0, asl #1
	ldrsh	r0, [r0, r3]	@  angle,  sin_lut
	@ lr needed for prologue
	bx	lr
.L427:
	.align	2
.L426:
	.word	sin_lut
	.size	Cos_val, .-Cos_val
	.comm	buttons, 40, 32
	.comm	curr_state, 2, 16
	.comm	prev_state, 2, 16
	.comm	bg0map, 4, 32
	.comm	bg1map, 4, 32
	.comm	sprites, 17408, 32
	.comm	numberOfSprites, 4, 32
	.comm	jumpDuration, 4, 32
	.comm	characterSpriteIndex, 4, 32
	.comm	enemySpriteIndex, 4, 32
	.comm	characterWalkingRightBBox, 16, 32
	.comm	characterStandingRightBBox, 16, 32
	.comm	characterWalkingLeftBBox, 16, 32
	.comm	characterStandingLeftBBox, 16, 32
	.ident	"GCC: (GNU) 3.3.2"
