//OAM
#define SpriteMem ((unsigned short*)0x7000000)
//Sprite Image data
#define SpriteData ((unsigned short*) 0x6010000)
//Sprite Palette
#define SpritePal ((unsigned short*) 0x5000200)
//other constants
#define OBJ_MAP_2D 0x0
#define OBJ_MAP_1D 0x40
#define OBJ_ENABLE 0x1000

//attribute0 stuff
#define ROTATION_FLAG 		0x100
#define SIZE_DOUBLE			0x200
#define MODE_NORMAL     	0x0
#define MODE_TRANSPERANT    0x400
#define MODE_WINDOWED		0x800
#define MOSAIC				0x1000
#define COLOR_16			0x0000
#define COLOR_256			0x2000
#define SQUARE              0x0
#define TALL                0x8000
#define WIDE                0x4000

//attribute1 stuff
#define ROTDATA(n)          ((n) << 9)
#define HORIZONTAL_FLIP		0x1000
#define VERTICAL_FLIP		0x2000
#define SIZE_8              0x0
#define SIZE_16             0x4000
#define SIZE_32             0x8000
#define SIZE_64             0xC000

//attribute2 stuff
#define PRIORITY(n)		((n) << 10)
#define PALETTE(n)		((n) << 12)

typedef struct boundingBox {
	int x;
	int y;
	int xsize;
	int ysize;
} BoundingBox;

typedef struct Sprite
{
	unsigned short attribute0;
	unsigned short attribute1;
	unsigned short attribute2;
	unsigned short attribute3;
}Sprite,*pSprite;

typedef struct SpriteHandler
{
	int x, y;
	int mapX, mapY;
	int size, shape;
	int dirx, diry;
	int alive;
	int hFlip;
	int vFlip;
	int location;
	int noGravity;
	int isProjectile;
	int speed;
	int isRemoved;
	BoundingBox boundingBox;
}SpriteHandler;

//attribute0: color mode, shape and y pos
//sprites[0].attribute0 = COLOR_256 | TALL | 96;
//attribute1: size and x pos
//sprites[0].attribute1 = SIZE_32 | 40;
//attribute2: Image location
//sprites[0].attribute2 = 0;
void UpdateSpriteMemory(SpriteHandler* sprites, int count)
{	
	Sprite tempSprites[count];
	int i;
	for (i = 0; i < count; i++)
	{
		Sprite sprite;
		sprite.attribute0 = COLOR_256 | sprites[i].shape | sprites[i].y;
		sprite.attribute1 = sprites[i].size;
		if (sprites[i].hFlip)
			sprite.attribute1 |= HORIZONTAL_FLIP;
		if (sprites[i].vFlip)
			sprite.attribute1 |= VERTICAL_FLIP;
		sprite.attribute1 |= sprites[i].x;
		sprite.attribute2 = sprites[i].location;
		tempSprites[i] = sprite;
	}
	DMAFastCopy((void*)tempSprites, (void*)SpriteMem, 512, DMA_16NOW);
}

int GetNextFreePosition(SpriteHandler* sprites, int count)
{
	int i;
	for (i = 0; i < count; i++)
	{
		if (sprites[i].isRemoved)
			return i;
	}
}

