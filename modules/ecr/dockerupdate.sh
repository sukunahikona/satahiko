# ecs task & clsuter update shell

# set ecr name
ECR_NAME=izanami-ecr

# get account id
ACCOUNT_ID=`aws sts get-caller-identity --query 'Account' --output text`;

aws ecr get-login-password --region ap-northeast-1 | docker login --username AWS --password-stdin $ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com
docker build -t $ECR_NAME .
docker tag $ECR_NAME:latest $ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com/$ECR_NAME:latest
docker push $ACCOUNT_ID.dkr.ecr.ap-northeast-1.amazonaws.com/$ECR_NAME:latest

# update task definition
aws ecs register-task-definition --task-role-arn arn:aws:iam::$ACCOUNT_ID:role/ecs_deploy_role --execution-role-arn arn:aws:iam::$ACCOUNT_ID:role/ecs_deploy_role --requires-compatibilities FARGATE --cpu 256 --memory 512 --network-mode awsvpc --family izanami-ecs-def --cli-input-json "$(aws ecs describe-task-definition --task-definition izanami-ecs-def | jq '.taskDefinition | { containerDefinitions: .containerDefinitions }')"

# update ecs
aws ecs update-service --cluster izanami-ecs --service izanami-ecs-service --task-definition izanami-ecs-def
