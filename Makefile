
.PHONY: all
all: doc
	( . ../venv/ansible/bin/activate && ansible-playbook site.yml )

.PHONY: ping
ping:
	( . ../venv/ansible/bin/activate && ansible all -m ping )

.PHONY: role-init
role-init:
	mkdir -p roles
	( . ../venv/ansible/bin/activate && ansible-galaxy install YasuhiroABE.myfavorite-setting )

.PHONY: clean
clean:
	find . -name '*~' -exec rm {} \; -print

.PHONY: doc
doc:
	mmark README.md > README.html
