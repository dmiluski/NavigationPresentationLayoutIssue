# Build Tools
BREW=/usr/local/bin/brew

# One Step Setup (This should be first Step)

.PHONY: init
init: prerequisites
	make install

# Dependency Management

# Install Dependencies
.PHONY: install
install:
	./carthage.sh bootstrap --platform ios --use-ssh --cache-builds --use-netrc

# Update Carthage Copy-Frameworks List
.PHONY: carting
carting:
	carting update -f file

# Prerequisites

$(BREW):
	/usr/bin/ruby -e "$$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install Build Tools, Dependencies, and Git Hooks
.PHONY: prerequisites
prerequisites: $(BREW)
	brew bundle
