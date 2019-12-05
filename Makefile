dub_dir := $(HOME)/.dub/packages
dpp_version := 0.4.0
dpp_pkg_dir := $(dub_dir)/dpp-$(dpp_version)
dpp_lock := $(dpp_pkg_dir)/dpp.lock
dpp_dir := $(dpp_pkg_dir)/dpp
dpp := $(dpp_dir)/bin/d++
autowrap_version := 0.5.1
autowrap_dir := $(dub_dir)/autowrap-$(autowrap_version)/autowrap
autowrap_pynih_dir := $(autowrap_dir)/pynih
autowrap_pynih_raw_dpp := $(autowrap_pynih_dir)/source/python/raw.dpp
autowrap_pynih_raw_d := $(autowrap_pynih_dir)/source/python/raw.d
PYTHON_INCLUDE_DIR := $(shell python -c 'from distutils.sysconfig import get_python_inc; print(get_python_inc())')

.PHONY: test libpython-dpp-nanomsg.so nanomsg.so
all: test

test: nanomsg.so
	PYTHONPATH=$(PWD) pytest -s -vv

nanomsg.so: libpython-dpp-nanomsg.so
	cp $< $@

libpython-dpp-nanomsg.so: source/nanomsg.d $(autowrap_pynih_raw_d)
	dub build -q

source/nanomsg.d: source/nanomsg.dpp $(dpp)
	$(dpp) --preprocess-only --include-path $(PYTHON_INCLUDE_DIR) source/nanomsg.dpp

$(dpp): $(dpp_lock) $(autowrap_pynih_raw)
	cd $(dpp_dir) && dub build -q

$(dpp_lock):
	dub fetch dpp --version=$(dpp_version)

$(autowrap_pynih_raw_d): $(autowrap_pynih_raw_dpp)
	make -C $(autowrap_pynih_dir) source/python/raw.d

$(autowrap_pynih_raw_dpp):
	dub fetch autowrap --version=$(autowrap_version)
