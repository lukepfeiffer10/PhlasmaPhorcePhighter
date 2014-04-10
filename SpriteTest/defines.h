#define u16 unsigned short

#define REG_DISPCNT *(unsigned long*) 0x4000000

#define MODE_3 0x3
#define MODE_4 0x4
#define BG0_ENABLE 0x100
#define BG1_ENABLE 0x200
#define BG2_ENABLE 0x400
#define BG3_ENABLE 0x800

#define SetMode(mode) REG_DISPCNT = (mode)

#define RGB(r,g,b) (unsigned short)((r)+((g)<<5)+((b)<<10))

#define REG_DISPSTAT   *(volatile unsigned short*)0x4000004
#define REG_VCOUNT *(volatile unsigned short*)0x04000006
#define BACKBUFFER 0x10

#define REG_DMA3SAD *(volatile unsigned int*)0x40000D4
#define REG_DMA3DAD *(volatile unsigned int*)0x40000D8
#define REG_DMA3CNT *(volatile unsigned int*)0x40000DC
#define DMA_ENABLE 0x80000000
#define DMA_TIMING_IMMEDIATE 0x00000000
#define DMA_16 0x00000000
#define DMA_32 0x04000000
#define DMA_32NOW (DMA_ENABLE | DMA_TIMING_IMMEDIATE | DMA_32)
#define DMA_16NOW (DMA_ENABLE | DMA_TIMING_IMMEDIATE | DMA_16)

#define REG_BG0HOFS *(volatile unsigned short*)0x4000010
#define REG_BG0VOFS *(volatile unsigned short*)0x4000012
#define REG_BG1HOFS *(volatile unsigned short*)0x4000014
#define REG_BG1VOFS *(volatile unsigned short*)0x4000016
#define REG_BG2HOFS *(volatile unsigned short*)0x4000018
#define REG_BG2VOFS *(volatile unsigned short*)0x400001A
#define REG_BG3HOFS *(volatile unsigned short*)0x400001C
#define REG_BG3VOFS *(volatile unsigned short*)0x400001E

//background setup registers and data
#define REG_BG0CNT *(volatile unsigned short*)0x4000008
#define REG_BG1CNT *(volatile unsigned short*)0x400000A
#define REG_BG2CNT *(volatile unsigned short*)0x400000C
#define REG_BG3CNT *(volatile unsigned short*)0x400000E
#define BG_COLOR256 0x80
#define CHAR_SHIFT 2
#define SCREEN_SHIFT 8
#define WRAPAROUND 0x1

//Palette for Backgrounds
#define BGPaletteMem ((unsigned short*)0x5000000)

//background tile bitmap sizes
#define TEXTBG_SIZE_256x256 0x0
#define TEXTBG_SIZE_256x512	0x8000
#define TEXTBG_SIZE_512x256	0x4000
#define TEXTBG_SIZE_512x512	0xC000

//background memory offset macros
#define CharBaseBlock(n) (((n)*0x4000)+0x6000000)
#define ScreenBaseBlock(n) (((n)*0x800)+0x6000000)

unsigned short* videoBuffer = (unsigned short*)0x6000000;

void DrawPixel3(int x, int y, unsigned short c)
{
    videoBuffer[y*240+x] = c;
}

unsigned short* paletteMem = (unsigned short*)0x5000000;

void DrawPixel4(int x, int y, unsigned char color)
{
    unsigned short pixel;
    unsigned short offset = (y * 240 + x) >> 1;
    pixel = videoBuffer[offset];
    if (x & 1)
        videoBuffer[offset] = (color << 8) + (pixel & 0x00FF);
    else
        videoBuffer[offset] = (pixel & 0xFF00) + color;
}

volatile unsigned short* ScanlineCounter = (volatile unsigned short*)0x4000006;

void WaitVBlank(void)
{
	while(*ScanlineCounter < 160)
    {
	}
}

unsigned short* FrontBuffer = (unsigned short*)0x6000000;
unsigned short* BackBuffer = (unsigned short*)0x600A000;

void FlipPage(void)	
{
	if(REG_DISPCNT & BACKBUFFER)
	{
		REG_DISPCNT &= ~BACKBUFFER;
		videoBuffer = BackBuffer;
    }
    else
    {
		REG_DISPCNT |= BACKBUFFER;
		videoBuffer = FrontBuffer;
	}
}

void DMAFastCopy(void* source, void* dest, unsigned int count,
    unsigned int mode)
{
    if (mode == DMA_16NOW || mode == DMA_32NOW)
    {
    	REG_DMA3SAD = (unsigned int)source;
        REG_DMA3DAD = (unsigned int)dest;
        REG_DMA3CNT = count | mode;
    }
}
