.PHONY: help init plan apply deploy destroy
.DEFAULT_GOAL := help

VAR_FILE := "./tfvars/dev.tfvar"
VAR_STATE_PATH := "nginix-infra"
VAR_ENV := "dev"
DEPLOY := destroy

init:
	make clean
	cd terraform && \
	terraform init -backend-config "prefix=terraform/${VAR_STATE_PATH}/state-${VAR_ENV}" -migrate-state &&  \
	terraform validate && \
	terraform fmt

plan:
	cd terraform && \
	terraform plan -var-file=$(VAR_FILE) -out="plan.out"

deploy:
ifeq  ($(DEPLOY), deploy)
	make apply
else ifeq ($(DEPLOY), destroy)
	make deploy VAR_FILE=$(VAR_FILE)
endif

apply:
	cd terraform && \
	test -f plan.out || { echo "No plan file found. Please run 'make plan' first."; exit 1; }  && \
	terraform apply plan.out

destroy:
	cd terraform  && \
	terraform destroy -var-file=$(VAR_FILE) -auto-approve

clean:
	cd terraform  && \
	rm -f plan.out

# show usage and tasks (default)
help: 
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)