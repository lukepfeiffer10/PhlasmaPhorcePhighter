#include "defines.h"
#include "LUT_sin_cos.h"
#include "sprites.h"
#include "buttons.h"
#include "simpleOutside.pal.h"
#include "simpleOutside.map.h"
#include "simpleOutside.raw.h"
#include "simpleOutsideHitMap.map.h"
#include "simpleOutsideHitMap.raw.h"
#include "philFacingRight3.h"
#include "phil.h"
#include "philFacingRight.h"
#include "philFacingRight2.h"
#include "philJumping.h"
#include "laser.h"

void Gravity();
void Jump();
SpriteHandler Move(Direction, SpriteHandler);
SpriteHandler RemoveSprite(SpriteHandler);
int GetNextTile(int, int);
void Shoot(int, int, int, int, Direction);
void MoveMapRight();
void MoveMapLeft();
void CopyRowToBackground(int, int, int, int, const unsigned short*, unsigned short*, int);
void CopyColumnToBackground(int, int, int, int, const unsigned short*, unsigned short*, int);
int CanMove(int, int);
int CanMoveRight(SpriteHandler);
int CanMoveLeft(SpriteHandler);
int CanMoveUp(SpriteHandler);
int CanMoveDown(SpriteHandler);

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
#define SIDEWAYS_SPRITE_LOC 32 * 32 / (8 * 8) * 2
#define WALKING1_SPRITE_LOC 32 * 32 / (8 * 8) * 2 * 2
#define WALKING2_SPRITE_LOC 32 * 32 / (8 * 8) * 2 * 3
#define JUMPING_SPRITE_LOC 32 * 32 / (8 * 8) * 2 * 4
#define LASER_SPRITE_LOC 32 * 32 / (8 * 8) * 2 * 5
SpriteHandler sprites[128];
int numberOfSprites;

#define JUMP_HEIGHT 20
bool isJumping = false;
bool isMoving = false;
int jumpDuration;
int walkingCounter = 0;
int characterSpriteIndex;

int mapLeft = 0, mapRight = 255, screenLeft = 0, screenRight = 239, nextColumn = 0, prevColumn = 0;
int mapTop = 0, mapBottom = 255, screenTop = 0, screenBottom = 159, nextRow = 0, prevRow = 0;

int regX = 0, regY = 0;

BoundingBox characterWalkingRightBBox;
BoundingBox characterStandingRightBBox;
BoundingBox characterWalkingLeftBBox;
BoundingBox characterStandingLeftBBox;

