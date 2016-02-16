TEMPORARY_FOLDER?=/tmp/Pancake.dst
PREFIX?=/usr/local
BUILD_TOOL?=xcodebuild

XCODEFLAGS=-workspace 'Pancake.xcworkspace' -scheme 'pancake' DSTROOT=$(TEMPORARY_FOLDER)

OUTPUT_PACKAGE=Pancake.pkg
OUTPUT_FRAMEWORK=PancakeKit.framework

BUILT_BUNDLE=$(TEMPORARY_FOLDER)/Applications/pancake.app
PANCAKEKIT_BUNDLE=$(BUILT_BUNDLE)/Contents/Frameworks/$(OUTPUT_FRAMEWORK)
PANCAKE_EXECUTABLE=$(BUILT_BUNDLE)/Contents/MacOS/pancake

FRAMEWORKS_FOLDER=/Library/Frameworks
BINARIES_FOLDER=/usr/local/bin

VERSION_STRING=$(shell agvtool what-marketing-version -terse1)
COMPONENTS_PLIST=Sources/pancake/components.plist

.PHONY: all bootstrap clean install package test uninstall

all: bootstrap
	$(BUILD_TOOL) $(XCODEFLAGS) build

bootstrap:
	scripts/bootstrap

test: clean bootstrap
	$(BUILD_TOOL) $(XCODEFLAGS) test

clean:
	rm -f "$(OUTPUT_PACKAGE)"
	rm -rf "$(TEMPORARY_FOLDER)"
	$(BUILD_TOOL) $(XCODEFLAGS) clean

install: package
	sudo installer -pkg Pancake.pkg -target /

uninstall:
	rm -rf "$(FRAMEWORKS_FOLDER)/$(OUTPUT_FRAMEWORK)"
	rm -f "$(BINARIES_FOLDER)/pancake"

installables: clean bootstrap
	$(BUILD_TOOL) $(XCODEFLAGS) install

	mkdir -p "$(TEMPORARY_FOLDER)$(FRAMEWORKS_FOLDER)" "$(TEMPORARY_FOLDER)$(BINARIES_FOLDER)"
	mv -f "$(PANCAKEKIT_BUNDLE)" "$(TEMPORARY_FOLDER)$(FRAMEWORKS_FOLDER)/$(OUTPUT_FRAMEWORK)"
	mv -f "$(PANCAKE_EXECUTABLE)" "$(TEMPORARY_FOLDER)$(BINARIES_FOLDER)/pancake"
	rm -rf "$(BUILT_BUNDLE)"

prefix_install: installables
	mkdir -p "$(PREFIX)/Frameworks" "$(PREFIX)/bin"
	cp -Rf "$(TEMPORARY_FOLDER)$(FRAMEWORKS_FOLDER)/$(OUTPUT_FRAMEWORK)" "$(PREFIX)/Frameworks/"
	cp -f "$(TEMPORARY_FOLDER)$(BINARIES_FOLDER)/pancake" "$(PREFIX)/bin/"
	install_name_tool -add_rpath "@executable_path/../Frameworks/$(OUTPUT_FRAMEWORK)/Versions/Current/Frameworks/" "$(PREFIX)/bin/pancake"

package: installables
	pkgbuild \
		--component-plist "$(COMPONENTS_PLIST)" \
		--identifier "jp.martha.pancake" \
		--install-location "/" \
		--root "$(TEMPORARY_FOLDER)" \
		--version "$(VERSION_STRING)" \
		"$(OUTPUT_PACKAGE)"