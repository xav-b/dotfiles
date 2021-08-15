# Makefile
# vim:ft=make

TAGS ?= all

.PHONY: all
all: suitup

.PHONY: check
check:
	ansible all -m ping -i hosts

facts:
	@ansible all -m setup -i hosts

.PHONY: suitup
suitup:
	# provision your local machine
	ansible-playbook -i hosts site.yml --ask-become-pass --tags $(TAGS)

doc:
	cp readme.md ./docs/README.md
	docsify serve ./docs
