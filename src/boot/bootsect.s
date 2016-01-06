/*----------	File Describe	----------*/

/*
 * File:		boot/bootsect.s
 * Author:		火云 <cloudblaze@yeah.net>
 * Created on:	2015/12/14 13:51:47
 * Modified on:	2015/12/14 13:51:47
 * Describe:
 *		本程序为引导扇区程序，加载系统加载程序和内核程序。若加载未成功，则停机且显示提示信息。
 */

/*----------	Include File	----------*/

	.include "../include/common/config.inc"

/*----------	Section Property	----------*/

	.code16
	.section .text
	
/*----------	Macro	----------*/

	.equ BOOT_SEG,		DEF_BOOTSEG			/* bootsect加载地址 */
	.equ KERNEL16_SEG,	DEF_KERNEL16SEG		/* kernel16加载地址 */
	.equ LIB16_SEG,		DEF_LIB16SEG		/* lib16加载地址 */
	.equ SETUP_SEG,		DEF_SETUPSEG		/* setup加载地址 */

/*----------	Code	----------*/

	.global _start
	
_start:
	ljmp $BOOT_SEG, $go
go:
	mov %cs, %ax				# 初始化段寄存器及栈顶指针
	mov %ax, %ds
	mov %ax, %ss
	mov $0x400, %sp
	
	mov $0x0003, %ax			# 初始化屏幕为80*25，文本模式
	int $0x10
	
load_setup:						# 从硬盘加载setup
	mov SetupLen, %ax
	test %ax, %ax
	jz load_kernel16
	mov $SETUP_SEG, %ax
	mov %ax, %es
	xor %bx, %bx
	mov $0x02, %ah
	mov SetupLen, %al
	mov $0, %ch
	mov $2, %cl
	mov $0, %dh
	mov $0x80, %dl
	int $0x13
	jc die

load_kernel16:					# 从硬盘加载kernel16
	mov Kernel16Len, %ax
	test %ax, %ax
	jz load_ok
	mov $KERNEL16_SEG, %ax
	mov %ax, %es
	xor %bx, %bx
	mov $0x02, %ah
	mov SetupLen, %al
	mov $0, %ch
	mov $2, %cl
	mov $0, %dh
	mov $0x80, %dl
	int $0x13
	jc die
	
load_lib16:					# 从硬盘加载lib16
	mov Lib16Len, %ax
	test %ax, %ax
	jz load_ok
	mov $LIB16_SEG, %ax
	mov %ax, %es
	xor %bx, %bx
	mov $0x02, %ah
	mov SetupLen, %al
	mov $0, %ch
	mov $2, %cl
	mov $0, %dh
	mov $0x80, %dl
	int $0x13
	jc die
	
load_ok:						# 加载成功，跳转到setup
	ljmp $SETUP_SEG, $0

die:							# 加载失败
	mov %ds, %ax				# 显示提示信息
	mov %ax, %es
	mov $Message, %bp
	mov $0x1301, %ax
	mov $0x000C, %bx
	mov MessageLen, %cx
	int $0x10
	
	hlt							# 停机
	jmp die
	
/*----------	Data	----------*/

Message:
	.ascii "Load failure !\n\r"
MessageLen:
	.byte .-Message

	.org 0x01F8
SetupLen:
	.word 0x1
Lib16Len:
	.word 0x0
Kernel16Len:
	.word 0x0
	
	.org 0x01FE
BootFlag:
	.word 0xAA55
