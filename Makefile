# Makefile
# vim:ft=make

TAGS ?= all

.PHONY: all
all: install

.PHONY: check
check:
	ansible all -m ping -i hosts

facts:
	@ansible all -m setup -i hosts

.PHONY: install
install:
	# provision your local machine
	ansible-playbook -i hosts site.yml --ask-sudo-pass --tags $(TAGS)

doc:
	cp readme.md ./docs/index.md
	mkdocs build --clean
