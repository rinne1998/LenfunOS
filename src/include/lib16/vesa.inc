/*----------	File Describe	----------*/

/*
 * File:		include/lib16/vesa.inc
 * Author:		火云 <cloudblaze@yeah.net>
 * Created on:	2015/12/15 02:00:47
 * Modified on:	2015/12/15 02:00:47
 * Describe:
 *		该文件定义VESA数据结构。
 */

/*----------	Struct	----------*/

/* VbeInfoBlock struct -- 512B */
	.struct 0
VbeSignature:
	.struct VbeSignature+4
VbeVersion:
	.struct VbeVersion+2
OemStringPtr:
	.struct OemStringPtr+4
Capabilities:
	.struct Capabilities+4
VideoModePtr:
	.struct VideoModePtr+4
TotalMemory:
	.struct TotalMemory+2
OemSoftwareRev:
	.struct OemSoftwareRev+2
OemVendorNamePtr:
	.struct OemVendorNamePtr+4
OemProductNamePtr:
	.struct OemProductNamePtr+4
OemProductRevPtr:
	.struct OemProductRevPtr+4
Reserved_VIB:
	.struct Reserved_VIB+222
OemData:
	.struct OemData+256
	
/* ModeInfoBlock struct -- 256B */
	.struct 0
ModeAttributes:
	.struct ModeAttributes+2
WinAAttributes:
	.struct WinAAttributes+1
WinBAttributes:
	.struct WinBAttributes+1
WinGranularity:
	.struct WinGranularity+2
WinSize:
	.struct WinSize+2
WinASegment:
	.struct WinASegment+2
WinBSegment:
	.struct WinBSegment+2
WinFuncPtr:
	.struct WinFuncPtr+4
BytesPerScanLine:
	.struct BytesPerScanLine+2
XResolution:
	.struct XResolution+2
YResolution:
	.struct YResolution+2
XCharSize:
	.struct XCharSize+1
YCharSize:
	.struct YCharSize+1
NumberOfPlanes:
	.struct NumberOfPlanes+1
BitsPerPixel:
	.struct BitsPerPixel+1
NumberOfBanks:
	.struct NumberOfBanks+1
MemoryModel:
	.struct MemoryModel+1
BankSize:
	.struct BankSize+1
NumberOfImagePages:
	.struct NumberOfImagePages+1
Reserved1_MIB:
	.struct Reserved1_MIB+1
RedMaskSize:
	.struct RedMaskSize+1
RedFieldPosition:
	.struct RedFieldPosition+1
GreenMaskSize:
	.struct GreenMaskSize+1
GreenFieldPosition:
	.struct GreenFieldPosition+1
BlueMaskSize:
	.struct BlueMaskSize+1
BlueFieldPosition:
	.struct BlueFieldPosition+1
RsvdMaskSize:
	.struct RsvdMaskSize+1
RsvdFieldPosition:
	.struct RsvdFieldPosition+1
DirectColorModeInfo:
	.struct DirectColorModeInfo+1
PhysBasePtr:
	.struct PhysBasePtr+4
Reserved2_MIB:
	.struct Reserved2_MIB+4
Reserved3_MIB:
	.struct Reserved3_MIB+2
LinBytesPerScanLine:
	.struct LinBytesPerScanLine+2
BnkNumberOfImagePages:
	.struct BnkNumberOfImagePages+1
LinNumberOfImagePages:
	.struct LinNumberOfImagePages+1
LinRedMaskSize:
	.struct LinRedMaskSize+1
LinRedFieldPosition:
	.struct LinRedFieldPosition+1
LinGreenMaskSize:
	.struct LinGreenMaskSize+1
LinGreenFieldPosition:
	.struct LinGreenFieldPosition+1
LinBlueMaskSize:
	.struct LinBlueMaskSize+1
LinBlueFieldPosition:
	.struct LinBlueFieldPosition+1
LinRsvdMaskSize:
	.struct LinRsvdMaskSize+1
LinRsvdFieldPosition:
	.struct LinRsvdFieldPosition+1
MaxPixelClock:
	.struct MaxPixelClock+4
Reserved4_MIB:
	.struct Reserved4_MIB+189
