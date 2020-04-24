// Create new IAM Role with s3, secretsmanager and RDS access
resource "aws_iam_role" "ec2_s3_secretmanager_role" {
  name               = "s3-role"
  assume_role_policy = "${file("assumerolepolicy.json")}"
}

resource "aws_iam_policy" "policy" {
  name        = "testapp_policy"
  description = "testapp policy"
  policy      = "${file("policys3secret.json")}"
}

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  roles      = ["${aws_iam_role.ec2_s3_secretmanager_role.name}"]
  policy_arn = "${aws_iam_policy.policy.arn}"
}

resource "aws_iam_instance_profile" "test_profile" {
  name  = "test_profile"
  role = "${aws_iam_role.ec2_s3_secretmanager_role.name}"
}