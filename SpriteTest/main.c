#include "defines.h"
#include "sprites.h"
#include "buttons.h"
#include "simpleOutside.pal.h"
#include "simpleOutside.map.h"
#include "simpleOutside.raw.h"
#include "simpleOutsideHitMap.map.h"
#include "simpleOutsideHitMap.raw.h"
#include "forward.h"
#include "jumping.h"
#include "sideways.h"
#include "walking1.h"
#include "laser.h"

typedef enum {
	LEFT,
	RIGHT,
	UP,
	DOWN
} Direction;

void Gravity();
void Jump();
SpriteHandler Move(Direction, SpriteHandler);
int GetNextTile(int, int);
void Shoot(int, int);
void MoveMapRight();
void MoveMapLeft();
void CopyRowToBackground(int, int, int, int, const unsigned short*, unsigned short*, int);
void CopyColumnToBackground(int, int, int, int, const unsigned short*, unsigned short*, int);

#define MAP_WIDTH 512
#define MAP_HEIGHT 512
#define MAP_COLUMNS 64
#define MAP_ROWS 64
const unsigned char* mapTiles = simpleOutside_Tiles;
const u16* map = simpleOutside_Map;
const u16* mapPalette = simpleOutside_Palette;
const u16* hitMap = simpleOutsideHitMap_Map;
const unsigned char* hitMapTiles = simpleOutsideHitMap_Tiles;

u16* bg0map, *bg1map;
#define FORWARD_SPRITE_LOC 0
#define SIDEWAYS_SPRITE_LOC 16 * 32 / (8 * 8) * 2
#define WALKING_SPRITE_LOC 16 * 32 / (8 * 8) * 2 * 2
#define JUMPING_SPRITE_LOC 16 * 32 / (8 * 8) * 2 * 3
#define LASER_SPRITE_LOC 16 * 32 / (8 * 8) * 2 * 4
SpriteHandler sprites[128];
int numberOfSprites;

#define JUMP_HEIGHT 20
bool isJumping = false;
bool isMoving = false;
int jumpDuration;
int walkingCounter = 0;

int mapLeft = 0, mapRight = 255, screenLeft = 0, screenRight = 239, nextColumn = 0, prevColumn = 0;
int mapTop = 0, mapBottom = 255, screenTop = 0, screenBottom = 159, nextRow = 0, prevRow = 0;

int regX = 0, regY = 0;


void Initialize()
{
	SetMode(0 |OBJ_ENABLE|OBJ_MAP_1D | BG0_ENABLE);
	
	int n, startLocation = 0;
	for(n = 0; n < 256; n++)
		SpritePal[n] = forwardPalette[n];
	
	for(n = 0; n < 16*32/2; n++)
		SpriteData[n] = forwardData[n];
		
	startLocation = n;
	for (; n < 16 * 32 / 2 + startLocation; n++)
		SpriteData[n] = sidewaysData[n - startLocation];
		
	startLocation = n;
	for (; n < 16 * 32 / 2 + startLocation; n++)
		SpriteData[n] = walking1Data[n - startLocation];
		
	startLocation = n;
	for (; n < 16 * 32 / 2 + startLocation; n++)
		SpriteData[n] = jumpingData[n - startLocation];

	startLocation = n;
	for(; n < 8 * 8 / 2 + startLocation; n++)
		SpriteData[n] = laserData[n - startLocation];
		
	for(n = 0; n < 128; n++)
	{
		sprites[n].y = 160;
		sprites[n].x = 240;
		sprites[n].isRemoved = true;
	}
	
	BoundingBox characterBBox;
	characterBBox.x = 0;
	characterBBox.y = 0;
	characterBBox.xsize = 16;
	characterBBox.ysize = 32;
	sprites[0].y = 0;
	sprites[0].x = 0;
	sprites[0].size = SIZE_32;
	sprites[0].shape = TALL;
	sprites[0].location = FORWARD_SPRITE_LOC;
	sprites[0].boundingBox = characterBBox;
	sprites[0].noGravity = false;
	sprites[0].isProjectile = false;
	sprites[0].speed = 1;
	sprites[0].isRemoved = false;
	numberOfSprites++;
	
	
	WaitVBlank();
	UpdateSpriteMemory(sprites, 128);

	//create a pointer to background 0 tilemap buffer
	bg0map =(unsigned short*)ScreenBaseBlock(31);
	bg1map = (unsigned short*)ScreenBaseBlock(28);

	//set up background 0
	//We are using a 256x256 Map which is placed in ScreenBaseBlock 31
	REG_BG0CNT = BG_COLOR256 | TEXTBG_SIZE_256x256 | (31 << SCREEN_SHIFT);
	
	REG_BG1CNT = BG_COLOR256 | TEXTBG_SIZE_256x256 | (28 << SCREEN_SHIFT);
	
	//copy the palette into the background palette memory
	DMAFastCopy((void*)mapPalette, (void*)BGPaletteMem, 256, DMA_16NOW);

	//copy the tile images into the tile memory
	DMAFastCopy((void*)mapTiles, (void*)CharBaseBlock(0), 192, DMA_32NOW);
	
	DMAFastCopy((void*)hitMapTiles, (void*)CharBaseBlock(2), 240, DMA_32NOW);
	
	int i, j;
	//unsigned short screen[1024];
	for (i = 0; i < 32; i++)
	{
		for (j = 0; j < 32; j++)
		{
			bg0map[i * 32 + j] = map[i * MAP_COLUMNS + j];
			bg1map[i * 32 + j] = hitMap[i * MAP_COLUMNS + j];
		}
	}
}

