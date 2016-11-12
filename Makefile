PACKER ?= packer
DOCKER ?= docker

.PHONY: clean
clean:
	$(DOCKER) rmi `$(DOCKER) images -qa`
build:
	$(PACKER) build template.json
.PHONY: validate
validate: 
	$(PACKER) validate template.json