void Initialize()
{
	SetMode(0 |OBJ_ENABLE|OBJ_MAP_1D | BG0_ENABLE);
	
	int n, startLocation = 0;
	for(n = 0; n < 256; n++)
		SpritePal[n] = philPalette[n];
	
	for(n = 0; n < 32*32/2; n++)
		SpriteData[n] = philData[n];
		
	startLocation = n;
	for (; n < 32 * 32 / 2 + startLocation; n++)
		SpriteData[n] = philFacingRightData[n - startLocation];
		
	startLocation = n;
	for (; n < 32 * 32 / 2 + startLocation; n++)
		SpriteData[n] = philFacingRight2Data[n - startLocation];
		
	startLocation = n;
	for (; n < 32 * 32 / 2 + startLocation; n++)
		SpriteData[n] = philFacingRight3Data[n - startLocation];
		
	startLocation = n;
	for (; n < 32 * 32 / 2 + startLocation; n++)
		SpriteData[n] = philJumpingData[n - startLocation];

	startLocation = n;
	for(; n < 8 * 8 / 2 + startLocation; n++)
		SpriteData[n] = laserData[n - startLocation];
		
	for(n = 0; n < 128; n++)
	{
		sprites[n].y = 160;
		sprites[n].x = 240;
		sprites[n].isRemoved = true;
	}
	
	characterWalkingRightBBox.x = 2;
	characterWalkingRightBBox.y = 0;
	characterWalkingRightBBox.xsize = 16;
	characterWalkingRightBBox.ysize = 32;
		
	characterStandingRightBBox.x = 7;
	characterStandingRightBBox.y = 0;
	characterStandingRightBBox.xsize = 8;
	characterStandingRightBBox.ysize = 32;
	
	characterWalkingLeftBBox.x = 18;
	characterWalkingLeftBBox.y = 0;
	characterWalkingLeftBBox.xsize = 16;
	characterWalkingLeftBBox.ysize = 32;
		
	characterStandingLeftBBox.x = 14;
	characterStandingLeftBBox.y = 0;
	characterStandingLeftBBox.xsize = 8;
	characterStandingLeftBBox.ysize = 32;
	

	characterSpriteIndex = 0;
	sprites[characterSpriteIndex].y = 0;
	sprites[characterSpriteIndex].x = 0;
	sprites[characterSpriteIndex].mapX = 0;
	sprites[characterSpriteIndex].mapY = 0;
	sprites[characterSpriteIndex].size = SIZE_32;
	sprites[characterSpriteIndex].shape = SQUARE;
	sprites[characterSpriteIndex].location = SIDEWAYS_SPRITE_LOC;
	sprites[characterSpriteIndex].boundingBox = characterStandingRightBBox;
	sprites[characterSpriteIndex].noGravity = false;
	sprites[characterSpriteIndex].isProjectile = false;
	sprites[characterSpriteIndex].speed = 1;
	sprites[characterSpriteIndex].isRemoved = false;
	sprites[characterSpriteIndex].dir = RIGHT;
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
	Direction mapMoved;
	int projectileMoveCounter = 0;
	if (keyHit(BUTTON_UP) && !isJumping)
	{
		sprites[characterSpriteIndex].location = JUMPING_SPRITE_LOC;
		isJumping = true;
		jumpDuration = 0;
		walkingCounter = 0;
	}
	if (isJumping && jumpDuration < JUMP_HEIGHT)
	{
		dir = UP;
		sprites[characterSpriteIndex] = Move(dir, sprites[characterSpriteIndex]);
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
			if (walkingCounter % 40 == 10)
			{
				sprites[characterSpriteIndex].location = WALKING1_SPRITE_LOC;
				sprites[characterSpriteIndex].boundingBox = characterWalkingRightBBox;
			}
			else if (walkingCounter % 40 == 20)
			{
				sprites[characterSpriteIndex].location = SIDEWAYS_SPRITE_LOC;
				sprites[characterSpriteIndex].boundingBox = characterStandingRightBBox;
			}
			else if (walkingCounter % 40 == 30)
			{
				sprites[characterSpriteIndex].location = WALKING2_SPRITE_LOC;
				sprites[characterSpriteIndex].boundingBox = characterWalkingRightBBox;
			}
			else if (walkingCounter % 40 == 0)
			{
				sprites[characterSpriteIndex].location = SIDEWAYS_SPRITE_LOC;
				sprites[characterSpriteIndex].boundingBox = characterStandingRightBBox;
			}
		}
		sprites[characterSpriteIndex].hFlip = false;
		sprites[characterSpriteIndex].dir = RIGHT;
		int prevX;
		if (sprites[characterSpriteIndex].x < 120 || screenRight >= MAP_WIDTH - 1)
		{	
			prevX = sprites[characterSpriteIndex].x;
			sprites[characterSpriteIndex] = Move(sprites[characterSpriteIndex].dir, sprites[characterSpriteIndex]);
			if (prevX != sprites[characterSpriteIndex].x)
				walkingCounter++;
		}
		else
		{
			prevX = sprites[characterSpriteIndex].mapX;
			sprites[characterSpriteIndex].dir = RIGHT;
			MoveMapRight();
			if (prevX != sprites[characterSpriteIndex].mapX)
			{
				walkingCounter++;
				projectileMoveCounter = sprites[characterSpriteIndex].mapX - prevX;
				mapMoved = RIGHT;
			}
		}
	}
		
	if (keyHeld(BUTTON_LEFT))
	{
		if (!isJumping)
		{
			if (walkingCounter % 40 == 10)
			{
				sprites[characterSpriteIndex].location = WALKING1_SPRITE_LOC;
				sprites[characterSpriteIndex].boundingBox = characterWalkingLeftBBox;
			}
			else if (walkingCounter % 40 == 20)
			{
				sprites[characterSpriteIndex].location = SIDEWAYS_SPRITE_LOC;
				sprites[characterSpriteIndex].boundingBox = characterStandingLeftBBox;
			}
			else if (walkingCounter % 40 == 30)
			{
				sprites[characterSpriteIndex].location = WALKING2_SPRITE_LOC;
				sprites[characterSpriteIndex].boundingBox = characterWalkingLeftBBox;
			}
			else if (walkingCounter % 40 == 0)
			{
				sprites[characterSpriteIndex].location = SIDEWAYS_SPRITE_LOC;
				sprites[characterSpriteIndex].boundingBox = characterStandingLeftBBox;
			}
		}	
		sprites[characterSpriteIndex].hFlip = true;
		sprites[characterSpriteIndex].dir = LEFT;
		int prevX;
		if (sprites[characterSpriteIndex].x > 120 || screenLeft == 0)
		{
			prevX = sprites[characterSpriteIndex].x;
			sprites[characterSpriteIndex] = Move(sprites[characterSpriteIndex].dir, sprites[characterSpriteIndex]);
			if (prevX != sprites[characterSpriteIndex].x)
				walkingCounter++;
		}
		else
		{
			prevX = sprites[characterSpriteIndex].mapX;
			sprites[characterSpriteIndex].dir = LEFT;
			MoveMapLeft();
			if (prevX != sprites[characterSpriteIndex].mapX)
			{
				walkingCounter++;
				projectileMoveCounter = prevX - sprites[characterSpriteIndex].mapX;
				mapMoved = LEFT;
			}
		}
	}
	
	if (keyHit(BUTTON_A))
	{
		SpriteHandler character = sprites[characterSpriteIndex];
		if (character.dir == RIGHT) 
		{
			Shoot(character.x + 20, character.y + 7, character.mapX + 20, character.mapY + 7, character.dir);
		}
		else if (character.dir == LEFT)
		{
			Shoot(character.x + 2, character.y + 7, character.mapX + 2, character.mapY + 7, character.dir);
		}
	}
	
	int i;
	for (i = 0; i < 128; i++)
	{
		if (sprites[i].isProjectile && !sprites[i].isRemoved)
		{
			sprites[i] = Move(sprites[i].dir, sprites[i]);
			if (mapMoved == RIGHT) 
			{
				if (sprites[i].dir == RIGHT) 
				{
					sprites[i].x -= projectileMoveCounter;
					sprites[i].mapX -= projectileMoveCounter;
				}
				else if (sprites[i].dir == LEFT)
				{
					sprites[i].x += projectileMoveCounter;
					sprites[i].mapX += projectileMoveCounter;
				}				
			}
			else if (mapMoved == LEFT)
			{
				if (sprites[i].dir == RIGHT)
				{
					sprites[i].x += projectileMoveCounter;
					sprites[i].mapX += projectileMoveCounter;
				}
				else if (sprites[i].dir == LEFT)
				{
					sprites[i].x -= projectileMoveCounter;
					sprites[i].mapX -= projectileMoveCounter;
				}
			}
		}		
	}
	
	if (!keyHeld(BUTTON_LEFT) && !keyHeld(BUTTON_RIGHT) && !isJumping)
	{
		sprites[characterSpriteIndex].location = SIDEWAYS_SPRITE_LOC;
		if (sprites[characterSpriteIndex].dir == RIGHT)
			sprites[characterSpriteIndex].boundingBox = characterStandingRightBBox;
		else if (sprites[characterSpriteIndex].dir == LEFT)
			sprites[characterSpriteIndex].boundingBox = characterStandingLeftBBox;
	}
	
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
			if (!CanMoveDown(sprites[i]))
			{
				if (isJumping)
				{	
					sprites[characterSpriteIndex].location = SIDEWAYS_SPRITE_LOC;
					if (sprites[characterSpriteIndex].dir == RIGHT)
						sprites[characterSpriteIndex].boundingBox = characterStandingRightBBox;
					else if (sprites[characterSpriteIndex].dir == LEFT)
						sprites[characterSpriteIndex].boundingBox = characterStandingLeftBBox;
					isJumping = false;
				}
				break;
			}
				
			sprites[i].y++;
			sprites[i].mapY++;
		}
	}
}

