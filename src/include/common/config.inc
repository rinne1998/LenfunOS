/*----------	File Describe	----------*/

/*
 * File:		include/common/config.h
 * Author:		火云 <cloudblaze@yeah.net>
 * Created on:	2015/12/14 13:51:47
 * Modified on:	2015/12/14 13:51:47
 * Describe:
 *		该文件定义常量。
 */

/*----------	Macro	----------*/

/*
 * 定义段基址
 */
	.equ DEF_BOOTSEG,		0x07C0		/* bootsect加载地址 */
	.equ DEF_KERNEL16SEG,	0x1000		/* kernel16加载地址 */
	.equ DEF_LIB16SEG,		0x2000		/* lib16加载地址 */
	.equ DEF_SETUPSEG,		0x9000		/* setup加载地址 */
	.equ DEF_INFO16SEG,		0x9020		/* 系统信息地址（16为系统） */
	.equ DEF_VGASEG,		0xB800		/* VGA显卡内存地址 */

/*
 * 定义方向
 */
	.equ DEF_UP,		0		/* 上 */
	.equ DEF_DOWN,		1		/* 下 */
	.equ DEF_LEFT,		2		/* 左 */
	.equ DEF_RIGHT,		3		/* 右 */
