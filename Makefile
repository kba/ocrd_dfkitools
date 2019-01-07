exec_name_prefix = ocrd-anybaseocr
testdir = tests

# BEGIN-EVAL makefile-parser --make-help Makefile

help:
	@echo ""
	@echo "  Targets"
	@echo ""
	@echo "    repo/assets    Clone OCR-D/assets to ./repo/assets"
	@echo "    assets-clean   Remove assets"
	@echo "    assets         Setup test assets"
	@echo "    test-binarize  Test binarization"
	@echo "    test-deskew    Test deskewing"
	@echo ""
	@echo "  Variables"
	@echo ""

# END-EVAL

#
# Assets
#

# Clone OCR-D/assets to ./repo/assets
repo/assets:
	mkdir -p $(dir $@)
	git clone https://github.com/OCR-D/assets "$@"

# Remove assets
assets-clean:
	rm -rf $(testdir)/assets

# Setup test assets
assets: repo/assets
	mkdir -p $(testdir)/assets
	cp -r -t $(testdir)/assets repo/assets/data/*

#
# Tests
#

# Run all tests
test: test-binarize test-deskew

# Test binarization
test-binarize: assets-clean assets
	cd $(testdir)/assets/dfki-testdata/data && $(exec_name_prefix)-binarize -m mets.xml -I OCR-D-IMG -O OCR-D-IMG-BIN-TEST

# Test deskewing
test-deskew: assets-clean assets
	cd $(testdir)/assets/dfki-testdata/data && $(exec_name_prefix)-deskew -m mets.xml -I OCR-D-IMG -O OCR-D-IMG-DESKEW-TEST