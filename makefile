.DEFAULT_GOAL := debug

.PHONY: debug
debug:
	@$(MAKE) compile \
		BUILD_TYPE=Debug \
		--no-print-directory

.PHONY: release
release:
	@$(MAKE) compile \
		BUILD_TYPE=Release \
		--no-print-directory

.PHONY: compile
compile:
	mkdir -p ${BUILD_TYPE}; \
	cd ${BUILD_TYPE}; \
	cmake \
		-DCMAKE_BUILD_TYPE=${BUILD_TYPE} \
		..; \
	make

.PHONY: liblift
liblift:
	cd lib/liblifthttp; \
	mkdir Release; \
	cd Release; \
	cmake -DCMAKE_BUILD_TYPE=Release ..; \
	cmake --build .

.PHONY: clean
clean:
	rm -rf Debug; \
	rm -rf Release; \
	rm -rf bin/LibGeminiProject

.PHONY: clean-lib
clean:
	rm -rf lib/liblifthttp/Debug; \
	rm -rf lib/liblifthttp/Release