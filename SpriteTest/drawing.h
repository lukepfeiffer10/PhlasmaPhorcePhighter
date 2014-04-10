#include <stdlib.h>

void DrawLine3(int x1, int y1, int x2, int y2, unsigned short color)
{
	int i, deltax, deltay, numpixels;
	int d, dinc1, dinc2;
	int x, xinc1, xinc2;
	int y, yinc1, yinc2;
	//calculate deltaX and deltaY
	deltax = abs(x2 - x1);
	deltay = abs(y2 - y1);
	//initialize
	if(deltax >= deltay)
	{
		//If x is independent variable
		numpixels = deltax + 1;
		d = (2 * deltay) - deltax;
		dinc1 = deltay << 1;
		dinc2 = (deltay - deltax) << 1;
		xinc1 = 1;
		xinc2 = 1;
		yinc1 = 0;
		yinc2 = 1;
	}
	else
	{
		//if y is independant variable
		numpixels = deltay + 1;
		d = (2 * deltax) - deltay;
		dinc1 = deltax << 1;
		dinc2 = (deltax - deltay) << 1;
		xinc1 = 0;
		xinc2 = 1;
		yinc1 = 1;
		yinc2 = 1;
	}
	//move the right direction
	if(x1 > x2)
	{
		xinc1 = -xinc1;
		xinc2 = -xinc2;
	}
	if(y1 > y2)
	{
		yinc1 = -yinc1;
		yinc2 = -yinc2;
	}
	x = x1;
	y = y1;
	//draw the pixels
	for(i = 1; i < numpixels; i++)
	{
		DrawPixel3(x, y, color);
		if(d < 0)
		{
		    d = d + dinc1;
		    x = x + xinc1;
		    y = y + yinc1;
		}
		else
		{
		    d = d + dinc2;
		    x = x + xinc2;
		    y = y + yinc2;
		}
	}
}

void DrawCircle3(int xCenter, int yCenter, int radius, unsigned short color)
{
	int x = 0;
	int y = radius;
	int p = 3 - 2 * radius;
	while (x <= y)
	{
		DrawPixel3(xCenter + x, yCenter + y, color);
		DrawPixel3(xCenter - x, yCenter + y, color);
		DrawPixel3(xCenter + x, yCenter - y, color);
		DrawPixel3(xCenter - x, yCenter - y, color);
		DrawPixel3(xCenter + y, yCenter + x, color);
		DrawPixel3(xCenter - y, yCenter + x, color);
		DrawPixel3(xCenter + y, yCenter - x, color);
		DrawPixel3(xCenter - y, yCenter - x, color);
		if (p < 0)
			p += 4 * x++ + 6;
		else
			p += 4 * (x++ - y--) + 10;
	}
}

void DrawFilledCircle3(int xCenter, int yCenter, int radius, unsigned short color)
{
	int x = 0;
	int y = radius;
	int p = 3 - 2 * radius;
	while (x <= y)
	{
		int i;
		for (i = 0; i <= y; i++)
		{
			DrawPixel3(xCenter + x, yCenter + i, color);
			DrawPixel3(xCenter - x, yCenter + i, color);
			DrawPixel3(xCenter + x, yCenter - i, color);
			DrawPixel3(xCenter - x, yCenter - i, color);
			DrawPixel3(xCenter + i, yCenter + x, color);
			DrawPixel3(xCenter - i, yCenter + x, color);
			DrawPixel3(xCenter + i, yCenter - x, color);
			DrawPixel3(xCenter - i, yCenter - x, color);
		}
		
		if (p < 0)
			p += 4 * x++ + 6;
		else
			p += 4 * (x++ - y--) + 10;
	}
}

void DrawBox3(int left, int top, int right, int bottom, unsigned short color)
{
	int x, y;
	for(y = top; y < bottom; y++)
		for(x = left; x < right; x++)
			DrawPixel3(x, y, color);
}

void DrawChar(int left, int top, char letter, unsigned short color)
{
  int x, y;
  int draw;
  for(y = 0; y < 8; y++)
    for (x = 0; x < 8; x++)
    {
      // grab a pixel from the font char
      draw = font[(letter-32) * 64 + y * 8 + x];
      
      // if pixel = 1, then draw it
      if (draw)
        DrawPixel3(left + x, top + y, color);//or other DrawPixel function
    }
}

void Print(int left, int top, char *str, unsigned short color)
{
    int pos = 0;
    while (*str)
    {
        DrawChar(left + pos, top, *str++, color);
        pos += 8;
    }
}



