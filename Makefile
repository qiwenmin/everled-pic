.PHONY: all clean

TARGET=everled.hex
OBJ=$(TARGET:.hex=.o)
SRC=$(TARGET:.hex=.asm)
COD=$(TARGET:.hex=.cod)
LST=$(TARGET:.hex=.lst)

all: $(TARGET)

$(TARGET): $(OBJ)
	gplink -f 1 -o $@ $^

$(OBJ): $(SRC)
	gpasm -c -o $@ $<

clean:
	rm -f $(TARGET) $(OBJ) $(COD) $(LST)
