## Terraform Commands

# Ensure the standard library was loaded
ifndef STD
include std.mk
endif

# optionally override
TERRAFORM_DIR ?= terraform
TERRAFORM_TFVARS := $(shell find ${TERRAFORM_DIR} -type f -name '*.tfvars')
TERRAFORM_VAR_FILES := $(patsubst %,--var-file=\"%\",$(TERRAFORM_TFVARS))

# Make the terraform directory if we haven't already
${TERRAFORM_DIR}/:
	@ mkdir -p "$@"

## Runs `terraform init` in your project. Don't call directly.
## % represents the environment (e.g. dev) you want to pass in.
## Use within your Makefile (e.g. deploy: terraform.init.PRO)
##
terraform.init.%: dep.terraform ${TERRAFORM_DIR} uenv.%_AWS_ACCESS_KEY_ID uenv.%_AWS_SECRET_ACCESS_KEY uenv.%_AWS_REGION
	@ cd ${TERRAFORM_DIR} && \
		terraform init \
			-upgrade
			-backend-config='access_key="${*}_AWS_ACCESS_KEY_ID"' \
			-backend-config='secret_key="${*}_AWS_SECRET_ACCESS_KEY"' \
			-backend-config='region="${*}_AWS_REGION"'
.PHONY: terraform.init terraform.init. terraform.init.%

## Runs `terraform plan` in your project. Don't call directly.
## % represents the environment (e.g. dev) you want to pass in.
## Use within your Makefile (e.g. deploy: terraform.init.PRO)
##
terraform.plan.%: dep.terraform ${TERRAFORM_DIR} uenv.%_AWS_ACCESS_KEY_ID uenv.%_AWS_SECRET_ACCESS_KEY uenv.%_AWS_REGION
	@ cd ${TERRAFORM_DIR} && \
		AWS_ACCESS_KEY_ID="${*}_AWS_ACCESS_KEY_ID" \
		AWS_SECRET_ACCESS_KEY="${*}_AWS_SECRET_KEY)" \
		AWS_REGION="${*}_AWS_REGION" \
		terraform plan ${TERRAFORM_VAR_FILES}
.PHONY: terraform.plan terraform.plan. terraform.plan.%

## Runs `terraform apply` in your project. Don't call directly.
## % represents the environment (e.g. dev) you want to pass in.
## Use within your Makefile (e.g. deploy: terraform.init.PRO)
##
terraform.apply.%: dep.terraform ${TERRAFORM_DIR} uenv.%_AWS_ACCESS_KEY_ID uenv.%_AWS_SECRET_ACCESS_KEY uenv.%_AWS_REGION
	@ cd ${TERRAFORM_DIR} && \
		AWS_ACCESS_KEY_ID="${*}_AWS_ACCESS_KEY_ID" \
		AWS_SECRET_ACCESS_KEY="${*}_AWS_SECRET_KEY)" \
		AWS_REGION="${*}_AWS_REGION" \
		terraform apply $(TERRAFORM_VAR_FILES)
.PHONY: terraform.apply terraform.apply. terraform.apply.%

## Runs `terraform output` in your project for your infra's outputs.
## % represents the environment (e.g. dev) you want to pass in.
## Use within your Makefile (e.g. deploy: terraform.init.PRO)
terraform.output.%: dep.terraform ${TERRAFORM_DIR} uenv.%_AWS_ACCESS_KEY_ID uenv.%_AWS_SECRET_ACCESS_KEY uenv.%_AWS_REGION
	@ cd ${TERRAFORM_DIR} && \
		AWS_ACCESS_KEY_ID="${*}_AWS_ACCESS_KEY_ID" \
		AWS_SECRET_ACCESS_KEY="${*}_AWS_SECRET_KEY)" \
		AWS_REGION="${*}_AWS_REGION" \
		terraform output
.PHONY: terraform.output terraform.output. terraform.output.%

# make.terraform:
# 	@ $(EDITOR) /Users/m/Code/src/github.com/matthewmueller/make