void Update()
{
	keyPoll();
	Direction dir;
	if (keyHit(BUTTON_UP) && !isJumping)
	{
		sprites[0].location = JUMPING_SPRITE_LOC;
		isJumping = true;
		jumpDuration = 0;
		walkingCounter = 0;
	}
	if (isJumping && jumpDuration < JUMP_HEIGHT)
	{
		dir = UP;
		sprites[0] = Move(dir, sprites[0]);
		jumpDuration++;
	}
	else
	{
		Gravity();
	}
	if (keyHeld(BUTTON_RIGHT))
	{
		if (!isJumping)
		{
			if (walkingCounter % 20 == 10)
				sprites[0].location = WALKING_SPRITE_LOC;
			else if (walkingCounter % 20 == 0)
				sprites[0].location = SIDEWAYS_SPRITE_LOC;
		}
		sprites[0].hFlip = false;
		dir = RIGHT;
		if (sprites[0].x < 120 || mapRight == MAP_WIDTH - 1)
		{	
			sprites[0] = Move(dir, sprites[0]);
		}
		else
		{
			MoveMapRight();
		}
	}
		
	if (keyHeld(BUTTON_LEFT))
	{
		if (!isJumping)
		{
			if (walkingCounter % 20 == 10)
				sprites[0].location = WALKING_SPRITE_LOC;
			else if (walkingCounter % 20 == 0)
				sprites[0].location = SIDEWAYS_SPRITE_LOC;
		}	
		sprites[0].hFlip = true;
		dir = LEFT;
		if (sprites[0].x > 120 || mapLeft == 0)
		{
			sprites[0] = Move(dir, sprites[0]);
		}
		else
		{
			MoveMapLeft();
		}
	}
	
	if (keyHit(BUTTON_A))
	{
		Shoot(sprites[0].x, sprites[0].y);
	}
	
	int i;
	dir = RIGHT;
	for (i = 0; i < 128; i++)
	{
		if (sprites[i].isProjectile && !sprites[i].isRemoved)
		{
			sprites[i] = Move(dir, sprites[i]);
		}		
	}
	
	if (!keyHeld(BUTTON_LEFT) && !keyHeld(BUTTON_RIGHT) && !isJumping)
		sprites[0].location = FORWARD_SPRITE_LOC;
	
	WaitVBlank();
	UpdateSpriteMemory(sprites, 128);
	REG_BG0VOFS = regY;
	REG_BG0HOFS = regX;
	
	int n;
	for(n = 0; n < 40000; n++);
}

int main(void)
{			

	Initialize();
	
   while(1)
   {
        Update();
   }

   return 0;
}

