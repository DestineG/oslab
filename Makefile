BOOT_SRC = src/boot/boot.asm
BOOT_BIN = build/boot.bin
BOOT_LST = build/boot.lst
DISK_IMG = image/os.img

all: $(DISK_IMG)

$(BOOT_BIN): $(BOOT_SRC)
	mkdir -p build
	nasm -f bin $(BOOT_SRC) -o $(BOOT_BIN) -l $(BOOT_LST)

$(DISK_IMG): $(BOOT_BIN)
	mkdir -p image
	dd if=/dev/zero of=$(DISK_IMG) bs=1M count=64
	dd if=$(BOOT_BIN) of=$(DISK_IMG) bs=512 count=1 conv=notrunc

run: all
	powershell.exe -Command '& "D:\Program Files\Bochs-3.1\bochs.exe" -f "D:\Projects\oslab\config\bochsrc.bxrc" -q'

clean:
	rm -f build/*
	rm -f image/*