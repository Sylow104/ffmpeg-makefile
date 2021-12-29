all	:
	@$(MAKE) prepare;
	@$(MAKE) encode;

prepare	: encoded
	@prename 's/ /_/g' *.mkv

encoded	:
	@mkdir --verbose $@;

I_FILES := $(wildcard *.mkv)
O_FILES := $(foreach in_file, $(I_FILES), encoded/$(in_file) )

encode : $(O_FILES) 

encoded/%.mkv	: %.mkv
	ffmpeg -i "$<" $(PARAM) -y -map 0 -c:s copy -c:a libopus -c:v \
		libx265 "$@";
