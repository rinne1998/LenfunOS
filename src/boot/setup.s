/*----------	File Describe	----------*/

/*
 * File:		boot/setup.s
 * Author:		火云 <cloudblaze@yeah.net>
 * Created on:	2015/12/07 15:15:47
 * Modified on:	2015/12/07 15:15:47
 * Describe:
 *		通过BIOS调用获取系统必需的信息，并且使系统进入保护模式。
 */

/*----------	Include File	----------*/

	.include "../include/common/config.inc"

/*----------	Section Property	----------*/

	.code16
	.section .text
	
/*----------	Macro	----------*/

	.equ KERNEL16_SEG,	DEF_KERNEL16SEG		/* kernel16加载地址 */
	.equ LIB16_SEG,		DEF_LIB16SEG		/* lib16加载地址 */
	.equ SETUP_SEG,		DEF_SETUPSEG		/* setup加载地址 */
	.equ INFO16_SEG,	DEF_INFO16SEG		/* 系统信息地址（16为系统） */

/*----------	Code	----------*/

	.global _start
	
_start:
	mov %cs, %ax				# 初始化段寄存器及栈顶指针
	mov %ax, %ds
	mov %ax, %ss
	mov $0x400, %sp
	

	
	hlt

/*----------	Data	----------*/

p_VbeInfoBlock:					/* 0B-511B */
	.word 0
p_ModeInfoBlock:				/* 512B-767B*/
	.word 512
