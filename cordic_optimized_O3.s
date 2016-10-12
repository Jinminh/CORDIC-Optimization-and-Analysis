	.arch armv4t
	.fpu softvfp
	.eabi_attribute 20, 1
	.eabi_attribute 21, 1
	.eabi_attribute 23, 3
	.eabi_attribute 24, 1
	.eabi_attribute 25, 1
	.eabi_attribute 26, 2
	.eabi_attribute 30, 2
	.eabi_attribute 18, 4
	.file	"cordic_optimized.c"
	.global	__aeabi_i2d
	.global	__aeabi_dmul
	.text
	.align	2
	.global	fixed_to_float
	.type	fixed_to_float, %function
fixed_to_float:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	bl	__aeabi_i2d
	mov	r3, #1048576000
	mov	r2, #0
	add	r3, r3, #3145728
	bl	__aeabi_dmul
	ldmfd	sp!, {r4, lr}
	bx	lr
	.size	fixed_to_float, .-fixed_to_float
	.align	2
	.global	angle_fixed_to_float
	.type	angle_fixed_to_float, %function
angle_fixed_to_float:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r3, #1056964608
	bl	__aeabi_dmul
	mov	r3, #1073741824
	add	r3, r3, #4587520
	mov	r2, #0
	add	r3, r3, #32768
	bl	__aeabi_dmul
	ldmfd	sp!, {r4, lr}
	bx	lr
	.size	angle_fixed_to_float, .-angle_fixed_to_float
	.global	__aeabi_d2iz
	.align	2
	.global	float_to_fixed
	.type	float_to_fixed, %function
float_to_fixed:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r3, #1090519040
	stmfd	sp!, {r4, lr}
	mov	r2, #0
	add	r3, r3, #3145728
	bl	__aeabi_dmul
	bl	__aeabi_d2iz
	ldmfd	sp!, {r4, lr}
	bx	lr
	.size	float_to_fixed, .-float_to_fixed
	.global	__aeabi_ddiv
	.align	2
	.global	angle_float_to_fixed
	.type	angle_float_to_fixed, %function
angle_float_to_fixed:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	mov	r3, #1073741824
	add	r3, r3, #4587520
	stmfd	sp!, {r4, lr}
	mov	r2, #0
	add	r3, r3, #32768
	bl	__aeabi_ddiv
	mov	r3, #1073741824
	mov	r2, #0
	add	r3, r3, #14680064
	bl	__aeabi_dmul
	bl	__aeabi_d2iz
	ldmfd	sp!, {r4, lr}
	bx	lr
	.size	angle_float_to_fixed, .-angle_float_to_fixed
	.align	2
	.global	cordic_rotation
	.type	cordic_rotation, %function
