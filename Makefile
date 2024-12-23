PYTHON := python
VENV_NAME := .venv
OUT_DIR := out

MATPLOTLIB_CACHE_FILE := fontlist*
FEDORA_FONTS_DIR := $(HOME)/.local/share/fonts

help: ## show this help
	@test -f .external/makefile-doc.awk || \
	wget --quiet -P .external github.com/drdv/makefile-doc/releases/latest/download/makefile-doc.awk
	@awk -f .external/makefile-doc.awk $(MAKEFILE_LIST)

## generate a test plot
test-plot: setup-venv
	@. ${VENV_NAME}/bin/activate && python test_plot.py
	@xdg-open $(OUT_DIR)/test_plot.png

setup-venv: ## setup venv
	@${PYTHON} -m venv ${VENV_NAME} && \
	. ${VENV_NAME}/bin/activate && \
	pip install --upgrade pip && \
	pip install -r .requirements.txt

## remove all generated stuff
clean:
	@rm -rf $(OUT_DIR)
	@rm -rf $(VENV_NAME)
	@rm -rf .external


##@
##@ ----- fedora related targets -----
##@

##! install fonts
fedora-install-fonts: fedora-clean-matplotlib-cache
	@mkdir -p $(FEDORA_FONTS_DIR)
	@cp -r $(PWD)/fonts/* $(FEDORA_FONTS_DIR);
	@fc-cache -v;
	@fc-list | grep --color=always xkcd;

##! delete matplotlib's cache
fedora-clean-matplotlib-cache:
	$(eval PLT_DIR=$(shell python -c "import matplotlib; print(matplotlib.get_cachedir())"))
	@echo "Delete matplotlib's cache $(PLT_DIR)/$(MATPLOTLIB_CACHE_FILE)? [y/n]"
	@cd $(PLT_DIR) && tree
	@read answer && [ $$answer = y ] && rm -f $(PLT_DIR)/$(MATPLOTLIB_CACHE_FILE) || \
	echo "Operation cancelled"
