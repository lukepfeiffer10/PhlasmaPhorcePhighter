#include "settings.h"
#include "ship_image.h"
#include "LUT_sin_cos.h"
#include "mapfiles.h"
#include "sprites.h"
#include <Math.h>


#define MAP_WIDTH 800
#define MAP_HEIGHT 560
#define MAP_COLUMNS 100
#define MAP_ROWS 70
#define BACKGROUND_WIDTH 1028
#define BACKGROUND_HEIGHT 1028
#define BACKGROUND_MAP_COLUMNS 128
#define BACKGROUND_MAP_ROWS 128
#define PI 3.14159265



unsigned short angle = 0;

int mapLeft = 0, mapRight = 255, screenLeft = 0, screenRight = 239, nextColumn = 0, prevColumn = 0;
int mapTop = 0, mapBottom = 255, screenTop = 0, screenBottom = 159, nextRow = 0, prevRow = 0;
int moveRight = 0, moveLeft = 0, moveDown = 0, moveUp = 0;
int prevX, prevY ,spaceX, spaceY, movedLeft, movedRight, movedUp, movedDown, rotate, numSprites, numAffSprites, affIndex, currentLeftX_C, currentRightX_C, currentTopY_C, currentBottomY_C, numEnemies, mx, my;
int laserOffset = 3;
int laserYOffset = 4;
int counterFixedPointX = 0;
int counterFixedPointY = 0;
int timeSeed, randSet, enemiesKilled;
int DtoROffset = 180/PI;


unsigned short* bg0map =(unsigned short*)ScreenBaseBlock(31);

SpriteHandler sprites[128];
Sprite Sprites[128];
OBJ_AFFINE *const obj_aff_buffer = (OBJ_AFFINE*)Sprites;




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

void checkRight()
{
   
        if (mapRight < MAP_WIDTH - 1)
        {
				mapRight++; mapLeft++;
        }
				
        prevColumn = screenRight / 8;
        screenLeft++; screenRight++;
        nextColumn = screenRight / 8;
        if (nextColumn > prevColumn)
        {
            moveRight = 1;
        }
    
}
void checkLeft()
{
        if (mapLeft > 0)
        {
            mapLeft--; mapRight--;
        }
				
        prevColumn = screenLeft / 8;
        screenLeft--; screenRight--;
        nextColumn = screenLeft / 8;
        if (nextColumn < prevColumn)
        {
            moveLeft = 1;
        }
}
void checkUp()
{
        if (mapTop > 0)
        {
            mapTop--;	mapBottom--;
        }
				
        prevRow = screenTop / 8;
        screenTop--; screenBottom--;
        nextRow = screenTop / 8;
        if (nextRow < prevRow)
        {
            moveUp = 1;
        }
}
void checkDown()
{
    
        if (mapBottom < MAP_HEIGHT - 1)
        {
            mapTop++; mapBottom++;
        }

        prevRow = screenBottom / 8;
        screenTop++; screenBottom++;
        nextRow = screenBottom / 8;
        if (nextRow > prevRow)
        {
            moveDown = 1;
        }
  
}

int checkScrollDirection(int prevX, int prevY, int x, int y)
{
        int badmove = 1;
        moveRight = 0, moveLeft = 0, moveDown = 0, moveUp = 0;
        
        /* Check the 8 possible move combinations to ensure correct bounds checking
            If the move is possible call the corresponding direction checks that update scrolling values
            If move is not possible we return badmove and the x and y values are fixed*/
        if(prevX < x && prevY < y) /* move right and down */
        {
            if (screenRight < MAP_WIDTH - 1 && screenBottom < MAP_HEIGHT - 1)
            {
                checkRight();
                checkDown();
            }
            else
            {
                return badmove;
            }
        }
        else if(prevX < x && prevY > y) /* move right and up */
        {
            if (screenRight < MAP_WIDTH - 1 && screenTop > 0)
            {
                checkRight();
                checkUp();
            }
            else
            {
                return badmove;
            }
        }
        else if(prevX > x && prevY < y) /* move left and down */
        {
            if(screenLeft > 0 && screenBottom < MAP_HEIGHT - 1)
            {
                checkLeft();
                checkDown();
            }
            else
            {
                return badmove;
            }
        }
        else if(prevX > x && prevY > y) /* move left and up */
        {
             if (screenTop > 0 && screenLeft > 0)
             {
                 checkLeft();
                 checkUp();
             }
             else
             {
                 return badmove;
             }
        }
        else if(prevX < x) /* move right */
        {
            if (screenRight < MAP_WIDTH - 1)
            {
                checkRight();
            }
            else
            {
                return badmove;
            }
        }
        else if(prevX > x) //moveLeft
        {
           if (screenLeft > 0)
           {
               checkLeft();
           }
           else
           {
               return badmove;
           }
        }
        else if(prevY < y) //moveDown
        {
            if (screenBottom < MAP_HEIGHT - 1)
            {
                checkDown();
            }
            else
            {
                return badmove;
            }
        }
        else if(prevY > y) //moveUp
        {
          if (screenTop > 0)
          {
                checkUp();
          }
          else
          {
                return badmove;
          }
        }
       
       /* copy necessary map rows and/or columns to the background buffer */
        if (moveLeft)
		{
			CopyColumnToBackground(screenLeft, nextColumn, mapTop, mapBottom, starmapscrn_Map, bg0map, MAP_COLUMNS);
		}
		if (moveRight)
		{
			CopyColumnToBackground(screenRight, nextColumn, mapTop, mapBottom, starmapscrn_Map, bg0map, MAP_COLUMNS);
		}
        if (moveUp)
		{
			CopyRowToBackground(screenTop, nextRow, mapLeft, mapRight, starmapscrn_Map, bg0map, MAP_COLUMNS);
		}
		if (moveDown)
		{
			CopyRowToBackground(screenBottom, nextRow, mapLeft, mapRight, starmapscrn_Map, bg0map, MAP_COLUMNS);
		}
		return 0;
}

