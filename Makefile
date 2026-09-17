BOOT_SRC = src/boot/boot.asm
BOOT_BIN = build/boot.bin
BOOT_LST = build/boot.lst
BOOT_IMG = image/boot.img

all: $(BOOT_IMG)

$(BOOT_BIN): $(BOOT_SRC)
	mkdir -p build
	nasm -f bin $(BOOT_SRC) -o $(BOOT_BIN) -l $(BOOT_LST)

$(BOOT_IMG): $(BOOT_BIN)
	mkdir -p image
	dd if=/dev/zero of=$(BOOT_IMG) bs=512 count=2880
	dd if=$(BOOT_BIN) of=$(BOOT_IMG) conv=notrunc

run: all
	powershell.exe -Command '& "D:\Program Files\Bochs-3.1\bochs.exe" -f "D:\Projects\oslab\config\bochsrc.bxrc" -q'

clean:
	rm -f build/*
	rm -f image/*