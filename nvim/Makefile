fd = $(wildcard $1$2) $(foreach d,$(wildcard $1*),$(call fd,$d/,$2))
fnl-files = $(call fd,./,*.fnl)
fnl-files := $(filter-out ./soupmacs/% %macros.fnl,$(fnl-files))
gen-lua-files = $(patsubst %.fnl,%.lua,$(fnl-files))

all: $(gen-lua-files)

clean:
	rm -fr $(gen-lua-files)

%.lua: %.fnl
	@mkdir -p $(dir $@)
	fennel -c $< > $@

.PHONY: all clean
