PACKER ?= packer
DOCKER ?= docker

.PHONY: clean
clean:
	$(DOCKER) rmi scboucher/packer-ansible-demo
build:
	$(PACKER) build template.json
.PHONY: validate
validate: 
	$(PACKER) validate template.json