void SpaceShoot()
{
	int i = GetNextFreePosition(sprites, 20);
	if ( i != -1)
	{
        sprites[i].isRemoved = 0;
	   sprites[i].DV_x = sprites[0].DV_x;
	   sprites[i].DV_y = sprites[0].DV_y;
	   sprites[i].fixedPointX = (111<<12) - (9 * sprites[0].DV_x);
	   sprites[i].fixedPointY = (73<<12) - (9 * sprites[0].DV_y);
	   sprites[i].y = sprites[i].fixedPointX>>12;// - (15<<12);
	   sprites[i].x = sprites[i].fixedPointY>>12;// - (15<<12);
	   sprites[i].aff = 1;
	   sprites[i].size = SIZE_16;
	   sprites[i].location = 288;
	   sprites[i].explosionCounter = 0;
	
       (obj_aff_buffer[i]).pa = (obj_aff_buffer[0]).pa;
       (obj_aff_buffer[i]).pd = (obj_aff_buffer[0]).pd;
       (obj_aff_buffer[i]).pb = (obj_aff_buffer[0]).pb;
       (obj_aff_buffer[i]).pc = (obj_aff_buffer[0]).pc;
       sprites[i].affIndex = i;
   }
}

/* consider embedding within a loop as well */
void moveLaser(int i)
{
        if(sprites[i].isProjectile && !sprites[i].isRemoved)
        {
            sprites[i].fixedPointX -= (sprites[i].DV_x + sprites[i].DV_x);
            sprites[i].fixedPointY -= (sprites[i].DV_y + sprites[i].DV_y);
            sprites[i].x = sprites[i].fixedPointX>>12;
            sprites[i].y = sprites[i].fixedPointY>>12;
            if(sprites[i].x < -16 || sprites[i].x > 239 || sprites[i].y < -16 || sprites[i].y > 159)
            {
                sprites[i].isRemoved = 1;
                sprites[i].x = 240;
                sprites[i].y = 160;
            }
        }
  
}

int checkLeftTop(int rad)
{
    if(currentLeftX_C + currentTopY_C < rad)
    {
        return 1;
    }
    return 0;
    
}
int checkRightTop(int rad)
{
    if(currentRightX_C + currentTopY_C < rad)
    {
        return 1;
    }
    return 0;
}
int checkRightBottom(int rad)
{
    if(currentRightX_C + currentBottomY_C < rad)
    {
        return 1;
    }
    return 0;
}
int checkLeftBottom(int rad)
{
    if(currentLeftX_C + currentBottomY_C < rad)
    {
        return 1;
    }
    return 0;
}

void leftX_C(int i, int k, int Offset )
{
    currentLeftX_C = (sprites[i].x + Offset - sprites[k].centerX) * (sprites[i].x + Offset - sprites[k].centerX);
}
void rightX_C(int i, int k, int Offset)
{
    currentRightX_C = (sprites[i].x + sprites[i].boundingBox.xsize - Offset - sprites[k].centerX) * (sprites[i].x + sprites[i].boundingBox.xsize - Offset - sprites[k].centerX);
}
void topY_C(int i, int k, int Offset)
{
    currentTopY_C = (sprites[i].y + Offset - sprites[k].centerY) * (sprites[i].y + Offset - sprites[k].centerY);
}
void bottomY_C(int i, int k, int Offset)
{
     currentBottomY_C = (sprites[i].y + sprites[i].boundingBox.ysize + Offset - sprites[k].centerY) * (sprites[i].y + sprites[i].boundingBox.ysize + Offset - sprites[k].centerY);
}

