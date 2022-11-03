fd = $(wildcard $1$2) $(foreach d, $(wildcard $1*), $(call fd, $d/, $2))
fnl-files = $(call fd, fnl/, *.fnl)
fnl-files := $(filter-out %macros.fnl, $(fnl-files))
lua-files = $(patsubst fnl/%.fnl, lua/%.lua, $(fnl-files))

all: $(lua-files)

clean: lua
	rm -fr $^

lua/%.lua: fnl/%.fnl
	@mkdir -p $(dir $@)
	fennel -c $< > $@

.PHONY: all clean
