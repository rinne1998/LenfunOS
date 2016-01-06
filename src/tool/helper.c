/*----------	File Describe	----------*/

/*
 * File:		tool/helper.c
 * Author:		火云 <cloudblaze@yeah.net>
 * Created on:	2015/12/16 13:42:54
 * Modified on:	2015/12/16 13:42:54
 * Describe:
 *		一个帮助工具。包含一些辅助函数。
 */

/*----------	Include File	----------*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdarg.h>

#include "helper.h"

/*----------	Macro	----------*/

// 临时字符串大小
#define TempStringSizeShort		128
#define TempStringSizeMiddle	1024
#define TempStringSizeLong		4096

/*----------	Function Declaration	----------*/

/*----------	Function	----------*/

void ExitWithMessage(const char * const message)
{
	printf("%s\n", message);
	exit(1);
}

/*
 * 输出包括源文件名、行号和函数名称的错误信息。
 */
void WriteError(const char * func, const char * file, int line)
{
	char * pTempString = NULL;

	if ((pTempString = (char *) malloc(TempStringSizeShort + 1)) == NULL)
	{
		perror("malloc");
		exit(1);
	}
	sprintf(pTempString, "%s (%s, %d)", func, file, line);
	perror(pTempString);
	free(pTempString);
}

/*
 * 输出包括源文件名、行号和函数名称的错误信息，并且退出程序。
 */
void PrintErrorWithExit(const char * func, const char * file, int line)
{
	WriteError(func, file, line);
	exit(1);
}

/*
 * 复制字符串。
 */
char * SplicingString(const char * fmt, ...)
{
	char * pTempString = NULL;
	va_list args;

	if ((pTempString = (char *) malloc(TempStringSizeMiddle + 1)) == NULL)
	{
		WriteError("SplicingString", __FILE__, __LINE__);
	}
	va_start(args, fmt);
	vsprintf(pTempString, fmt, args);
	va_end(args);

	return pTempString;
}