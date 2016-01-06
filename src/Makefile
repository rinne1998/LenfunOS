export AS			:= as
export LD			:= ld
export ASFLAGS		:= --32
export LDFLAGS		:= --oformat elf32-i386 -m elf_i386
export CC			:= gcc
export CCFLAGS		:= -ffreestanding -nostdinc

export TOOL			:= fmerge
export IMAGE		:= Image
export KERNEL16		:= kernel16
export LIB16		:= lib16
export SETUP		:= setup
export BOOTSECT		:= bootsect

.s.o:
	$(AS) $< $(ASFLAGS) -o $@
	
$(IMAGE):	boot/$(BOOTSECT) boot/$(SETUP) tool/$(TOOL)
	dd if=/dev/zero of=$(IMAGE) bs=1440K count=1
	dd if=boot/$(BOOTSECT) of=$(IMAGE) bs=512 count=1 conv=notrunc
	dd if=boot/$(SETUP) of=$(IMAGE) seek=1 bs=512 count=1 conv=notrunc

tool/$(TOOL):
	$(MAKE) $(TOOL) -C tool

boot/$(SETUP):
	$(MAKE) $(SETUP) -C boot
	
boot/$(BOOTSECT):
	$(MAKE) $(BOOTSECT) -C boot

clean:
	$(MAKE) clean -C boot
	$(MAKE) clean -C tool
	-rm -f $(IMAGE)