void collisionDetect()
{
    int i;
    int k;
    int rad;
    for(k = 20; k < 20 + numEnemies; k++)
    {
        if(!sprites[k].isRemoved)
        {
            for(i = 1; i < 20; i++)
            {
                if(!sprites[i].isRemoved && sprites[i].explosionCounter == 0)
                {
                    leftX_C(i, k, laserOffset);  rightX_C(i, k, laserOffset); topY_C(i, k, laserYOffset); bottomY_C(i, k, 0);
                    rad = sprites[k].radius2;
                    if(checkLeftBottom(rad) || checkRightBottom(rad) || checkLeftTop(rad) || checkRightTop(rad))
                    {
                        sprites[k].hits++;
                        sprites[100].x = sprites[k].x;
                        sprites[100].y = sprites[k].y;
                        sprites[100].fixedPointX = sprites[k].fixedPointX;
                        sprites[100].fixedPointY = sprites[k].fixedPointY;
                        sprites[100].isRemoved = 0;
                        
                        if(sprites[k].hits == 5)
                        {

                            sprites[103].x = sprites[k].x;
                            sprites[103].y = sprites[k].y;
                            sprites[103].fixedPointX = sprites[k].fixedPointX;
                            sprites[103].fixedPointY = sprites[k].fixedPointY;
                            sprites[103].isRemoved = 0;
                            sprites[100].x = 240;
                            sprites[100].y = 240;
                            sprites[100].isRemoved = 1;
                            sprites[i].x = 240;
                            sprites[i].y = 160;
                            sprites[k].isRemoved = 1;
                            sprites[k].x = 240;
                            sprites[k].y = 160;
                            sprites[k].alive = 0;
                            enemiesKilled++;
                        }

                        //sprites[i].explosionCounter++;

                            sprites[i].size = SIZE_8;
                            sprites[i].location = 296;
                    
                        sprites[i].isRemoved = 0;
                        sprites[i].fixedPointX -= (sprites[i].DV_x); //+ sprites[i].DV_x + sprites[i].DV_x);
                        sprites[i].fixedPointY -= (sprites[i].DV_y - (4<<12)); //+ sprites[i].DV_y + sprites[i].DV_x);
                        sprites[i].x = sprites[i].fixedPointX>>12;
                        sprites[i].y = sprites[i].fixedPointY>>12;

                    }
                }

                
            }
        }
    }
}

void CalcCounterShipMovement()
{
    /* Determine what direction we moved and calculate the correction x and y values to counter with */
    
    if(movedUp && movedRight)
    {
        counterFixedPointX =  sprites[0].DV_x - sprites[0].DV_y;
        counterFixedPointY =  sprites[0].DV_y + sprites[0].DV_x;
    }
    else if(movedDown && movedRight)
    {
        counterFixedPointX = -sprites[0].DV_x - sprites[0].DV_y;
        counterFixedPointY = -sprites[0].DV_y + sprites[0].DV_x;
    }
    else if(movedUp && movedLeft)
    {
        counterFixedPointX =  sprites[0].DV_x + sprites[0].DV_y;
        counterFixedPointY =  sprites[0].DV_y - sprites[0].DV_x;
    }
    else if(movedDown && movedLeft)
    {
       counterFixedPointX = -sprites[0].DV_x + sprites[0].DV_y;
       counterFixedPointY = -sprites[0].DV_y - sprites[0].DV_x;
    }
    else if(movedUp)
    {
        counterFixedPointX =  sprites[0].DV_x;
        counterFixedPointY =  sprites[0].DV_y;
    }
    else if(movedDown)
    {
        counterFixedPointX = -sprites[0].DV_x;
        counterFixedPointY = -sprites[0].DV_y;
    }
    else if(movedLeft)
    {
        counterFixedPointX =  sprites[0].DV_y;
        counterFixedPointY = -sprites[0].DV_x;
    }
    else if(movedRight)
    {
        counterFixedPointX = -sprites[0].DV_y;
        counterFixedPointY =  sprites[0].DV_x;
    }
    
}

void counterShipMovement(int i)
{
        if(!(sprites[i].isRemoved) || sprites[i].explosionCounter > 0)
        {
            sprites[i].fixedPointX += counterFixedPointX;
            sprites[i].fixedPointY += counterFixedPointY;
            sprites[i].x = sprites[i].fixedPointX>>12;
            sprites[i].y = sprites[i].fixedPointY>>12;
            sprites[i].mapFixedPointX += counterFixedPointX;
            sprites[i].mapFixedPointY += counterFixedPointY;
            mx = sprites[i].mapFixedPointX>>12;
            my = sprites[i].mapFixedPointY>>12;
            if(mx < MAP_WIDTH - 32 && my < MAP_HEIGHT - 32 && mx > 0 && my > 0)
            {
                sprites[i].mapX = sprites[i].mapFixedPointX>>12;
                sprites[i].mapY = sprites[i].mapFixedPointY>>12;
            }
            else
            {
                sprites[i].mapFixedPointX -= counterFixedPointX;
                sprites[i].mapFixedPointY -= counterFixedPointY;
            }
            if(sprites[i].x < -sprites[i].boundingBox.xsize || sprites[i].x > 239 || sprites[i].y < -sprites[i].boundingBox.ysize || sprites[i].y > 159)
            {
                sprites[i].isRemoved = 1;
                sprites[i].x = 240;
                sprites[i].y = 160;
            }
        }
}

