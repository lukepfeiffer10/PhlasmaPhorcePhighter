#include "stdlib.h"

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

#define REG_BG0CNT *(volatile unsigned short*)0x4000008
#define REG_BG1CNT *(volatile unsigned short*)0x400000A
#define REG_BG2CNT *(volatile unsigned short*)0x400000C
#define REG_BG3CNT *(volatile unsigned short*)0x400000E
#define BG_COLOR256 0x80
#define CHAR_SHIFT 2
#define SCREEN_SHIFT 8
#define WRAPAROUND 0x1

#define BGPaletteMem ((unsigned short*)0x5000000)

#define TEXTBG_SIZE_256x256 0x0
#define TEXTBG_SIZE_256x512	0x8000
#define TEXTBG_SIZE_512x256	0x4000
#define TEXTBG_SIZE_512x512	0xC000

#define CharBaseBlock(n) (((n)*0x4000)+0x6000000)
#define ScreenBaseBlock(n) (((n)*0x800)+0x6000000)

#define REG_DISPCNT *(unsigned long*)0x4000000
#define REG_DISPSTAT   *(volatile unsigned short*)0x4000004
#define BG0_ENABLE 0x100
#define BG1_ENABLE 0x200
#define BG3_ENABLE 0x800
#define MODE_3 0x3
#define MODE_4 0x4
#define BG2_ENABLE 0x400
#define SetMode(mode) REG_DISPCNT=(mode)
#define RGB(r,g,b) (unsigned short)(r+(g<<5)+(b<<10))

#define BUTTONS (volatile unsigned short*)0x04000130

#define BUTTON_A 1
#define BUTTON_B 2
#define BUTTON_SELECT 4
#define BUTTON_START 8
#define BUTTON_RIGHT 16
#define BUTTON_LEFT 32
#define BUTTON_UP 64
#define BUTTON_DOWN 128
#define BUTTON_R 256
#define BUTTON_L 512

#define bool int
#define true 1
#define false 0
#define ALIGN4 __attribute__((aligned(4)))


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

unsigned short* paletteMem = (unsigned short*)0x5000000;

bool buttons[10];



void CheckButtons()
{
    buttons[0] = !((*BUTTONS) & BUTTON_A);
    buttons[1] = !((*BUTTONS) & BUTTON_B);
    buttons[2] = !((*BUTTONS) & BUTTON_LEFT);
    buttons[3] = !((*BUTTONS) & BUTTON_RIGHT);
    buttons[4] = !((*BUTTONS) & BUTTON_UP);
    buttons[5] = !((*BUTTONS) & BUTTON_DOWN);
    buttons[6] = !((*BUTTONS) & BUTTON_START);
    buttons[7] = !((*BUTTONS) & BUTTON_SELECT);
    buttons[8] = !((*BUTTONS) & BUTTON_R);
    buttons[9] = !((*BUTTONS) & BUTTON_L);
}

bool Pressed(int button)
{
    switch(button)
    {
        case BUTTON_A: return buttons[0];
        case BUTTON_B: return buttons[1];
        case BUTTON_LEFT: return buttons[2];
        case BUTTON_RIGHT: return buttons[3];
        case BUTTON_UP: return buttons[4];
        case BUTTON_DOWN: return buttons[5];
        case BUTTON_START: return buttons[6];
        case BUTTON_SELECT: return buttons[7];
        case BUTTON_R: return buttons[8];
        case BUTTON_L: return buttons[9];
    }
    return true;
}

void WaitVBlank(void)
{
    while((REG_DISPSTAT & 1));
}



unsigned short curr_state, prev_state;
void keyPoll()
{
	prev_state = curr_state;
	curr_state = ~(*BUTTONS) & 0x03FF;
}
int keyIsDown(int key)
{ return curr_state & key; }
int keyIsUp(int key)
{ return ~curr_state & key; }
int keyWasDown(int key)
{ return prev_state & key; }
int keyWasUp(int key)
{ return ~prev_state & key; }
int keyTransition(int key)
{ return (curr_state ^ prev_state) & key; }
//True if key is currently pressed and was pressed
int keyHeld(int key)
{ return (curr_state & prev_state) & key; }
//True if key is currently pressed and was unpressed
int keyHit(int key)
{ return (curr_state & ~prev_state) & key; }
//True if key is currently not pressed but was pressed
int keyReleased(int key)
{ return (~curr_state & prev_state) & key; }










