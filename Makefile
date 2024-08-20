.PHONY: all clean

TARGET=everled.hex
SRC=$(TARGET:.hex=.asm)
COD=$(TARGET:.hex=.cod)
LST=$(TARGET:.hex=.lst)

all: $(TARGET)

$(TARGET): $(SRC)
	gpasm $^

clean:
	rm -f $(TARGET) $(COD) $(LST)
