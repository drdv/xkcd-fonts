PYTHON := python
VENV_NAME := .venv
OUT_DIR := img

MATPLOTLIB_CACHE_FILE := fontlist*
FEDORA_FONTS_DIR := $(HOME)/.local/share/fonts

help: ## show this help
	@awk -f makefile-doc.awk $(MAKEFILE_LIST) 2> /dev/null || \
	echo "Running this target requires makefile-doc.awk (https://github.com/drdv/makefile-doc)"

## generate a test plot
test-plot: setup-venv
	@. ${VENV_NAME}/bin/activate && python test_plot.py
	@xdg-open $(OUT_DIR)/test_plot.png

setup-venv: ## setup venv
	@${PYTHON} -m venv ${VENV_NAME} && \
	. ${VENV_NAME}/bin/activate && \
	pip install --upgrade pip && \
	pip install -r .requirements.txt

## clean generated plots and python venv
clean:
	@rm -rf $(OUT_DIR)
	@rm -rf $(VENV_NAME)

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