int GetNextTile(int x, int y)
{
	y %= 256;
	x %= 256;
	return bg1map[(y / 8) * 32 + (x / 8)];
}

void Shoot(int startX, int startY, int mapX, int mapY, Direction dir)
{
	int location = GetNextFreePosition(sprites, 128);
	BoundingBox laserBBox;
	laserBBox.x = 0;
	laserBBox.y = 0;
	laserBBox.xsize = 8;
	laserBBox.ysize = 8;
	sprites[location].y = startY;
	sprites[location].x = startX;
	sprites[location].mapX = mapX;
	sprites[location].mapY = mapY;
	sprites[location].size = SIZE_8;
	sprites[location].shape = SQUARE;
	sprites[location].location = LASER_SPRITE_LOC;
	sprites[location].boundingBox = laserBBox;
	sprites[location].noGravity = true;
	sprites[location].isProjectile = true;
	sprites[location].speed = 5;
	sprites[location].isRemoved = false;
	sprites[location].dir = dir;

	numberOfSprites++;
}

SpriteHandler Move(Direction direction, SpriteHandler sprite)
{
	switch(direction)
	{
		case LEFT:
		{
			if (sprite.mapX > 0 && CanMoveLeft(sprite))
			{
				sprite.x -= sprite.speed;
				sprite.mapX -= sprite.speed;
				if (sprite.isProjectile && sprite.x == 0)
				{
					sprite = RemoveSprite(sprite);
				}
			}
			else
			{
				if (sprite.isProjectile)
				{
					sprite = RemoveSprite(sprite);
				}
			}
			break;
		}
		case RIGHT:
		{
			if (sprite.mapX < MAP_WIDTH - 1 && CanMoveRight(sprite))
			{
				sprite.x += sprite.speed;
				sprite.mapX += sprite.speed;
			}
			else
			{
				if (sprite.isProjectile)
				{
					sprite = RemoveSprite(sprite);
				}
			}
			break;
		}
		case UP:
		{
			if (sprite.mapY > 0 && CanMoveUp(sprite))
			{
				sprite.y--;
				sprite.mapY--;
			}
			break;
		}
		default:
			break;
	}
	
	return sprite;
}