void findEnemies(int i)
{
        if((sprites[i].mapX > screenLeft || sprites[i].mapX + sprites[i].boundingBox.xsize > screenLeft) && sprites[i].mapX < screenRight && (sprites[i].mapY > screenTop || sprites[i].mapY + sprites[i].boundingBox.ysize > screenTop) && sprites[i].mapY < screenBottom && sprites[i].alive)
        {
            sprites[i].x = sprites[i].mapX - screenLeft;
            sprites[i].y = sprites[i].mapY - screenTop;
            sprites[i].fixedPointX = (sprites[i].x)<<12;
            sprites[i].fixedPointY = (sprites[i].y)<<12;
            sprites[i].isRemoved = 0;
            sprites[i].seen = 1;
        }
}

void rotAI(int i)
{
    if(sprites[i].angle < 0)
    {
        sprites[i].angle = (512<<7);
    }

    if(sprites[i].angle > (512<<7))
    {
        sprites[i].angle = 0;
    }

        if(sprites[i].mapX < sprites[0].mapX && sprites[i].mapY > sprites[0].mapY) /* quadrant 1 */
        {
            if(sprites[i].angle < (384<<7) && sprites[i].angle > (192<<7))
            {
                sprites[i].angle += 240;
            }
            else if(sprites[i].angle > (0 << 7) && sprites[i].angle < (192<<7))
            {
                sprites[i].angle -= 240;
            }
            else
            {
                if(sprites[i].oscillate == 0)
                {
                    sprites[i].angle -= 240;
                    if(sprites[i].angle < (384<<7))
                    {
                        sprites[i].oscillate = 1;
                    }
                }
                else
                {
                    sprites[i].angle += 240;
                    if(sprites[i].angle > (511<<7))
                    {
                        sprites[i].angle -= 240;
                        sprites[i].oscillate = 0;
                    }
                }
            }
        }
        if(sprites[i].mapX > sprites[0].mapX && sprites[i].mapY > sprites[0].mapY) /* quadrant 2 */
        {
            if(sprites[i].angle < (512<<7) && sprites[i].angle > (320<<7))
            {
                sprites[i].angle += 240;
            }
            else if(sprites[i].angle > (128 << 7) && sprites[i].angle < (320<<7))
            {
                sprites[i].angle -= 240;
            }
            else
            {
                if(sprites[i].oscillate == 0)
                {
                    sprites[i].angle += 240;
                    if(sprites[i].angle > (128<<7))
                    {
                        sprites[i].oscillate = 1;
                    }
                }
                else
                {
                    sprites[i].angle -= 240;
                    if(sprites[i].angle < (1 << 7))
                    {
                        sprites[i].angle += 240;
                        sprites[i].oscillate = 0;
                    }
                }
            }
        }
        if(sprites[i].mapX > sprites[0].mapX && sprites[i].mapY < sprites[0].mapY) /* quadrant 3 */
        {
            if(sprites[i].angle < (128<<7) || sprites[i].angle > (448<<7))
            {
                sprites[i].angle += 240;
            }
            else if(sprites[i].angle > (256 << 7) && sprites[i].angle < (448<<7))
            {
                sprites[i].angle -= 240;
            }
            else
            {
                if(sprites[i].oscillate == 0)
                {
                    sprites[i].angle += 240;
                    if(sprites[i].angle > (256<<7))
                    {
                        sprites[i].oscillate = 1;
                    }
                }
                else
                {
                    sprites[i].angle -= 240;
                    if(sprites[i].angle < (128 << 7))
                    {
                        sprites[i].oscillate = 0;
                    }
                }
            }
        }
        if(sprites[i].mapX < sprites[0].mapX && sprites[i].mapY < sprites[0].mapY) /* quadrant 4 */
        {
            if(sprites[i].angle > (64<<7) && sprites[i].angle < (256<<7))
            {
                sprites[i].angle += 240;
            }
            else if(sprites[i].angle < (256 << 7) || sprites[i].angle > (384<<7))
            {
                sprites[i].angle -= 240;
            }
            else
            {
                if(sprites[i].oscillate == 0)
                {
                    sprites[i].angle += 240;
                    if(sprites[i].angle > (384<<7))
                    {
                        sprites[i].oscillate = 1;
                    }
                }
                else
                {
                    sprites[i].angle -= 240;
                    if(sprites[i].angle < (256 << 7))
                    {
                        sprites[i].oscillate = 0;
                    }
                }
            }
        }
       
            obj_aff_rotate(&obj_aff_buffer[i], sprites[i].angle);

        sprites[i].DV_y = Cos_val(sprites[i].angle);
        sprites[i].DV_x = Sin_val(sprites[i].angle);
}

