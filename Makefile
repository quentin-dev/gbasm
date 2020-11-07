CC = rgbasm

LD = rgblink

FIX = rgbfix
FIXFLAGS = -v -p 0

INCDIR = src/

OBJ = src/main.o src/utils.o src/joypad.o
ROM = hello-world.gb
SYM = hello-world.sym

all: $(ROM)
	$(FIX) $(FIXFLAGS) $(ROM)

$(ROM): $(OBJ)
	$(LD) -n $(SYM) -o $(ROM) $(OBJ)

%.o: %.asm
	$(CC) -i $(INCDIR) -o $@ $^

clean:
	$(RM) $(OBJ) $(SYM) $(ROM)
