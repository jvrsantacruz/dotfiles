# Shell, editor and desktop configuration, stowed into $HOME.
#
# The contract every one of my repos exposes:
#   make check   read-only. Does the live state match this repo?
#   make apply   make the live state match this repo.

ENV    ?= $(JVR_ENV)
TARGET ?= $(HOME)

.DEFAULT_GOAL := help
.PHONY: help check apply guard

## help    this list
help:
	@sed -n 's/^## //p' $(firstword $(MAKEFILE_LIST))

guard:
	@test -n "$(ENV)" || { echo "JVR_ENV is unset and no ENV= given"; exit 2; }

## check   dry-run stow: any output is drift between $HOME and this repo
check: guard
	@out=$$(stow -n -v -t $(TARGET) $(ENV) 2>&1 | grep -vE 'simulation mode|^$$' || true); \
	if [ -n "$$out" ]; then echo "$$out"; echo "drift: $(ENV) is not fully stowed"; exit 1; fi; \
	echo "ok: $(TARGET) matches $(ENV)"

## apply   restow the profile. Root-owned etc/ stays manual, by design
apply: guard
	stow -R -v -t $(TARGET) $(ENV)
	@echo "note: $(ENV)/etc/ is not stowed. Install it by hand, see README"