void moveAI(int i)
{
    if(!sprites[i].isRemoved)
    {
        sprites[i].fixedPointX -= sprites[i].DV_x;
        sprites[i].fixedPointY -= sprites[i].DV_y;
        sprites[i].x = sprites[i].fixedPointX>>12;
        sprites[i].y = sprites[i].fixedPointY>>12;
        if(sprites[i].x < -32 || sprites[i].x > 239 || sprites[i].y < -32 || sprites[i].y > 159)
        {
                sprites[i].isRemoved = 1;
                sprites[i].x = 240;
                sprites[i].y = 160;
        }
    }
        sprites[i].mapFixedPointX -= sprites[i].DV_x;
        sprites[i].mapFixedPointY -= sprites[i].DV_y;
        mx = sprites[i].mapFixedPointX>>12;
        my = sprites[i].mapFixedPointY>>12;
        if(mx < MAP_WIDTH - 32 && my < MAP_HEIGHT - 32 && mx > 0 && my > 0)
        {
            sprites[i].mapX = mx;
            sprites[i].mapY = my;
        }
        else
        {
            sprites[i].mapFixedPointX += sprites[i].DV_x;
            sprites[i].mapFixedPointY += sprites[i].DV_y;
        }
    

}



void loopThroughSprites()
{
    int i;
    for(i = 1; i < 128; i++)
    {
        if (i > 19 && i < 100)
        {
            findEnemies(i);
            if(!sprites[i].isRemoved )
            {
                sprites[i].centerX = sprites[i].x + ((sprites[i].boundingBox.xsize)>>1) - 1;
                sprites[i].centerY = sprites[i].y + ((sprites[i].boundingBox.ysize)>>1) - 1;
            }
            if(sprites[i].seen && sprites[i].alive)
            {
                rotAI(i);
                moveAI(i);
            }
        }
        if (i < 19)
        {
            moveLaser(i);
            if(sprites[i].location == 296)
            {
                sprites[i].explosionCounter++;
                if(sprites[i].explosionCounter == 15)
                {
                    sprites[i].x = 240;
                    sprites[i].y = 160;
                    sprites[100].x = 240;
                    sprites[100].y = 160;
                    sprites[100].isRemoved = 1;
                    sprites[103].x = 240;
                    sprites[103].y = 160;
                    sprites[103].isRemoved = 1;
                    sprites[i].location = 288;
                    sprites[i].isRemoved = 1;
                    sprites[i].explosionCounter = 0;

                }
            }
        }
        if(movedDown || movedUp || movedLeft || movedRight) /* if the ship moves counter its movement for all other sprites so there map coords are correct */
        {
            counterShipMovement(i);
        }
        
    }
}

void setEnemies()
{
    numEnemies = rand() % 6 + 3;
    int i;
    BoundingBox ShipBBox;
	ShipBBox.x = 0;
	ShipBBox.y = 0;
	ShipBBox.xsize = 32;
	ShipBBox.ysize = 32;
    
    for(i = 20; i < numEnemies + 20; i++)
    {
        sprites[i].angle = 0;
        sprites[i].DV_y = Cos_val(0);
        sprites[i].DV_x = Sin_val(0);
        sprites[i].x = 240;
        sprites[i].y = 160;
        sprites[i].fixedPointX = 240<<12;
        sprites[i].fixedPointY = 160<<12;
        sprites[i].size = SIZE_32;
        sprites[i].shape = SQUARE;
        sprites[i].location = 298;
        sprites[i].isRemoved = 1;
        sprites[i].alive = 1;
        sprites[i].radius2 = 196;
        sprites[i].aff = 1;
        sprites[i].affIndex = i;
        sprites[i].boundingBox = ShipBBox;
        sprites[i].mapX = rand() % (MAP_WIDTH - 32);
        sprites[i].mapY = rand() % (MAP_HEIGHT - 32);
        sprites[i].mapFixedPointX = sprites[i].mapX<<12;
        sprites[i].mapFixedPointY = sprites[i].mapY<<12;
        sprites[i].seen = 0;
        findEnemies(i);
        sprites[i].centerX = sprites[i].x + ((sprites[i].boundingBox.xsize)>>1);
        sprites[i].centerY = sprites[i].y + ((sprites[i].boundingBox.ysize)>>1);
        obj_aff_rotate(&obj_aff_buffer[i], sprites[i].angle);
    }
}



