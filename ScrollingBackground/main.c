#include "defines.h"
#include "buttons.h"
#include "map.pal.h"
#include "background.map.h"
#include "background.raw.h"
#include "foreground.map.h"
#include "foreground.raw.h"

#define MAP_WIDTH 2048
#define MAP_HEIGHT 2048
#define MAP_COLUMNS 256
#define MAP_ROWS 256
#define BACKGROUND_WIDTH 1028
#define BACKGROUND_HEIGHT 1028
#define BACKGROUND_MAP_COLUMNS 128
#define BACKGROUND_MAP_ROWS 128
const unsigned char* mapTiles = foreground_Tiles;
const u16* map = foreground_Map;
const u16* mapPalette = map_Palette;
const u16* background = background_Map;
const unsigned char* backgroundTiles = background_Tiles;

u16* bg0map, *bg1map;

void CopyColumnToBackground(int, int, int, int, const unsigned short*, unsigned short*, int);
void CopyRowToBackground(int, int, int, int, const unsigned short*, unsigned short*, int);

int main(void)
{
	SetMode(0 | BG0_ENABLE | BG1_ENABLE);

	//create a pointer to background 0 tilemap buffer
	bg0map =(unsigned short*)ScreenBaseBlock(31);
	bg1map = (unsigned short*)ScreenBaseBlock(28);

	//set up background 0
	//We are using a 256x256 Map which is placed in ScreenBaseBlock 31
	REG_BG0CNT = BG_COLOR256 | TEXTBG_SIZE_256x256 | (31 << SCREEN_SHIFT);
	
	REG_BG1CNT = BG_COLOR256 | TEXTBG_SIZE_256x256 | (28 << SCREEN_SHIFT) | (1 << CHAR_SHIFT);
	
	//copy the palette into the background palette memory
	DMAFastCopy((void*)mapPalette, (void*)BGPaletteMem, 256, DMA_16NOW);

	//copy the tile images into the tile memory
	DMAFastCopy((void*)mapTiles, (void*)CharBaseBlock(0), 80, DMA_32NOW);
	
	DMAFastCopy((void*)backgroundTiles, (void*)CharBaseBlock(1), 64, DMA_32NOW);
	
	int i, j;
	//unsigned short screen[1024];
	for (i = 0; i < 32; i++)
	{
		for (j = 0; j < 32; j++)
		{
			bg0map[i * 32 + j] = map[i * MAP_COLUMNS + j];
			bg1map[i * 32 + j] = background[i * BACKGROUND_MAP_COLUMNS + j];
		}
	}
	
	int mapLeft = 0, mapRight = 255, screenLeft = 0, screenRight = 239, nextColumn = 0, prevColumn = 0;
	int mapTop = 0, mapBottom = 255, screenTop = 0, screenBottom = 159, nextRow = 0, prevRow = 0;
	
	int x = 0,y = 0, n;
   while(1)
   {
		bool moveLeft = false, moveRight = false, moveUp = false, moveDown = false;
        CheckButtons();
		WaitVBlank();
		if(Pressed(BUTTON_LEFT))
		{
			if (screenLeft > 0)
			{
				x--;
				if (mapLeft > 0)
				{
					mapLeft--; mapRight--;
				}
				
				prevColumn = screenLeft / 8;
				screenLeft--; screenRight--;
				nextColumn = screenLeft / 8;
				if (nextColumn < prevColumn)
					moveLeft = true;
			}
		}
		if(Pressed(BUTTON_RIGHT))
		{
			if (screenRight < MAP_WIDTH - 1)
			{
				x++;
				if (mapRight < MAP_WIDTH - 1)
				{
					mapRight++; mapLeft++;
				}
				
				prevColumn = screenRight / 8;
				screenLeft++; screenRight++;
				nextColumn = screenRight / 8;
				if (nextColumn > prevColumn)
				    moveRight = true;
			}
		}
		if(Pressed(BUTTON_UP)) 
		{
			if (screenTop > 0)
			{
				y--;
				if (mapTop > 0)
				{
					mapTop--;	mapBottom--;
				}
				
				prevRow = screenTop / 8;
				screenTop--; screenBottom--;
				nextRow = screenTop / 8;
				if (nextRow < prevRow)
					moveUp = true;
			}
		}
		if(Pressed(BUTTON_DOWN))
		{
			if (screenBottom < MAP_HEIGHT - 1)
			{
				y++;
				if (mapBottom < MAP_HEIGHT - 1)
				{
					mapTop++; mapBottom++;
				}
				
				prevRow = screenBottom / 8;
				screenTop++; screenBottom++;
				nextRow = screenBottom / 8;
				if (nextRow > prevRow)
					moveDown = true;
			}
		}
		
		if (moveLeft)
		{
			CopyColumnToBackground(screenLeft, nextColumn, mapTop, mapBottom, map, bg0map, MAP_COLUMNS);
		}
		if (moveRight)
		{
			CopyColumnToBackground(screenRight, nextColumn, mapTop, mapBottom, map, bg0map, MAP_COLUMNS);
		}
		if (moveUp)
		{
			CopyRowToBackground(screenTop, nextRow, mapLeft, mapRight, map, bg0map, MAP_COLUMNS);
		}
		if (moveDown)
		{
			CopyRowToBackground(screenBottom, nextRow, mapLeft, mapRight, map, bg0map, MAP_COLUMNS);
		}
			
		REG_BG0VOFS = y;
		REG_BG0HOFS = x;
		REG_BG1VOFS = y / 10;
		REG_BG1HOFS = x / 10;

		for(n = 0; n < 40000; n++);
   }

   return 0;
}

void CopyColumnToBackground(int column, int copyToColumn, int topRow, int bottomRow, const unsigned short* source, unsigned short* dest, int sourceColumns)
{
	int row;
	column /= 8;
	copyToColumn %= 32;
	topRow /= 8;
	bottomRow /= 8;
	for (row = topRow; row < bottomRow; row++)
		dest[(row % 32) * 32 + copyToColumn] = source[row * sourceColumns + column];
}

void CopyRowToBackground(int row, int copyToRow, int leftColumn, int rightColumn, const unsigned short* source, unsigned short* dest, int sourceColumns)
{
	int column;
	row /= 8;
	copyToRow %= 32;
	leftColumn /= 8;
	rightColumn /= 8;
	for (column = leftColumn; column < rightColumn; column++)
		dest[copyToRow * 32 + (column % 32)] = source[row * sourceColumns + column];
}
