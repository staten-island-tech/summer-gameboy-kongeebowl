CC = lcc
ROM = test
OBJS = test.c smirk.c
GBDK_DIR = /usr/share/gbdk-2020

CFLAGS += -I$(GBDK_DIR)/include

$(ROM).gb: $(OBJS)
	$(CC) $(CFLAGS) -o $(ROM).gb $(OBJS)
