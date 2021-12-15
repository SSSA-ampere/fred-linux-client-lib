LIBNAME = libfred
FRED_PATH ?= /opt/fredsys/
SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)
DEPS = $(OBJS:.o=.d)

CFLAGS += -std=gnu99 -O2 -Wall -Werror -DFRED_PATH=${FRED_PATH}

$(LIBNAME).a: $(OBJS)
	$(AR) rcs $@ $^

# include all dep makefiles generated using the next rule
-include $(DEPS)

# Pattern rule for generating makefiles rules based
# on headers includes dependencies using the C preprocessor
# %.d: %.c
# 	$(CPP) $< -MM -MT -DFRED_PATH=${FRED_PATH} $(@:.d=.o) > $@

.PHONY: clean
clean:
	rm -f $(LIBNAME).a $(OBJS) $(DEPS)

install:
	mkdir -p ${FRED_PATH}/include ${FRED_PATH}/lib 
	cp fred_lib.h ${FRED_PATH}/include
	cp libfred.a ${FRED_PATH}/lib 