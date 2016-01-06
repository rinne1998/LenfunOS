/*----------	File Describe	----------*/

/*
 * File:		tool/helper.c
 * Author:		火云 <cloudblaze@yeah.net>
 * Created on:	2015/12/16 13:42:54
 * Modified on:	2015/12/16 13:42:54
 * Describe:
 *		一个帮助工具头文件。包含一些辅助函数。
 */
#ifndef HELPER_H
#define	HELPER_H

/*----------	Macro	----------*/


/*----------	Function Declaration	----------*/

void ExitWithMessage(const char * const message) __attribute__((noreturn));
void * Malloc(size_t size);
void * MallocWithExit(size_t size);
void WriteError(const char * func, const char * file, int line);
void PrintErrorWithExit(const char * func, const char * file, int line) __attribute__((noreturn));
char * SplicingString(const char * fmt, ...);

#endif	/* HELPER_H */