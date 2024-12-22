PYTHON := python
VENV_NAME := .venv
OUT_DIR := img

MATPLOTLIB_CACHE_FILE := fontlist*
F39_FONTS_DIR := $(HOME)/.local/share/fonts

help: ## show this help
	@awk -f makefile-doc.awk $(MAKEFILE_LIST) 2> /dev/null || \
	echo "Running this target requires makefile-doc.awk (https://github.com/drdv/makefile-doc)"

setup-venv: ## setup venv
	@${PYTHON} -m venv ${VENV_NAME} && \
	. ${VENV_NAME}/bin/activate && \
	pip install --upgrade pip && \
	pip install -r .requirements.txt

## generate a test plot
test-plot: setup-venv
	@. ${VENV_NAME}/bin/activate && python test_plot.py
	@xdg-open $(OUT_DIR)/test_plot.png

## clean generated plots and python venv
clean:
	@rm -rf $(OUT_DIR)
	@rm -rf $(VENV_NAME)

##@
##@ ----- WARNING: fedora 39 related targets -----
##@

##! install fonts
f39-install-fonts: f39-clean-matplotlib-cache
	@mkdir -p $(F39_FONTS_DIR)
	@cp -r $(PWD)/fonts/* $(F39_FONTS_DIR);
	@fc-cache -v;
	@fc-list | grep --color=always xkcd;

##! delete matplotlib's cache
f39-clean-matplotlib-cache:
	$(eval PLT_DIR=$(shell python -c "import matplotlib; print(matplotlib.get_cachedir())"))
	@echo "Delete matplotlib's cache $(PLT_DIR)/$(MATPLOTLIB_CACHE_FILE)? [y/n]"
	@cd $(PLT_DIR) && tree
	@read answer && [ $$answer = y ] && rm -f $(PLT_DIR)/$(MATPLOTLIB_CACHE_FILE) || \
	echo "Operation cancelled"