void MoveMapLeft()
{
	//int x = sprites[characterSpriteIndex].mapX;
	//int y = sprites[characterSpriteIndex].mapY;
	if (screenLeft > 0 && CanMoveLeft(sprites[characterSpriteIndex]))
	{
		regX--;
		if (mapLeft > 0)
		{
			mapLeft--; mapRight--;
		}
		
		prevColumn = screenLeft / 8;
		screenLeft--; screenRight--;
		sprites[characterSpriteIndex].mapX -= sprites[characterSpriteIndex].speed;
		nextColumn = screenLeft / 8;
		if (nextColumn < prevColumn)
		{
			CopyColumnToBackground(screenLeft, nextColumn, mapTop, mapBottom, map, bg0map, MAP_COLUMNS);
			CopyColumnToBackground(screenLeft, nextColumn, mapTop, mapBottom, hitMap, bg1map, MAP_COLUMNS);
		}
	}
}

void MoveMapRight()
{
	//int x = sprites[characterSpriteIndex].mapX;
	//int y = sprites[characterSpriteIndex].mapY;
	if (screenRight < MAP_WIDTH - 1 && CanMoveRight(sprites[characterSpriteIndex]))
	{
		regX++;
		if (mapRight < MAP_WIDTH - 1)
		{
			mapRight++; mapLeft++;
		}
		
		prevColumn = screenRight / 8;
		screenLeft++; screenRight++;
		sprites[characterSpriteIndex].mapX += sprites[characterSpriteIndex].speed;
		nextColumn = screenRight / 8;
		if (nextColumn > prevColumn)
		{
			CopyColumnToBackground(screenRight, nextColumn, mapTop, mapBottom, map, bg0map, MAP_COLUMNS);
			CopyColumnToBackground(screenRight, nextColumn, mapTop, mapBottom, hitMap, bg1map, MAP_COLUMNS);
		}
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

int CanMove(int x, int y)
{
	return GetNextTile(x,y) != 2;
}

int CanMoveRight(SpriteHandler sprite)
{
	int y = sprite.mapY;
	int x = sprite.mapX + sprite.boundingBox.xsize + sprite.boundingBox.x;
	if (!CanMove(x + 1, y)) 
	{
		return 0;
	}
	
	int halfYSize = sprite.boundingBox.ysize / 2;
	y += halfYSize;
	if (!CanMove(x + 1, y))
	{
		return 0;
	}
	
	y += halfYSize - 1;
	if (!CanMove(x + 1,y))
	{
		return 0;
	}
	
	return 1;
}

int CanMoveLeft(SpriteHandler sprite)
{
	int y = sprite.mapY;
	int x = sprite.mapX + sprite.boundingBox.x;
	if (!CanMove(x - 1, y))
	{
		return 0;
	}
	int halfYSize = sprite.boundingBox.ysize / 2;
	y += halfYSize;
	if (!CanMove(x - 1, y))
	{
		return 0;
	}
	
	y += halfYSize - 1;
	if (!CanMove(x - 1,y))
	{
		return 0;
	}
	
	return 1;
}

int CanMoveUp(SpriteHandler sprite)
{
	int y = sprite.mapY;
	int x = sprite.mapX + sprite.boundingBox.x;
	if (!CanMove(x, y)) 
	{
		return 0;
	}
	
	int halfXSize = sprite.boundingBox.xsize / 2;
	x += halfXSize;
	if (!CanMove(x, y))
	{
		return 0;
	}
	
	x += halfXSize;
	if (!CanMove(x,y))
	{
		return 0;
	}
	
	return 1;
}

int CanMoveDown(SpriteHandler sprite)
{
	int y = sprite.mapY + sprite.boundingBox.ysize;
	int x = sprite.mapX + sprite.boundingBox.x;
	if (!CanMove(x, y)) 
	{
		return 0;
	}
	
	int halfXSize = sprite.boundingBox.xsize / 2;
	x += halfXSize;
	if (!CanMove(x, y))
	{
		return 0;
	}
	
	x += halfXSize;
	if (!CanMove(x,y))
	{
		return 0;
	}
	
	return 1;
}

SpriteHandler RemoveSprite(SpriteHandler sprite)
{
	sprite.x = 240;
	sprite.y = 160;
	sprite.isRemoved = true;
	
	return sprite;
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