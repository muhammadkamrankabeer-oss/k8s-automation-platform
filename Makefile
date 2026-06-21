VAGRANT_DIR=./vagrant

up:
	cd $(VAGRANT_DIR) && vagrant up

halt:
	cd $(VAGRANT_DIR) && vagrant halt

destroy:
	cd $(VAGRANT_DIR) && vagrant destroy -f

status:
	cd $(VAGRANT_DIR) && vagrant status

deploy:
	ansible-playbook ansible/playbooks/site.yml

nodes:
	kubectl get nodes -o wide
