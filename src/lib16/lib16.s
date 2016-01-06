/*----------	File Describe	----------*/

/*
 * File:		lib16/lib16.s
 * Author:		火云 <cloudblaze@yeah.net>
 * Created on:	2015/12/16 11:57:47
 * Modified on:	2015/12/16 11:57:47
 * Describe:
 *		本程序包含有关实模式下16位库的函数。
 */

/*----------	Include File	----------*/



/*----------	Section Property	----------*/

	.code16
	.section .text
	
/*----------	Macro	----------*/



/*----------	Code	----------*/

/*
 * 函数：_LibCall
 * 功能：调用库模块功能。
 * 参数：
 *		%eax：模块号
 * 		%ebx：功能号。
 *		%ecx\%edx\%esi\%edi：参数。
 * 返回值：
 * 		%eax：调用模块功能的返回值。
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
	
	call *_LibCallsTable(, %eax, 2)
	
	pop %edi
	pop %esi
	pop %edx
	pop %ecx
	mov %bp, %sp
	pop %bp
	ret

/*----------	Data	----------*/

_LibCallsTable:
	.word _PrintCall
