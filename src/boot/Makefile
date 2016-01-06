LDFLAGS		:= --oformat binary -m elf_i386 -Ttext=0x0

TARGETS		:= $(BOOTSECT) $(SETUP) 
OBJS		:= bootsect.o setup.o
	
$(SETUP):	setup.o
	$(LD) $^ $(LDFLAGS) -o $@
setup.o:	setup.s \
				../include/common/config.inc \
				../include/lib16/vesa.inc

$(BOOTSECT):	bootsect.o
	$(LD) $^ $(LDFLAGS) -o $@	
bootsect.o:		bootsect.s \
					../include/common/config.inc

clean:
	-rm -f $(OBJS) $(TARGETS)
	
