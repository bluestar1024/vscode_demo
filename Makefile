ALL_INC_DIR += . inc
ALL_SRC_DIR += . src
ALL_OBJ_DIR += debug/obj
EXE_DIR += debug/exe
EXE_NAME += mytest
ALL_LIB_DIR += lib/squ lib/cb
ALL_LIB_NAME += lsqu lcb

CC = gcc
CFLAGS := -Wall -g
IFLAGS := $(foreach n,$(ALL_INC_DIR),-I$(n))
LFLAGS := $(foreach n,$(ALL_LIB_DIR),-L$(n)) $(foreach n,$(ALL_LIB_NAME),-l$(n)) -static

empty =
space = $(empty) $(empty)
VPATH := $(subst $(space),:,$(ALL_SRC_DIR)):$(ALL_OBJ_DIR):$(EXE_DIR)
vpath %.c $(subst $(space),:,$(ALL_SRC_DIR))
vpath %.o $(ALL_OBJ_DIR)
vpath % $(EXE_DIR)

SRCS_WITH_PATH := $(foreach n,$(ALL_SRC_DIR),$(wildcard $(n)/*.c))
SRCS := $(notdir $(SRCS_WITH_PATH))
OBJS_WITH_PATH := $(patsubst %.c,$(ALL_OBJ_DIR)/%.o,$(SRCS))
OBJS := $(notdir $(OBJS_WITH_PATH))
EXE_WITH_PATH := $(EXE_DIR)/$(EXE_NAME)
EXE := $(EXE_NAME)

.PHONY:all clean

all:$(EXE)
	@echo VPATH = $(VPATH)
	@echo SRCS = $(SRCS)
	@echo SRCS_WITH_PATH = $(SRCS_WITH_PATH)
	@echo OBJS = $(OBJS)
	@echo OBJS_WITH_PATH = $(OBJS_WITH_PATH)
	@echo EXE = $(EXE)
	@echo EXE_WITH_PATH = $(EXE_WITH_PATH)
	@echo CFLAGS = $(CFLAGS)
	@echo IFLAGS = $(IFLAGS)
	@echo LFLAGS = $(LFLAGS)

$(EXE):$(OBJS)
#	$(CC) $(CFLAGS) -o $(EXE_DIR)/$@ $(OBJS_WITH_PATH) $(LFLAGS) #OK
#	$(CC) $(CFLAGS) -o $(EXE_DIR)/$@ $(LFLAGS) $(OBJS_WITH_PATH) #ERROR
#	$(CC) $(CFLAGS) $(OBJS_WITH_PATH) -o $(EXE_DIR)/$@ $(LFLAGS) #OK
#	$(CC) $(CFLAGS) $(OBJS_WITH_PATH) $(LFLAGS) -o $(EXE_DIR)/$@ #OK
#	$(CC) $(CFLAGS) $(LFLAGS) -o $(EXE_DIR)/$@ $(OBJS_WITH_PATH) #ERROR
#	$(CC) $(CFLAGS) $(LFLAGS) $(OBJS_WITH_PATH) -o $(EXE_DIR)/$@ #ERROR
	$(CC) $(CFLAGS) -o $(EXE_DIR)/$@ $(OBJS_WITH_PATH) $(LFLAGS)
%.o:%.c
	$(CC) $(CFLAGS) -c -o $(ALL_OBJ_DIR)/$@ $^ $(IFLAGS)

clean:
	rm $(shell pwd)/$(ALL_OBJ_DIR)/*.o
	rm $(shell pwd)/$(EXE_DIR)/*
