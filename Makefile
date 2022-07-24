INC_DIR =./include

SRCS := $(wildcard *.c)
OBJ := $(SRCS:%.c=%.o)

DEVICE = msp430fr4133

CC = msp430-elf-gcc

CFLAGS = -I . -I$(INC_DIR) -mmcu=$(DEVICE) -g -mhwmult=auto
LFLAGS = -L . -L$(INC_DIR)

TARGET = lcd.elf

DRIVER := tilib

# Compilation
all: $(TARGET)

%.o: %.c
	$(CC) $(CFLAGS) $(LFLAGS) -c $^ 

$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) $(LFLAGS) -o $@ $^

# upload to board
install: $(TARGET)
	mspdebug $(DRIVER) "prog $<" --allow-fw-update

clean:
	rm -f *.o *.elf

.PHONY = clean install