void UpdateSpace()
{
     keyPoll();
     if(randSet == 0)
     {
        timeSeed++;
     }
     movedLeft = 0;
     movedRight = 0;
     movedUp = 0;
     movedDown = 0;
     rotate = 0;


       if(keyHit(BUTTON_START))
       {
           if(randSet == 0)
           {
                srand(timeSeed);
                randSet = 1;
                setEnemies();
           }
       }
        /* if they press either bumper then change the angle and update the direction vectors for the ship sprite handler from the sine cosine lookup tables */
       if (keyHeld(BUTTON_L))
       {
           sprites[0].angle += 240;
           sprites[0].DV_y = Cos_val(sprites[0].angle);
           sprites[0].DV_x = Sin_val(sprites[0].angle);
           rotate = 1;
       }
       if(keyHeld(BUTTON_R))
       {
           sprites[0].angle -= 240;
           sprites[0].DV_y = Cos_val(sprites[0].angle);
           sprites[0].DV_x = Sin_val(sprites[0].angle);
           rotate = 1;
       }
       if (keyHit(BUTTON_A))
       {
           SpaceShoot();
       }

        /* If they press a move key then calculate the new fixed point x and y values from the direction vectors.
            Update the prevX and prevY then update the new spaceX and spaceY with the fixed point x and y right shifted 12 places
            Then check if this move will be a valid move. If not then undo the changes.
            If move is valid then show the correct sprite image for that movement */
       if(keyHeld(BUTTON_LEFT))
       {
           sprites[0].fixedPointX -= sprites[0].DV_y;
           sprites[0].fixedPointY += sprites[0].DV_x;
           prevX = spaceX;
           prevY = spaceY;
           spaceX = sprites[0].fixedPointX>>12;
           spaceY = sprites[0].fixedPointY>>12;
           
           if(checkScrollDirection(prevX, prevY, spaceX, spaceY) == 1)
           {
               spaceX = prevX;
               spaceY = prevY;
               sprites[0].fixedPointX += sprites[0].DV_y;
               sprites[0].fixedPointY -= sprites[0].DV_x;
           }
           else
           {
               sprites[0].location = 32;
               movedLeft = 1;
           }
       }

       if(keyHeld(BUTTON_RIGHT))
       {
           sprites[0].fixedPointX += sprites[0].DV_y;
           sprites[0].fixedPointY -= sprites[0].DV_x;
           prevX = spaceX;
           prevY = spaceY;
           spaceX = sprites[0].fixedPointX>>12;
           spaceY = sprites[0].fixedPointY>>12;

           if(checkScrollDirection(prevX, prevY, spaceX, spaceY) == 1)
           {
               spaceX = prevX;
               spaceY = prevY;
               sprites[0].fixedPointX -= sprites[0].DV_y;
               sprites[0].fixedPointY += sprites[0].DV_x;
           }
           else
           {
               sprites[0].location = 64;
               movedRight = 1;
           }
       }

       if(keyHeld(BUTTON_UP))
       {
           sprites[0].fixedPointX -= sprites[0].DV_x;
           sprites[0].fixedPointY -= sprites[0].DV_y;
           prevX = spaceX;
           prevY = spaceY;
           spaceX = sprites[0].fixedPointX>>12;
           spaceY = sprites[0].fixedPointY>>12;
           
           if(checkScrollDirection(prevX, prevY, spaceX, spaceY) == 1)
           {
               spaceX = prevX;
               spaceY = prevY;
               sprites[0].fixedPointX += sprites[0].DV_x;
               sprites[0].fixedPointY += sprites[0].DV_y;
           }
           else
           {
               sprites[0].location = 96;
               movedUp = 1;
           }
       }

       if(keyHeld(BUTTON_DOWN))
       {
           sprites[0].fixedPointX += sprites[0].DV_x;
           sprites[0].fixedPointY += sprites[0].DV_y;
           prevX = spaceX;
           prevY = spaceY;
           spaceX = sprites[0].fixedPointX>>12;
           spaceY = sprites[0].fixedPointY>>12;
           
           if(checkScrollDirection(prevX, prevY, spaceX, spaceY) == 1)
           {
               spaceX = prevX;
               spaceY = prevY;
               sprites[0].fixedPointX -= sprites[0].DV_x;
               sprites[0].fixedPointY -= sprites[0].DV_y;
           }
           else
           {
               sprites[0].location = 192;
               movedDown = 1;
           }
       }
        /* Update sprite image if moved diagonally or no movement*/
       if(keyIsDown(BUTTON_UP) && keyIsDown(BUTTON_LEFT) && movedUp && movedLeft)
       {
            sprites[0].location = 128;
       }
       if(keyIsDown(BUTTON_UP) && keyIsDown(BUTTON_RIGHT) && movedUp && movedRight)
       {
            sprites[0].location = 160;
       }
       if(keyIsDown(BUTTON_DOWN) && keyIsDown(BUTTON_LEFT) && movedDown && movedLeft)
       {
            sprites[0].location = 224;
       }
       if(keyIsDown(BUTTON_DOWN) && keyIsDown(BUTTON_RIGHT) && movedDown && movedRight)
       {
            sprites[0].location = 256;
       }
       if(!keyIsDown(BUTTON_DOWN) && !keyIsDown(BUTTON_UP) && !keyIsDown(BUTTON_LEFT) && !keyIsDown(BUTTON_RIGHT))
       {
           /* make no thruster */
           sprites[0].location = 0;
       }

       

       if(rotate)
       {
            obj_aff_rotate(&obj_aff_buffer[0], sprites[0].angle);
       }
       REG_BG0VOFS = spaceY;
       REG_BG0HOFS = spaceX;
       sprites[0].mapX = spaceX + 103;
       sprites[0].mapY = spaceY + 63;
       CalcCounterShipMovement();
       loopThroughSprites();
       collisionDetect();
       
       UpdateSpriteMemorySpace(sprites, Sprites, obj_aff_buffer);
       int m;
       
       for(m=0; m<5000; m++);
}

