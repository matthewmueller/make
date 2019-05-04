## AWS IAM Commands

# Ensure the standard library was loaded
ifndef STD
include std.mk
endif

# Default IAM Policy for an IAM user
IAM_POLICY ?= arn:aws:iam::aws:policy/AdministratorAccess

## create an IAM user called $IAM_USER
iam.create: dep.aws dep.jq env.IAM_USER env.IAM_POLICY
	@ aws iam create-user --user-name "$(IAM_USER)" | jq -r '"user_name = \""+.User.UserName+"\"", "user_id = \""+.User.UserId+"\"", "user_arn = \""+.User.Arn+"\""'
	@ aws iam attach-user-policy --user-name "$(IAM_USER)" --policy-arn "$(IAM_POLICY)"
	@ aws iam create-access-key --user-name "$(IAM_USER)" | jq -r '"export AWS_ACCESS_KEY_ID=\""+.AccessKey.AccessKeyId+"\"", "export AWS_SECRET_ACCESS_KEY=\""+.AccessKey.SecretAccessKey+"\""'

## show the $IAM_USER user
iam.show: dep.aws dep.jq env.IAM_USER
	@ aws iam get-user --user-name "$(IAM_USER)" | jq -r '"user_name = \""+.User.UserName+"\"", "user_id = \""+.User.UserId+"\"", "user_arn = \""+.User.Arn+"\""'
	@ aws iam list-access-keys --user-name "$(IAM_USER)" | jq -r '"access_key_id = \""+.AccessKeyMetadata[].AccessKeyId+"\""'
	@ aws iam list-attached-user-policies --user-name "$(IAM_USER)" | jq -r '"policy_name = \""+.AttachedPolicies[].PolicyName+"\"", "policy_arn = \""+.AttachedPolicies[].PolicyArn+"\""'

## destroy the $IAM_USER
iam.destroy: dep.aws dep.jq env.IAM_USER env.IAM_ACCESS_KEY_ID env.IAM_POLICY
	@ aws iam delete-access-key --user-name "$(IAM_USER)" --access-key-id "$(env.IAM_ACCESS_KEY_ID)"
	@ aws iam detach-user-policy --user-name "$(IAM_USER)" --policy-arn "$(IAM_POLICY)"
	@ aws iam delete-user --user-name "$(IAM_USER)"