void Gravity()
{
	int i;
	for (i = 0; i < numberOfSprites; i++)
	{
		if (!sprites[i].noGravity)
		{
			int curBottom	= sprites[i].y + sprites[i].boundingBox.ysize;
			int curX = sprites[i].x + sprites[i].boundingBox.xsize / 2;
			if (GetNextTile(curX, curBottom) == 2)
			{
				if (isJumping)
				{	
					sprites[0].location = FORWARD_SPRITE_LOC;
					isJumping = false;
				}
				break;
			}
			else if (GetNextTile(curX, curBottom) == 3)
			{
				sprites[i].location = FORWARD_SPRITE_LOC;
				sprites[i].x = 0;
				sprites[i].y = 0;
				isJumping = false;
				break;
			}
				
			sprites[i].y++;
		}
	}
}

int GetNextTile(int x, int y)
{
	x += mapLeft;
	y += mapTop;
	return bg1map[(y / 8) * 32 + (x / 8)];
}

void Shoot(int startX, int startY)
{
	int location = GetNextFreePosition(sprites, 128);
	BoundingBox laserBBox;
	laserBBox.x = 0;
	laserBBox.y = 0;
	laserBBox.xsize = 8;
	laserBBox.ysize = 8;
	sprites[location].y = startY;
	sprites[location].x = startX;
	sprites[location].size = SIZE_8;
	sprites[location].shape = SQUARE;
	sprites[location].location = LASER_SPRITE_LOC;
	sprites[location].boundingBox = laserBBox;
	sprites[location].noGravity = true;
	sprites[location].isProjectile = true;
	sprites[location].speed = 2;
	sprites[location].isRemoved = false;

	numberOfSprites++;
}

SpriteHandler Move(Direction direction, SpriteHandler sprite)
{
	int x, y;
	switch(direction)
	{
		case LEFT:
		{
			x = sprite.x;
			y = sprite.y + sprite.boundingBox.ysize / 2;
			if (x > 0 && GetNextTile(x - 1, y) != 2)
			{
				sprite.x -= sprite.speed;
				walkingCounter++;
			}
			else
			{
				if (sprite.isProjectile)
				{
					sprite.x = 240;
					sprite.y = 160;
					sprite.isRemoved = true;
				}
			}
			break;
		}
		case RIGHT:
		{
			x = sprite.x + sprite.boundingBox.xsize;
			y = sprite.y + sprite.boundingBox.ysize / 2;
			if (x < 239 && GetNextTile(x + 1, y) != 2)
			{
				sprite.x += sprite.speed;
				walkingCounter++;
			}
			else
			{
				if (sprite.isProjectile)
				{
					sprite.x = 240;
					sprite.y = 160;
					sprite.isRemoved = true;
				}
			}
			break;
		}
		case UP:
		{
			x = sprite.x;
			y = sprite.y;
			if (y > 0 && GetNextTile(x, y - 1) != 2)
				sprite.y--;
			break;
		}
		default:
			break;
	}
	
	return sprite;
}


void MoveMapLeft()
{
	if (screenLeft > 0)
	{
		regX--;
		if (mapLeft > 0)
		{
			mapLeft--; mapRight--;
		}
		
		prevColumn = screenLeft / 8;
		screenLeft--; screenRight--;
		nextColumn = screenLeft / 8;
		if (nextColumn < prevColumn)
			CopyColumnToBackground(screenLeft, nextColumn, mapTop, mapBottom, map, bg0map, MAP_COLUMNS);
	}
}

void MoveMapRight()
{
	if (screenRight < MAP_WIDTH - 1)
	{
		regX++;
		if (mapRight < MAP_WIDTH - 1)
		{
			mapRight++; mapLeft++;
		}
		
		prevColumn = screenRight / 8;
		screenLeft++; screenRight++;
		nextColumn = screenRight / 8;
		if (nextColumn > prevColumn)
			CopyColumnToBackground(screenRight, nextColumn, mapTop, mapBottom, map, bg0map, MAP_COLUMNS);
	}
}

void MoveMap(Direction direction)
{
	
	bool moveLeft = false, moveRight = false, moveUp = false, moveDown = false;
	switch (direction)
	{
		case LEFT:
		{
			if (screenLeft > 0)
			{
				regX--;
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
		case RIGHT:
		{
			if (screenRight < MAP_WIDTH - 1)
			{
				regX++;
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
		case UP:
		{
			if (screenTop > 0)
			{
				regY--;
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
		case DOWN:
		{
			if (screenBottom < MAP_HEIGHT - 1)
			{
				regY++;
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