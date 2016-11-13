PACKER ?= packer
DOCKER ?= docker
TERRAFORM ?= terraform
.PHONY: clean
clean:
	@echo: ==> Will Remove everything from your system relateted to this build
	$(DOCKER) rmi scboucher/packer-ansible-demo
	
build:
	$(PACKER) build template.json
.PHONY: validate
validate: 
	$(PACKER) validate template.json
	$(TERRAFORM) validate
deploy:
	$(TERRAFORM) apply
