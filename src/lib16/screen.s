/*----------	File Describe	----------*/

/*
 * File:		lib16/screen.s
 * Author:		火云 <cloudblaze@yeah.net>
 * Created on:	2015/12/16 10:50:00
 * Modified on:	2015/12/16 10:50:00
 * Describe:
 *		本程序包含与屏幕显示相关的函数。
 *		本程序约定如下：
 *			1、%es为VGA显存段，%ds为本程序的数据段。
 *			2、%fs和%gs用于调用函数与本函数之间的数据传递，%fs为调用函数的数据段，%gs为本程序的数据段
 */

/*----------	Include File	----------*/

	.include "../include/common/config.inc"
	.include "../include/lib16/vesa.inc"

/*----------	Section Property	----------*/

	.code16
	.section .text
	
/*----------	Macro	----------*/

	.equ VGA_SEG,		DEF_VGASEG		/* VGA显卡内存地址 */
	
	.equ SCREEN_UP,		DEF_UP			/* 上 */	
	.equ SCREEN_DOWN,	DEF_DOWN		/* 下 */	
	.equ SCREEN_LEFT,	DEF_LEFT		/* 左 */	
	.equ SCREEN_RIGHT,	DEF_RIGHT		/* 右 */	

/*----------	Code	----------*/

/*
 * 函数：_PrintCall
 * 功能：调用print功能。
 * 参数：
 * 		%ebx：调用功能号。
 *		%ecx\%edx\%esi\%edi：参数。
 * 返回值：
 * 		%eax：调用功能的返回值。
 */
_PrintCall:
	push %bp
	mov %sp, %bp	
	push %ecx
	push %edx
	push %esi
	push %edi
	
	push %eax
	push %cs, %ax
	mov %ax, %ds
	mov %ax, %gs
	mov $VGA_SEG, %ax
	mov %ax, %es
	pop %eax
	
	call *_PrintCallsTable(, %ebx, 2)
	
	pop %edi
	pop %esi
	pop %edx
	pop %ecx
	mov %bp, %sp
	pop %bp
	ret
	
/*
 * 函数：PrintSetMode
 * 功能：初始化print模块。
 * 参数：
 * 		%bx：VGA/VESA模式号
 * 返回值：
 * 		无返回值。
 */
PrintInit:
	mov $25, %eax
	mov %eax, screen_rows
	mov $80, %ebx
	mov %ebx, screen_cols
	xor %edx, %edx
	mul %ebx
	mov %eax, screen_chars
	
	ret

/*
 * 函数：print_char
 * 功能：打印字符。
 * 参数：
 * 		%bl：待打印的字符。
 *		%bh：待打印的字符的属性。
 * 返回值：
 * 		无返回值。
 */
print_char:
	mov %ebx, %ecx	
	mov print_cur_posX, %eax
	mov print_cur_posY, %ebx
	call _pos2disp
	mov %cx, %es:(%eax)
	ret

/*
 * 函数：print_hex
 * 功能：打印16进制数。
 * 参数：
 * 		%ebx：待打印的16进制数。
 *		%ecx：打印属性，仅低字节有效
 * 返回值：
 * 		无返回值。
 */
print_hex:
	mov %bl, %bh
	and $0x0F, %bl
	or $0x30, %bl
	mov %cl, %bh
	ret
	
/*
 * 函数：_adjust_pos
 * 功能：调整当前光标坐标。
 * 参数：
 * 		%ebx：需调整的字符数。
 * 返回值：
 * 		无返回值。
 */
_adjust_pos:
	xor %edx, %edx
	mov print_cur_posY, %eax
	add %ecx, %eax
	mov screen_cols, %ebx
	div %ebx
	add %eax, print_cur_posX
	mov %edx, print_cur_posY
	ret

/*
 * 函数：_scroll_screen
 * 功能：滚动屏幕。
 * 参数：
 *		%ebx：滚动方向。
 * 		%ecx：需滚动的行数或列数。
 * 返回值：
 * 		无返回值。
 */
_scroll_screen:
	push %ds

	cmp $UP, %ebx
	jne 1f
	mov %es, %dx
	mov %dx, %ds
	push %eax
	push %ebx
	mov %ecx, %eax
	mov $0, %ebx
	call _pos2disp
	mov %eax, %esi
	xor %edi, %edi
	mov screen_chars, %eax
	sub %ecx, %eax
	shr %eax
	mov %eax, %ecx
	rep
	movsd
	pop %ebx
	pop %eax
	jmp 2f
	
1:	cmp $DOWN, %ebx
	jne 1f
	jmp 2f
	
1:	cmp $LEFT, %ebx
	jne 1f
	jmp 2f
	
1:	cmp $RIGHT, %ebx
	jne 2f

2:	pop %ds
	ret

/*
 * 函数：_pos2disp
 * 功能：通过坐标计算在显卡内存中的偏移量。
 * 参数：
 *		%eax：行号。
 * 		%ebx：列号。
 * 返回值：
 * 		%eax：偏移量
 */
_pos2disp:
	xor %edx, %edx
	mul %ebx
	shl $1, %eax

/*----------	Data	----------*/
	
/* 私有变量 */

/* 当前状态 */
_VGAModeNum:					/* VGA/VESA模式号 */
	.word 0x0
_VGAState:						/* VGA当前状态 */
	.word 0x0					/* bit0：屏幕模式，0为文本模式，1为图形模式。 */
								/* bit1-bit15：保留。 */
								
_ScreenResolution:				/* 当前屏幕字符行列数或分辨率 */
_ScreenRows:						/* 当前屏幕的行数或纵向像素点数 */
	.word 0x0
_ScreenCols:						/* 当前屏幕的列数或横向像素点数 */
	.word 0x0
_ScreenCount:					/* 当前屏幕的字符数或像素点数 */
	.long 0x0
	
_ScreenCurPos:					/* 当前打印坐标 */
_ScreenCurPosX:						/* 当前打印坐标行号，从0开始。 */
	.word 0x0
_ScreenCurPosY:						/* 当前打印坐标列号，从0开始。 */
	.word 0x0
	
/* VESA信息 */
_VESAVersion:
	.word 0x0					/* VESA版本（若为0，则不支持VESA） */
	
/* 全局变量 */
_PrintCallsTable:
	.word _PrintChar
	.word _PrintHex
