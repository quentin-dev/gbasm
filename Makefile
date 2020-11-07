CC = rgbasm

LD = rgblink

FIX = rgbfix
FIXFLAGS = -v -p 0

OBJ = main.o
ROM = hello-world.gb

all: $(ROM)
	$(FIX) $(FIXFLAGS) $(ROM)

$(ROM): $(OBJ)
	$(LD) -o $(ROM) $(OBJ)

%.o: %.asm
	$(CC) -o $@ $^

clean:
	$(RM) $(OBJ) $(ROM)