cordic_rotation:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8, sl}
	ldr	r5, .L43
	mov	r4, r5
	sub	sp, sp, #32
	mov	r8, r1
	mov	r6, r2
	mov	r7, r3
	mov	sl, r0
	ldmia	r4!, {r0, r1, r2, r3}
	mov	ip, sp
	stmia	ip!, {r0, r1, r2, r3}
	mov	r5, r0
	ldmia	r4, {r0, r1, r2, r3}
	cmp	r7, #0
	stmia	ip, {r0, r1, r2, r3}
	mov	r3, r5, lsr #16
	rsbge	r3, r3, r7
	addlt	r3, r7, r3
	mov	r4, r5, asl #16
	rsbge	r1, r6, r8
	addlt	r1, r6, r8
	addge	r2, r6, r8
	rsblt	r2, r8, r6
	ldr	ip, [sp, #4]
	cmp	r3, #0
	mov	r4, r4, lsr #16
	rsbge	r3, r4, r3
	addlt	r3, r3, r4
	addge	r0, r2, r1, asr #1
	sublt	r0, r2, r1, asr #1
	subge	r1, r1, r2, asr #1
	addlt	r1, r1, r2, asr #1
	mov	r5, ip, asl #16
	cmp	r3, #0
	mov	ip, ip, lsr #16
	rsbge	r3, ip, r3
	addlt	r3, r3, ip
	addge	r2, r0, r1, asr #2
	sublt	r2, r0, r1, asr #2
	subge	r1, r1, r0, asr #2
	addlt	r1, r1, r0, asr #2
	ldr	r4, [sp, #8]
	cmp	r3, #0
	mov	r5, r5, lsr #16
	rsbge	r3, r5, r3
	addlt	r3, r3, r5
	addge	r0, r2, r1, asr #3
	sublt	r0, r2, r1, asr #3
	subge	r1, r1, r2, asr #3
	addlt	r1, r1, r2, asr #3
	mov	ip, r4, lsr #16
	cmp	r3, #0
	rsbge	r3, ip, r3
	addlt	r3, r3, ip
	mov	r5, r4, asl #16
	addge	r2, r0, r1, asr #4
	sublt	r2, r0, r1, asr #4
	subge	r1, r1, r0, asr #4
	addlt	r1, r1, r0, asr #4
	ldr	r4, [sp, #12]
	cmp	r3, #0
	mov	r5, r5, lsr #16
	rsbge	r3, r5, r3
	addlt	r3, r3, r5
	addge	r0, r2, r1, asr #5
	sublt	r0, r2, r1, asr #5
	subge	r1, r1, r2, asr #5
	addlt	r1, r1, r2, asr #5
	mov	ip, r4, lsr #16
	cmp	r3, #0
	rsbge	r3, ip, r3
	addlt	r3, r3, ip
	mov	r5, r4, asl #16
	addge	r2, r0, r1, asr #6
	sublt	r2, r0, r1, asr #6
	subge	r1, r1, r0, asr #6
	addlt	r1, r1, r0, asr #6
	ldr	r4, [sp, #16]
	cmp	r3, #0
	mov	r5, r5, lsr #16
	rsbge	r3, r5, r3
	addlt	r3, r3, r5
	addge	r0, r2, r1, asr #7
	sublt	r0, r2, r1, asr #7
	subge	r1, r1, r2, asr #7
	addlt	r1, r1, r2, asr #7
	mov	ip, r4, lsr #16
	cmp	r3, #0
	addlt	r3, r3, ip
	rsbge	r3, ip, r3
	mov	r5, r4, asl #16
	sublt	r2, r0, r1, asr #8
	addge	r2, r0, r1, asr #8
	addlt	r1, r1, r0, asr #8
	subge	r1, r1, r0, asr #8
	ldr	r4, [sp, #20]
	cmp	r3, #0
	mov	r5, r5, lsr #16
	addlt	r3, r3, r5
	rsbge	r3, r5, r3
	sublt	r0, r2, r1, asr #9
	addge	r0, r2, r1, asr #9
	addlt	r1, r1, r2, asr #9
	subge	r1, r1, r2, asr #9
	mov	ip, r4, lsr #16
	cmp	r3, #0
	addlt	r3, r3, ip
	rsbge	r3, ip, r3
	mov	r5, r4, asl #16
	sublt	r2, r0, r1, asr #10
	addge	r2, r0, r1, asr #10
	addlt	r1, r1, r0, asr #10
	subge	r1, r1, r0, asr #10
	ldr	r4, [sp, #24]
	cmp	r3, #0
	mov	r5, r5, lsr #16
	addlt	r3, r3, r5
	rsbge	r3, r5, r3
	sublt	r0, r2, r1, asr #11
	addge	r0, r2, r1, asr #11
	addlt	r1, r1, r2, asr #11
	subge	r1, r1, r2, asr #11
	mov	ip, r4, lsr #16
	cmp	r3, #0
	addlt	r3, r3, ip
	rsbge	r3, ip, r3
	mov	r5, r4, asl #16
	sublt	r2, r0, r1, asr #12
	addge	r2, r0, r1, asr #12
	addlt	r1, r1, r0, asr #12
	subge	r1, r1, r0, asr #12
	ldr	r4, [sp, #28]
	cmp	r3, #0
	mov	r5, r5, lsr #16
	addlt	r3, r3, r5
	rsbge	r3, r5, r3
	sublt	r0, r2, r1, asr #13
	addge	r0, r2, r1, asr #13
	addlt	r1, r1, r2, asr #13
	subge	r1, r1, r2, asr #13
	mov	r5, r4, lsr #16
	cmp	r3, #0
	addlt	r3, r3, r5
	rsbge	r3, r5, r3
	sublt	r2, r0, r1, asr #14
	addge	r2, r0, r1, asr #14
	addlt	r1, r1, r0, asr #14
	subge	r1, r1, r0, asr #14
	cmp	r3, #0
	sublt	r3, r2, r1, asr #15
	addge	r3, r2, r1, asr #15
	addlt	r1, r1, r2, asr #15
	subge	r1, r1, r2, asr #15
	stmia	sl, {r1, r3}	@ phole stm
	mov	r0, sl
	add	sp, sp, #32
	ldmfd	sp!, {r4, r5, r6, r7, r8, sl}
	bx	lr
.L44:
	.align	2
.L43:
	.word	.LANCHOR0
	.size	cordic_rotation, .-cordic_rotation
	.align	2
	.global	cordic_vector
	.type	cordic_vector, %function
cordic_vector:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 32
	@ frame_needed = 0, uses_anonymous_args = 0
	@ link register save eliminated.
	stmfd	sp!, {r4, r5, r6, r7, r8}
	ldr	ip, .L79
	sub	sp, sp, #36
	mov	r6, r0
	mov	r7, r1
	mov	r8, r2
	ldmia	ip!, {r0, r1, r2, r3}
	mov	r4, sp
	stmia	r4!, {r0, r1, r2, r3}
	mov	r5, r0
	ldmia	ip, {r0, r1, r2, r3}
	cmp	r6, #0
	stmia	r4, {r0, r1, r2, r3}
	addlt	r1, r6, r7
	rsbge	r1, r7, r6
	mov	r2, r5, lsr #16
	rsblt	r0, r6, r7
	addge	r0, r7, r6
	rsblt	r2, r2, r8
	addge	r2, r8, r2
	mov	ip, r5, asl #16
	cmp	r1, #0
	addlt	r3, r1, r0, asr #1
	subge	r3, r1, r0, asr #1
	mov	ip, ip, lsr #16
	ldr	r4, [sp, #4]
	sublt	r0, r0, r1, asr #1
	addge	r0, r0, r1, asr #1
	rsblt	ip, ip, r2
	addge	ip, r2, ip
	cmp	r3, #0
	addlt	r1, r3, r0, asr #2
	subge	r1, r3, r0, asr #2
	mov	r5, r4, lsr #16
	sublt	r0, r0, r3, asr #2
	addge	r0, r0, r3, asr #2
	rsblt	r5, r5, ip
	addge	r5, ip, r5
	mov	r2, r4, asl #16
	cmp	r1, #0
	addlt	r3, r1, r0, asr #3
	subge	r3, r1, r0, asr #3
	ldr	r4, [sp, #8]
	mov	r2, r2, lsr #16
	sublt	r0, r0, r1, asr #3
	addge	r0, r0, r1, asr #3
	rsblt	ip, r2, r5
	addge	ip, r5, r2
	cmp	r3, #0
	addlt	r1, r3, r0, asr #4
	subge	r1, r3, r0, asr #4
	mov	r5, r4, lsr #16
	sublt	r0, r0, r3, asr #4
	addge	r0, r0, r3, asr #4
	rsblt	r5, r5, ip
	addge	r5, ip, r5
	mov	r2, r4, asl #16
	cmp	r1, #0
	addlt	r3, r1, r0, asr #5
	subge	r3, r1, r0, asr #5
	ldr	r4, [sp, #12]
	mov	r2, r2, lsr #16
	sublt	r0, r0, r1, asr #5
	addge	r0, r0, r1, asr #5
	rsblt	ip, r2, r5
	addge	ip, r5, r2
	cmp	r3, #0
	addlt	r1, r3, r0, asr #6
	subge	r1, r3, r0, asr #6
	mov	r5, r4, lsr #16
	sublt	r0, r0, r3, asr #6
	addge	r0, r0, r3, asr #6
	rsblt	r5, r5, ip
	addge	r5, ip, r5
	mov	r2, r4, asl #16
	cmp	r1, #0
	addlt	r3, r1, r0, asr #7
	subge	r3, r1, r0, asr #7
	ldr	r4, [sp, #16]
	mov	r2, r2, lsr #16
	sublt	r0, r0, r1, asr #7
	addge	r0, r0, r1, asr #7
	rsblt	ip, r2, r5
	addge	ip, r5, r2
	cmp	r3, #0
	subge	r1, r3, r0, asr #8
	addlt	r1, r3, r0, asr #8
	mov	r5, r4, lsr #16
	addge	r0, r0, r3, asr #8
	sublt	r0, r0, r3, asr #8
	addge	r5, ip, r5
	rsblt	r5, r5, ip
	mov	r2, r4, asl #16
	cmp	r1, #0
	subge	r3, r1, r0, asr #9
	addlt	r3, r1, r0, asr #9
	ldr	r4, [sp, #20]
	mov	r2, r2, lsr #16
	addge	r0, r0, r1, asr #9
	sublt	r0, r0, r1, asr #9
	addge	ip, r5, r2
	rsblt	ip, r2, r5
	cmp	r3, #0
	subge	r1, r3, r0, asr #10
	addlt	r1, r3, r0, asr #10
	mov	r5, r4, lsr #16
	addge	r0, r0, r3, asr #10
	sublt	r0, r0, r3, asr #10
	addge	r5, ip, r5
	rsblt	r5, r5, ip
	mov	r2, r4, asl #16
	cmp	r1, #0
	subge	r3, r1, r0, asr #11
	addlt	r3, r1, r0, asr #11
	ldr	r4, [sp, #24]
	mov	r2, r2, lsr #16
	addge	r0, r0, r1, asr #11
	sublt	r0, r0, r1, asr #11
	addge	ip, r5, r2
	rsblt	ip, r2, r5
	cmp	r3, #0
	subge	r1, r3, r0, asr #12
	addlt	r1, r3, r0, asr #12
	mov	r5, r4, lsr #16
	addge	r0, r0, r3, asr #12
	sublt	r0, r0, r3, asr #12
	addge	r5, ip, r5
	rsblt	r5, r5, ip
	mov	r2, r4, asl #16
	cmp	r1, #0
	subge	r3, r1, r0, asr #13
	addlt	r3, r1, r0, asr #13
	mov	r2, r2, lsr #16
	ldr	r4, [sp, #28]
	addge	r0, r0, r1, asr #13
	sublt	r0, r0, r1, asr #13
	addge	ip, r5, r2
	rsblt	ip, r2, r5
	cmp	r3, #0
	subge	r1, r3, r0, asr #14
	addlt	r1, r3, r0, asr #14
	mov	r5, r4, lsr #16
	mov	r2, r4, asl #16
	addge	r0, ip, r5
	rsblt	r0, r5, ip
	mov	r2, r2, lsr #16
	cmp	r1, #0
	addge	r0, r0, r2
	rsblt	r0, r2, r0
	add	sp, sp, #36
	ldmfd	sp!, {r4, r5, r6, r7, r8}
	bx	lr
.L80:
	.align	2
.L79:
	.word	.LANCHOR0+32
	.size	cordic_vector, .-cordic_vector
	.global	__aeabi_f2d
	.global	__aeabi_d2f
	.align	2
	.global	cos_cordic
	.type	cos_cordic, %function
cos_cordic:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	sub	sp, sp, #12
	bl	__aeabi_f2d
	mov	r3, #1073741824
	add	r3, r3, #4587520
	mov	r2, #0
	add	r3, r3, #32768
	bl	__aeabi_ddiv
	mov	r3, #1073741824
	mov	r2, #0
	add	r3, r3, #14680064
	bl	__aeabi_dmul
	bl	__aeabi_d2iz
	mov	r2, #0
	mov	r3, r0
	mov	r1, #1048576
	mov	r0, sp
	bl	cordic_rotation
	ldr	r0, [sp, #0]
	bl	__aeabi_i2d
	mov	r3, #1048576000
	mov	r2, #0
	add	r3, r3, #3145728
	bl	__aeabi_dmul
	adr	r3, .L83
	ldmia	r3, {r2-r3}
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	add	sp, sp, #12
	ldr	lr, [sp], #4
	bx	lr
.L84:
	.align	3
.L83:
	.word	-1257819312
	.word	1071869597
	.size	cos_cordic, .-cos_cordic
	.align	2
	.global	sin_cordic
	.type	sin_cordic, %function
sin_cordic:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	str	lr, [sp, #-4]!
	sub	sp, sp, #12
	bl	__aeabi_f2d
	mov	r3, #1073741824
	add	r3, r3, #4587520
	mov	r2, #0
	add	r3, r3, #32768
	bl	__aeabi_ddiv
	mov	r3, #1073741824
	mov	r2, #0
	add	r3, r3, #14680064
	bl	__aeabi_dmul
	bl	__aeabi_d2iz
	mov	r2, #0
	mov	r3, r0
	mov	r1, #1048576
	mov	r0, sp
	bl	cordic_rotation
	ldr	r0, [sp, #4]
	bl	__aeabi_i2d
	mov	r3, #1048576000
	mov	r2, #0
	add	r3, r3, #3145728
	bl	__aeabi_dmul
	adr	r3, .L87
	ldmia	r3, {r2-r3}
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	add	sp, sp, #12
	ldr	lr, [sp], #4
	bx	lr
.L88:
	.align	3
.L87:
	.word	-1257819312
	.word	1071869597
	.size	sin_cordic, .-sin_cordic
	.align	2
	.global	arctan_div_cordic
	.type	arctan_div_cordic, %function
arctan_div_cordic:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, r7, r8, lr}
	mov	r5, #1090519040
	mov	r4, #0
	add	r5, r5, #3145728
	mov	r6, r1
	bl	__aeabi_f2d
	mov	r2, r4
	mov	r3, r5
	bl	__aeabi_dmul
	bl	__aeabi_d2iz
	mov	r7, r0
	mov	r0, r6
	bl	__aeabi_f2d
	mov	r3, r5
	mov	r2, r4
	bl	__aeabi_dmul
	bl	__aeabi_d2iz
	mov	r2, #0
	mov	r1, r0
	mov	r0, r7
	bl	cordic_vector
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r3, #1056964608
	bl	__aeabi_dmul
	mov	r3, #1073741824
	add	r3, r3, #4587520
	mov	r2, #0
	add	r3, r3, #32768
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	ldmfd	sp!, {r4, r5, r6, r7, r8, lr}
	bx	lr
	.size	arctan_div_cordic, .-arctan_div_cordic
	.align	2
	.global	arctan_cordic
	.type	arctan_cordic, %function
arctan_cordic:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 0
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, lr}
	bl	__aeabi_f2d
	mov	r3, #1090519040
	add	r3, r3, #3145728
	mov	r2, #0
	bl	__aeabi_dmul
	bl	__aeabi_d2iz
	mov	r2, #0
	mov	r1, #1048576
	bl	cordic_vector
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r3, #1056964608
	bl	__aeabi_dmul
	mov	r3, #1073741824
	add	r3, r3, #4587520
	mov	r2, #0
	add	r3, r3, #32768
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	ldmfd	sp!, {r4, lr}
	bx	lr
	.size	arctan_cordic, .-arctan_cordic
	.align	2
	.global	main
	.type	main, %function
main:
	@ Function supports interworking.
	@ args = 0, pretend = 0, frame = 8
	@ frame_needed = 0, uses_anonymous_args = 0
	stmfd	sp!, {r4, r5, r6, lr}
	sub	sp, sp, #8
	bl	clock
	mov	r5, #0
	mov	r4, sp
	mov	r6, r0
.L94:
	mov	r2, #0
	mov	r3, #728
	mov	r0, sp
	mov	r1, #1048576
	bl	cordic_rotation
	ldr	r0, [sp, #0]
	bl	__aeabi_i2d
	mov	r3, #1048576000
	mov	r2, #0
	add	r3, r3, #3145728
	bl	__aeabi_dmul
	adr	r3, .L98
	ldmia	r3, {r2-r3}
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L98+8
	bl	printf
	mov	r3, #14528
	add	r3, r3, #35
	mov	r2, #0
	mov	r0, sp
	mov	r1, #1048576
	bl	cordic_rotation
	ldr	r0, [sp, #0]
	bl	__aeabi_i2d
	mov	r3, #1048576000
	mov	r2, #0
	add	r3, r3, #3145728
	bl	__aeabi_dmul
	adr	r3, .L98
	ldmia	r3, {r2-r3}
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L98+12
	bl	printf
	mov	r3, #21760
	add	r3, r3, #85
	mov	r2, #0
	mov	r0, sp
	mov	r1, #1048576
	bl	cordic_rotation
	ldr	r0, [sp, #0]
	bl	__aeabi_i2d
	mov	r3, #1048576000
	mov	r2, #0
	add	r3, r3, #3145728
	bl	__aeabi_dmul
	adr	r3, .L98
	ldmia	r3, {r2-r3}
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L98+16
	bl	printf
	mov	r2, #0
	mov	r3, #32768
	mov	r0, sp
	mov	r1, #1048576
	bl	cordic_rotation
	ldr	r0, [sp, #0]
	bl	__aeabi_i2d
	mov	r3, #1048576000
	mov	r2, #0
	add	r3, r3, #3145728
	bl	__aeabi_dmul
	adr	r3, .L98
	ldmia	r3, {r2-r3}
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L98+20
	bl	printf
	mov	r3, #28928
	add	r3, r3, #199
	mov	r2, #0
	mov	r0, sp
	mov	r1, #1048576
	bl	cordic_rotation
	ldr	r0, [sp, #4]
	bl	__aeabi_i2d
	mov	r3, #1048576000
	mov	r2, #0
	add	r3, r3, #3145728
	bl	__aeabi_dmul
	adr	r3, .L98
	ldmia	r3, {r2-r3}
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	bl	__aeabi_f2d
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L98+24
	bl	printf
	mov	r2, #0
	mov	r3, #65536
	mov	r0, sp
	mov	r1, #1048576
	bl	cordic_rotation
	ldr	r0, [sp, #4]
	bl	__aeabi_i2d
	mov	r3, #1048576000
	mov	r2, #0
	add	r3, r3, #3145728
	bl	__aeabi_dmul
	adr	r3, .L98
	ldmia	r3, {r2-r3}
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	bl	__aeabi_f2d
	mov	r3, r1
	mov	r2, r0
	ldr	r0, .L98+28
	bl	printf
	mov	r2, #0
	mov	r1, #4194304
	mov	r0, #1048576
	bl	cordic_vector
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r3, #1056964608
	bl	__aeabi_dmul
	mov	r3, #1073741824
	add	r3, r3, #4587520
	mov	r2, #0
	add	r3, r3, #32768
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	bl	__aeabi_f2d
	mov	r3, r1
	mov	r2, r0
	ldr	r0, .L98+32
	bl	printf
	mov	r2, #0
	mov	r1, #2097152
	mov	r0, #1048576
	bl	cordic_vector
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r3, #1056964608
	bl	__aeabi_dmul
	mov	r3, #1073741824
	add	r3, r3, #4587520
	mov	r2, #0
	add	r3, r3, #32768
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	bl	__aeabi_f2d
	mov	r3, r1
	mov	r2, r0
	ldr	r0, .L98+36
	bl	printf
	mov	r2, #0
	mov	r1, #6291456
	mov	r0, #1048576
	bl	cordic_vector
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r3, #1056964608
	bl	__aeabi_dmul
	mov	r3, #1073741824
	add	r3, r3, #4587520
	mov	r2, #0
	add	r3, r3, #32768
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	bl	__aeabi_f2d
	mov	r3, r1
	mov	r2, r0
	ldr	r0, .L98+40
	bl	printf
	mov	r0, #1048576
	mov	r2, #0
	mov	r1, r0
	bl	cordic_vector
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r3, #1056964608
	bl	__aeabi_dmul
	mov	r3, #1073741824
	add	r3, r3, #4587520
	mov	r2, #0
	add	r3, r3, #32768
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	bl	__aeabi_f2d
	mov	r3, r1
	mov	r2, r0
	ldr	r0, .L98+44
	bl	printf
	mov	r2, #0
	mov	r1, #1048576
	mov	r0, #2097152
	bl	cordic_vector
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r3, #1056964608
	bl	__aeabi_dmul
	mov	r3, #1073741824
	add	r3, r3, #4587520
	mov	r2, #0
	add	r3, r3, #32768
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	bl	__aeabi_f2d
	mov	r3, r1
	mov	r2, r0
	ldr	r0, .L98+48
	bl	printf
	mov	r2, #0
	mov	r1, #1048576
	mov	r0, #3145728
	bl	cordic_vector
	bl	__aeabi_i2d
	mov	r2, #0
	mov	r3, #1056964608
	bl	__aeabi_dmul
	mov	r3, #1073741824
	add	r3, r3, #4587520
	mov	r2, #0
	add	r3, r3, #32768
	bl	__aeabi_dmul
	bl	__aeabi_d2f
	bl	__aeabi_f2d
	add	r5, r5, #1
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L98+52
	bl	printf
	cmp	r5, #256
	bne	.L94
	bl	clock
	rsb	r0, r6, r0
	bl	__aeabi_i2d
	mov	r3, #1090519040
	add	r3, r3, #3047424
	mov	r2, #0
	add	r3, r3, #1152
	bl	__aeabi_ddiv
	mov	r2, r0
	mov	r3, r1
	ldr	r0, .L98+56
	bl	printf
	mov	r0, #0
	add	sp, sp, #8
	ldmfd	sp!, {r4, r5, r6, lr}
	bx	lr
.L99:
	.align	3
.L98:
	.word	-1257819312
	.word	1071869597
	.word	.LC0
	.word	.LC1
	.word	.LC2
	.word	.LC3
	.word	.LC4
	.word	.LC5
	.word	.LC6
	.word	.LC7
	.word	.LC8
	.word	.LC9
	.word	.LC10
	.word	.LC11
	.word	.LC12
	.size	main, .-main
	.section	.rodata
	.align	2
.LANCHOR0 = . + 0
	.type	C.11.2409, %object
	.size	C.11.2409, 32
C.11.2409:
	.word	-2147464304
	.word	669848644
	.word	170657047
	.word	42729798
	.word	10682449
	.word	2686996
	.word	655365
	.word	196609
	.type	C.14.2433, %object
	.size	C.14.2433, 32
C.14.2433:
	.word	-2147464304
	.word	669848644
	.word	170657047
	.word	42729798
	.word	10682449
	.word	2686996
	.word	655365
	.word	196609
	.section	.rodata.str1.4,"aMS",%progbits,1
	.align	2
.LC0:
	.ascii	"Cos(1): %.8lf\012\000"
	.space	1
.LC1:
	.ascii	"Cos(20): %.8lf\012\000"
.LC2:
	.ascii	"Cos(30): %.8lf\012\000"
.LC3:
	.ascii	"Cos(45): %.8lf\012\000"
.LC4:
	.ascii	"Sin(40): %.8lf\012\000"
.LC5:
	.ascii	"Sin(90): %.8lf\012\000"
.LC6:
	.ascii	"Arctan(1/4): %.8lf\012\000"
.LC7:
	.ascii	"Arctan(1/2): %.8lf\012\000"
.LC8:
	.ascii	"Arctan(1/6): %.8lf\012\000"
.LC9:
	.ascii	"Arctan(1): %.8lf\012\000"
	.space	2
.LC10:
	.ascii	"Arctan(2): %.8lf\012\000"
	.space	2
.LC11:
	.ascii	"Arctan(3): %.8lf\012\000"
	.space	2
.LC12:
	.ascii	"running time: %f\012\000"
	.ident	"GCC: (Sourcery G++ Lite 2008q3-72) 4.3.2"
	.section	.note.GNU-stack,"",%progbits
