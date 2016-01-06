DebugOption	= -g
CCFLAGS		= -Wall $(DebugOption)

$(TOOL):	fmerge.c helper.c
	$(CC) $^ $(CCFLAGS) -o $@

clean:
	-rm -f $(TOOL)
