LIBNAME = libfred
SRCS = $(wildcard *.c)
OBJS = $(SRCS:.c=.o)
DEPS = $(OBJS:.o=.d)

CFLAGS += -std=gnu99 -O2 -Wall -Werror

$(LIBNAME).a: $(OBJS)
	$(AR) rcs $@ $^

# include all dep makefiles generated using the next rule
-include $(DEPS)

# Pattern rule for generating makefiles rules based
# on headers includes dependencies using the C preprocessor
%.d: %.c
	$(CPP) $< -MM -MT $(@:.d=.o) > $@

.PHONY: clean
clean:
	rm -f $(LIBNAME).a $(OBJS) $(DEPS)

