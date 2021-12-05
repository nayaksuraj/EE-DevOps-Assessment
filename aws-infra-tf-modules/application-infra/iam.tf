resource "aws_iam_role" "app_node_access_role" {
  name = "ApplicationNodeIAMRole"
  path = "/"

  assume_role_policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Action": "sts:AssumeRole",
            "Effect": "Allow",
            "Principal": {
               "Service": "ec2.amazonaws.com"
            }
        }
    ]
}
EOF

}

resource "aws_iam_policy" "app_node_access_policy" {
  name        = "ApplicationNodeIAMPolicy"
  description = "Policy to access AWS Resources"
  path        = "/"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "s3:*"
            ],
            "Resource": [
                "*"
            ]
        }
    ]
}
EOF

}

resource "aws_iam_role_policy_attachment" "policy_role_attach" {
  policy_arn = aws_iam_policy.app_node_access_policy.arn
  role       = aws_iam_role.app_node_access_role.name
}

resource "aws_iam_role_policy_attachment" "application_node_ssm_policy" {
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2RoleforSSM"
  role       = aws_iam_role.app_node_access_role.name
}


resource "aws_iam_instance_profile" "application_node_profile" {
  name = "ApplicationNodeAccessProfile"
  role = aws_iam_role.app_node_access_role.name
}