int main(void)
{
    
    REG_BG0CNT = BG_COLOR256 | TEXTBG_SIZE_256x256 |(31 << SCREEN_SHIFT);
    SetMode(0|OBJ_ENABLE|OBJ_MAP_1D | BG0_ENABLE);

    (obj_aff_buffer[0]).pa = 1<<8;
    (obj_aff_buffer[0]).pd = 1<<8;
    (obj_aff_buffer[0]).pb = 0;
    (obj_aff_buffer[0]).pc = 0;

    int n;
    int m;
    prevX = 0;
    prevY = 0;
    spaceX = 0;
    spaceY = 0;
    movedLeft = 0;
    movedRight = 0;
    movedUp = 0;
    movedDown = 0;
    numSprites = 3;
    numAffSprites = 1;
    affIndex = 1;


    for(n = 1; n < 128; n++)
	{
		sprites[n].y = 160;
		sprites[n].x = 240;
		sprites[n].isRemoved = 1;
	}

    BoundingBox ShipBBox;
	ShipBBox.x = 0;
	ShipBBox.y = 0;
	ShipBBox.xsize = 32;
	ShipBBox.ysize = 32;
    sprites[0].DV_y = Cos_val(angle);
    sprites[0].DV_x = Sin_val(angle);
    sprites[0].x = 103;
    sprites[0].y = 63;
    sprites[0].size = SIZE_32;
    sprites[0].shape = SQUARE;
    sprites[0].aff = 1;
    sprites[0].affIndex = 0;
    sprites[0].location = 0;
    sprites[0].isRemoved = 0;
    sprites[0].hits = 0;
    sprites[0].centerX = 118;
    sprites[0].centerY = 78;
    sprites[0].radius2 = 196;
    sprites[0].angle = 0;
    sprites[0].boundingBox = ShipBBox;
    
    //setEnemies();
    
    
int i;
   /* for(i = 20; i < 24; i++)
    {
    sprites[i].DV_y = Cos_val(angle);
    sprites[i].DV_x = Sin_val(angle);
    sprites[i].x = 0;
    sprites[i].y = 0;
    sprites[i].size = SIZE_32;
    sprites[i].shape = SQUARE;
    sprites[i].fixedPointX = (sprites[i].x)<<12;
    sprites[i].fixedPointY = (sprites[i].y)<<12;
    sprites[i].location = 298;
    sprites[i].isRemoved = 0;
    sprites[i].alive = 1;
    sprites[i].radius2 = 196;
    sprites[i].boundingBox = ShipBBox;

    } */
    
    sprites[100].location = 330;
    sprites[100].size = SIZE_32;
    sprites[100].shape = SQUARE;
    sprites[100].isRemoved = 0;
    //sprites[100].alive = 1;
    sprites[103].location = 362;
    sprites[103].size = SIZE_32;
    sprites[103].shape = SQUARE;
    sprites[103].isRemoved = 0;
    //sprites[103].alive = 1;
    
    /*
    sprites[21].x = 200;
    sprites[21].y = 80;
    sprites[21].mapX = 200;
    sprites[21].mapY = 80;
    sprites[21].fixedPointX = (sprites[21].x)<<12;
    sprites[21].fixedPointY = (sprites[21].y)<<12;
    sprites[22].x = 30;
    sprites[22].y = 80;
    sprites[22].mapX = 30;
    sprites[22].mapY = 80;
    sprites[22].fixedPointX = (sprites[22].x)<<12;
    sprites[22].fixedPointY = (sprites[22].y)<<12;
    sprites[23].mapX = 500;
    sprites[23].mapY = 300;
    sprites[23].x = 240;
    sprites[23].y = 160;



    for(i = 20; i < 24; i++)
    {
        sprites[i].centerX = sprites[i].x + ((sprites[i].boundingBox.xsize)>>1);
        sprites[i].centerY = sprites[i].y + ((sprites[i].boundingBox.ysize)>>1);
    }
    */

   BoundingBox laserBBox;
	laserBBox.x = 0;
	laserBBox.y = 0;
	laserBBox.xsize = 8;
	laserBBox.ysize = 14;
   for(i = 1; i < 20; i++)
   {
       sprites[i].size = SIZE_16;
	   sprites[i].shape = SQUARE;
	   sprites[i].location = 288;
	   sprites[i].boundingBox = laserBBox;
	   sprites[i].noGravity = 1;
	   sprites[i].isProjectile = 1;
	   sprites[i].speed = 2;
	  
   }

    //copy the palette into the background palette memory
    //DMAFastCopy((void*)proj6_Palette, (void*)BGPaletteMem, 256, DMA_16NOW);
    //DMAFastCopy((void*)hitmap_Palette, (void*)BGPaletteMem2, 256, DMA_16NOW);

    //copy the tile images into the tile memory
    //DMAFastCopy((void*)starmapscrn_Tiles, (void*)CharBaseBlock(0), 1984/4, DMA_32NOW);

    //DMAFastCopy((void*)proj6hitmapscrn_Tiles, (void*)CharBaseBlock(2), 128/4, DMA_32NOW);
    //4992 = #Tiles * 64
    //copy the tile map into background 0
    DMAFastCopy((void*)starmap_Palette, (void*)BGPaletteMem,256, DMA_16NOW);

    //copy the tile images into the tile memory
    DMAFastCopy((void*)starmapscrn_Tiles, (void*)CharBaseBlock(0),14592/4, DMA_32NOW);
    //4992 = #Tiles * 64
    //copy the tile map into background 0

    int r;
    int c;
    for( r = 0; r <= 31; r++)
    {
        for( c = 0; c <= 31; c++)
        {
            bg0map[r * 32 + c] = starmapscrn_Map[r * 100 + c];
        }
    }

    for(n = 0; n < 256; n++)
    {
        SpritePal[n] = shipPalette[n];
    }

    for(n = 0; n < 512; n++) /* image location 0 this is no movement */
    {
        SpriteData[n] = shipData[n];
    }
    for( n = 512; n < 1024; n++) /* image location 32 this is move left only */
    {
        SpriteData[n] = shipLeftData[n - 512];
    }
    for( n = 1024; n < 1536; n++) /* image location 64 this is move right only */
    {
        SpriteData[n] = shipRightData[n - 1024];
    }
    for( n = 1536; n < 2048; n++) /* image location 96 this is move up only */
    {
        SpriteData[n] = shipForwardData[n - 1536];
    }
    for( n = 2048; n < 2560; n++) /* image location 128 this is move up and left */
    {
        SpriteData[n] = shipLeftForwardData[n - 2048];
    }
    for( n = 2560; n < 3072; n++) /* image location 160 this is move up and right */
    {
        SpriteData[n] = shipRightForwardData[n - 2560];
    }
    for( n = 3072; n < 3584; n++) /* image location 192 this is move down only */
    {
        SpriteData[n] = shipBackwardData[n - 3072];
    }
    for( n = 3584; n < 4096; n++) /* image location 224 this is down and left */
    {
        SpriteData[n] = shipLeftBackwardData[n - 3584];

    }
    for( n = 4096; n < 4608; n++) /* image location 256 this is down and right */
    {
        SpriteData[n] = shipRightBackwardData[n - 4096];
    }
    for( n = 4608; n < 4736; n++) /* image location 288 this is down and right */
    {
        SpriteData[n] = shipLaserPurpleData[n - 4608];
    }
    for(n = 4736; n < 4768; n++) /* 296 */
    {
        SpriteData[n] = explosion8Data[n - 4736];
    }
    for(n = 4768; n < 5280; n++) /* 298 */
    {
        SpriteData[n] = enemyshipgreenData[n - 4768];
    }
    for(n = 5280; n < 5792; n++) /* 330 */
    {
        SpriteData[n] = enemyShieldData[n - 5280];
    }
    for(n = 5792; n < 6304; n++) /* 362 */
    {
        SpriteData[n] = explosion32Data[n - 5792];
    }



    WaitVBlank();
    UpdateSpriteMemorySpace(sprites, Sprites, obj_aff_buffer);

     
   while(1)
   {

      UpdateSpace();

   }

   return 0;
}


/* END OF FILE */
