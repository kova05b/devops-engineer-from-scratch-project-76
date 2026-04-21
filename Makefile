.PHONY: install check prepare deploy monitor vault-view vault-edit

VAULT_PASSWORD_FILE ?= $(HOME)/.ansible/devops-project-76.vault-pass

install:
	ansible-galaxy install -r requirements.yml

check:
	ansible-inventory -i inventory.ini --graph
	ansible-playbook -i inventory.ini playbook.yml --syntax-check --vault-password-file $(VAULT_PASSWORD_FILE)

prepare:
	ansible-galaxy install -r requirements.yml
	ansible-playbook -i inventory.ini playbook.yml --tags prepare --vault-password-file $(VAULT_PASSWORD_FILE)

deploy:
	ansible-galaxy install -r requirements.yml
	ansible-playbook -i inventory.ini playbook.yml --tags deploy --vault-password-file $(VAULT_PASSWORD_FILE)

monitor:
	ansible-galaxy install -r requirements.yml
	ansible-playbook -i inventory.ini playbook.yml --tags monitoring --vault-password-file $(VAULT_PASSWORD_FILE)

vault-view:
	ansible-vault view group_vars/webservers/vault.yml --vault-password-file $(VAULT_PASSWORD_FILE)

vault-edit:
	ansible-vault edit group_vars/webservers/vault.yml --vault-password-file $(VAULT_PASSWORD_FILE)
