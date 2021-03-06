typedef signed short    s16;
typedef unsigned short  u16;
typedef unsigned int    u32;
typedef signed int      s32;


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

#define ALIGN4 __attribute__((aligned(4)))

typedef enum direction {
	LEFT,
	RIGHT,
	UP,
	DOWN
} Direction;

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
	int size, shape;
	int fixedPointX, fixedPointY;
	signed short DV_x, DV_y;
	int aff;
	int affIndex;
	int mapFixedPointX, mapFixedPointY;
	int mapX, mapY;
	int hits;
	int alive;
	int hFlip;
	int vFlip;
	int location;
	int noGravity;
	int isProjectile;
	int isHUD;
	int isEnemy;
	int speed;
	int isRemoved;
	int explosionCounter;
	int centerX, centerY;
	int radius2;
	int angle;
	int oscillate;
	int seen;
	Direction dir;
	BoundingBox boundingBox;
}SpriteHandler;

typedef struct OBJ_AFFINE
{
    u16 fill0[3];
    s16 pa;
    u16 fill1[3];
    s16 pb;
    u16 fill2[3];
    s16 pc;
    u16 fill3[3];
    s16 pd;
} ALIGN4 OBJ_AFFINE;

//raidus = 14


void UpdateSpriteMemory(SpriteHandler* sprites, int count)
{	
	Sprite tempSprites[count];
	int i;
	for (i = 0; i < count; i++)
	{
		Sprite sprite;
		sprite.attribute0 = COLOR_256 | sprites[i].shape | (sprites[i].y & 0x00FF);
		sprite.attribute1 = sprites[i].size | (sprites[i].x & 0x01FF);
		if (sprites[i].hFlip)
			sprite.attribute1 |= HORIZONTAL_FLIP;
		if (sprites[i].vFlip)
			sprite.attribute1 |= VERTICAL_FLIP;
		sprite.attribute2 = sprites[i].location;
		tempSprites[i] = sprite;
	}
	DMAFastCopy((void*)tempSprites, (void*)SpriteMem, 512, DMA_16NOW);
}

void UpdateSpriteMemorySpace(SpriteHandler* spriteHandlers, Sprite *sprites, OBJ_AFFINE *obj_aff_buffer)
{
        // update sprites with changed data
        int i;
        for(i = 0; i < 128; i++)
        {
            sprites[i].attribute0 = COLOR_256 | spriteHandlers[i].shape | (spriteHandlers[i].y & 0x00FF);
            //sprites[i].attribute0 = (sprites[i].attribute0 &~ 0x00FF)
            sprites[i].attribute1 = spriteHandlers[i].size | (spriteHandlers[i].x & 0x01FF);
           // sprites[i].attribute1 = (sprites[i].attribute1 &~ 0x00FF) | (spriteHandlers[i].x & 0x01FF);
            if(spriteHandlers[i].aff == 1)
            {
                sprites[i].attribute0 |= ROTATION_FLAG;
                sprites[i].attribute1 |= ROTDATA(spriteHandlers[i].affIndex);
            }
            sprites[i].attribute2 = spriteHandlers[i].location;
        }
        // copy sprite data into hardware memory
		DMAFastCopy((void*)sprites, (void*)SpriteMem, 512, DMA_16NOW);
		
		//Copy in affine matrices
        int n;
		i = 3;
		for(n = 0; n < 32; n++)
		{
		  SpriteMem[i] = (obj_aff_buffer[n]).pa;
		  i+=4;
		  SpriteMem[i] = (obj_aff_buffer[n]).pb;
		  i+=4;
		  SpriteMem[i] = (obj_aff_buffer[n]).pc;
		  i+=4;
		  SpriteMem[i] = (obj_aff_buffer[n]).pd;
		  i+=4;
		}		
}



int GetNextFreePosition(SpriteHandler* sprites, int count, int start)
{
	int i;
	for (i = start; i < count; i++)
	{
		if (sprites[i].isRemoved)
			return i;
	}
	return -1;
}

inline s32 Sin_val(u32 angle)
{
    return sin_lut[(angle>>7)&0x1FF];
}

inline s32 Cos_val(u32 angle)
{
    return sin_lut[((angle>>7)+128)&0x1FF];
}


void obj_aff_rotate(OBJ_AFFINE *oaff, unsigned short angle)
{
    int ss= Sin_val(angle), cc= Cos_val(angle);

    oaff->pa= cc>>4;    oaff->pb=-ss>>4;
    oaff->pc= ss>>4;    oaff->pd= cc>>4;
}

