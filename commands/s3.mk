## AWS S3 Commands

# Ensure the standard library was loaded
ifndef STD
include std.mk
endif

# new $S3_BUCKET in $S3_REGION
s3.create: dep.aws env.S3_BUCKET env.S3_REGION
	@aws s3api create-bucket --bucket "$(S3_BUCKET)" --region "$(S3_REGION)" --create-bucket-configuration '{"LocationConstraint":"$(S3_REGION)"}'
	@aws s3api put-bucket-encryption --bucket $(S3_BUCKET) --server-side-encryption-configuration '{"Rules": [{"ApplyServerSideEncryptionByDefault": {"SSEAlgorithm": "AES256"}}]}'

## show $S3_BUCKET
s3.show: dep.aws env.S3_BUCKET
	@aws s3api get-bucket-location --bucket "$(S3_BUCKET)" > /dev/null
	@echo "arn:aws:s3:::$(S3_BUCKET)"
	@aws s3api list-objects-v2 --bucket "$(S3_BUCKET)"

## destroy the $S3_BUCKET
s3.destroy: dep.aws env.S3_BUCKET
	@aws s3 rb "s3://$(S3_BUCKET)" --force > /dev/null

## show $S3_BUCKET in a way that's consumable to Terraform
s3.tfvars: dep.aws env.S3_BUCKET
	@aws s3api get-bucket-location --bucket "$(S3_BUCKET)" > /dev/null
	@echo "arn:aws:s3:::$(S3_BUCKET)"