CC = rgbasm

LD = rgblink
LDFLAGS =

FIX = rgbfix
FIXFLAGS = -v -p 0

INCDIR = src/
IMGDIR = assets/images

OBJ = src/main.o src/lcd.o src/joypad.o src/memory.o src/menu.o src/game.o 

ROM = gbasm.gb
SYM = gbasm.sym
MAP = gbasm.map

all: $(ROM)
	$(FIX) $(FIXFLAGS) $(ROM)

debug: LDFLAGS += -m $(MAP) -n $(SYM)
debug: all

$(ROM): $(OBJ)
	$(LD) $(LDFLAGS) -o $(ROM) $(OBJ)

%.o: %.asm
	$(CC) -i $(INCDIR) -i $(IMGDIR) -o $@ $^

clean:
	$(RM) $(OBJ) $(SYM) $(MAP) $(ROM)
