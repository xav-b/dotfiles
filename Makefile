# Makefile
# vim:ft=make

TAGS ?= all

.PHONY: all
all: install

.PHONY: check
check:
	ansible all -m ping -i hosts

.PHONY: install
install: deps
	# provision your local machine
	ansible-playbook -i hosts site.yml --ask-sudo-pass --tags $(TAGS)

doc:
	cp readme.md ./docs/index.md
	mkdocs build --clean

# Assuming :
# 	python 2.7.10
# 	pip 6.1.1
.PHONY: install
deps:
	pip install -r requirements.txt
