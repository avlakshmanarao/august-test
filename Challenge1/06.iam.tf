
resource "aws_iam_role_policy_attachment" "iam-policy" {
  policy_arn = aws_iam_policy.ecs_perm_policy.arn
  role   = aws_iam_role.ecs_role.name
}

resource "aws_iam_role" "ecs_role" {
	name = "${var.project}EcsRole"

	assume_role_policy = <<EOF
	{
	  "Version": "2012-10-17",
	  "Statement": [
		{
		  "Sid": "",
		  "Effect": "Allow",
		  "Principal": {
			"Service": ["ec2.amazonaws.com", "ecs.amazonaws.com", "ecs-tasks.amazonaws.com"]
		  },
		  "Action": "sts:AssumeRole"
		}
	  ]
	}
	EOF

}

resource "aws_iam_policy" "ecs_perm_policy" {
  name   = "${var.project}EcsPermissionsPolicy"
  policy = data.aws_iam_policy_document.svc-perm.json
}


data "aws_iam_policy_document" "svc-perm" {
  statement {
    effect = "Allow"
    actions = [
				"ec2:DescribeTags",
				"ecs:CreateCluster",
				"ecs:DeregisterContainerInstance",
				"ecs:DiscoverPollEndpoint",
				"ecs:Poll",
				"ecs:RegisterContainerInstance",
				"ecs:StartTelemetrySession",
				"ecs:UpdateContainerInstancesState",
				"ecs:Submit*",
				"ecr:GetAuthorizationToken",
				"ecr:BatchCheckLayerAvailability",
				"ecr:GetDownloadUrlForLayer",
				"ecr:BatchGetImage",
				"ecr:PutImage",
				"ecr:InitiateLayerUpload",
				"ecr:UploadLayerPart",
				"ecr:CompleteLayerUpload",
				"ecr:CreateRepository",
				"logs:CreateLogStream",
				"logs:PutLogEvents",
				"ec2:AuthorizeSecurityGroupIngress",
				"ec2:Describe*",
				"elasticloadbalancing:DeregisterInstancesFromLoadBalancer",
				"elasticloadbalancing:DeregisterTargets",
				"elasticloadbalancing:Describe*",
				"elasticloadbalancing:RegisterInstancesWithLoadBalancer",
				"elasticloadbalancing:RegisterTargets",
				"secretsmanager:GetSecretValue",
				"iam:CreateRole"
			  ]
    resources = [ "*" ]
    
  }
 } 
  