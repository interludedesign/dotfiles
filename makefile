# https://www.gnu.org/savannah-checkouts/gnu/make/manual/html_node/Phony-Targets.html
# If we `make personal`, make will assume the operational has already been run, since there
# is a directory already called personal. PHONY tells make that this is a phone task
.PHONY: personal work delete

all:
	@echo "Vaid Tasks:\nmake personal\nmake work"

personal:
	./stow-personal

work:
	./stow-work

delete:
	stow --verbose --delete */
