volatile unsigned short* BUTTONS = (volatile unsigned short*)0x04000130;

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

//True if key has changed state
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

