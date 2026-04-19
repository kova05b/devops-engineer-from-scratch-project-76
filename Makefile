.PHONY: install check prepare

install:
	ansible-galaxy install -r requirements.yml

check:
	ansible-inventory -i inventory.ini --graph
	ansible-playbook -i inventory.ini playbook.yml --syntax-check

prepare:
	ansible-galaxy install -r requirements.yml
	ansible-playbook -i inventory.ini playbook.yml
