/*----------	File Describe	----------*/

/*
 * File:		tool/fmerge.c
 * Author:		火云 <cloudblaze@yeah.net>
 * Created on:	2015/12/16 13:42:54
 * Modified on:	2015/12/16 13:42:54
 * Describe:
 *		一个合并多个文件的工具。对输入文件进行校验、裁剪、修改后，合并到输出文件指定位置。
 */

/*----------	Include File	----------*/

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>
#include <string.h>

#include <unistd.h>

#include "helper.h"

/*----------	Struct Declaration	----------*/



/*----------	Macro	----------*/

// 最大命令行选项数
#define CmdOptionMaxCount	10

/*----------	Global Variable	----------*/

// 当前工作路径
char * pCurrentWorkPath = NULL;
// 脚本文件绝对路径
char * pScriptFileFullPath = NULL;
// 默认脚本文件名
const char * const pScriptFileDefaultName = "fmergerc";

// 命令行选项字符串
#define CmdOptionString	"f:"	// f:脚本文件名

/*----------	Static Variable	----------*/



/*----------	External Variable Declaration	----------*/



/*----------	Function Declaration	----------*/

void AnalyzeCmdOption(int argc, char * argv[]);
void GetCurrentWorkPath(void);
FILE * GetScriptFile(void);
void Init(void);

/*----------	Function	----------*/

int main(int argc, char * argv[])
{
	FILE * pScriptFile;

	Init();
	AnalyzeCmdOption(argc, argv);
	GetCurrentWorkPath();
	pScriptFile = GetScriptFile();



	return 0;
}

/*
 * 分析
 */

/*
 * 获取脚本文件
 */
FILE * GetScriptFile(void)
{
	FILE * pScriptFile = NULL;

	if (!pScriptFileFullPath)
	{
		pScriptFileFullPath = SplicingString("%s/%s", pCurrentWorkPath, pScriptFileDefaultName);
	}
	printf("Script file: %s\n", pScriptFileFullPath);
	if (!(pScriptFile = fopen(pScriptFileFullPath, "r")))
	{

		WriteError("fopen", __FILE__, __LINE__);
	}

	return pScriptFile;
}

/*
 * 获取当前工作路径
 */
void GetCurrentWorkPath(void)
{
	if ((pCurrentWorkPath = malloc(PATH_MAX)) == NULL)
	{
		WriteError("malloc", __FILE__, __LINE__);
	}
	if (getcwd(pCurrentWorkPath, PATH_MAX) == NULL)
	{
		WriteError("getcwd", __FILE__, __LINE__);
	}
	printf("Current work path: %s\n", pCurrentWorkPath);
}

/*
 * 获取命令行选项
 */
void AnalyzeCmdOption(int argc, char * argv[])
{
	int ch;

	while ((ch = getopt(argc, argv, CmdOptionString)) != -1)
	{
		switch (ch)
		{
			case 'f':
				if ((pScriptFileFullPath = malloc(PATH_MAX)) == NULL)
				{
					WriteError("malloc", __FILE__, __LINE__);
				}
				strncpy(pScriptFileFullPath, optarg, PATH_MAX);
				break;
		}
	}
}

/*
 * 初始化
 */
void Init(void)
{
	if (!(stderr = fopen("fmerge.log", "w")))
	{
		ExitWithMessage("Init error !");
	}
}