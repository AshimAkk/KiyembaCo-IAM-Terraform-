# Create IAM users
resource "aws_iam_user" "Kristina" {
  name = "Kristina"
}

resource "aws_iam_user" "Stan" {
  name = "Stan"
}


resource "aws_iam_user" "Morgan" {
  name = "Morgan"
}

resource "aws_iam_user" "Reva" {
  name = "Reva"
}

# Generate secure random passwords
resource "random_password" "secure_password_Kristina" {
  length           = 16
  special          = true
  upper            = true
  lower            = true
  override_special = "!@#$%^&*()-_=+[]{}<>?/\\|~"
}

resource "random_password" "secure_password_Stan" {
  length           = 16
  special          = true
  upper            = true
  lower            = true
  override_special = "!@#$%^&*()-_=+[]{}<>?/\\|~"
}

resource "random_password" "secure_password_Morgan" {
  length           = 16
  special          = true
  upper            = true
  lower            = true
  override_special = "!@#$%^&*()-_=+[]{}<>?/\\|~"
}

resource "random_password" "secure_password_Reva" {
  length           = 16
  special          = true
  upper            = true
  lower            = true
  override_special = "!@#$%^&*()-_=+[]{}<>?/\\|~"
}

# Create login profiles for the users with the generated passwords
resource "aws_iam_user_login_profile" "iam_user_password_Kristina" {
  user                    = aws_iam_user.Kristina.name
  password_reset_required = false


}

resource "aws_iam_user_login_profile" "iam_user_password_Stan" {
  user                    = aws_iam_user.Stan.name
  password_reset_required = false

}

resource "aws_iam_user_login_profile" "iam_user_password_Morgan" {
  user                    = aws_iam_user.Morgan.name
  password_reset_required = false

}

resource "aws_iam_user_login_profile" "iam_user_password_Reva" {
  user                    = aws_iam_user.Reva.name
  password_reset_required = false
}

# Store the generated passwords in AWS Secrets Manager
resource "aws_secretsmanager_secret" "iam_user_password_secret_Kristina" {
  name        = "KristinaIAMUserPassword"
  description = "Password for IAM user Kristina"
  
}

resource "aws_secretsmanager_secret" "iam_user_password_secret_Stan" {
  name        = "StanIAMUserPassword"
  description = "Password for IAM user Stan"
  
}

resource "aws_secretsmanager_secret" "iam_user_password_secret_Morgan" {
  name        = "MorganIAMUserPassword"
  description = "Password for IAM user Morgan"
  
}

resource "aws_secretsmanager_secret" "iam_user_password_secret_Reva" {
  name        = "RevaIAMUserPassword"
  description = "Password for IAM user Reva"
  
}

resource "aws_secretsmanager_secret_version" "iam_user_password_version_Kristina" {
  secret_id = aws_secretsmanager_secret.iam_user_password_secret_Kristina.id
  secret_string = jsonencode({
    username = aws_iam_user.Kristina.name
    password = random_password.secure_password_Kristina.result
  })
}

resource "aws_secretsmanager_secret_version" "iam_user_password_version_Stan" {
  secret_id = aws_secretsmanager_secret.iam_user_password_secret_Stan.id
  secret_string = jsonencode({
    username = aws_iam_user.Stan.name
    password = random_password.secure_password_Stan.result
  })
}

resource "aws_secretsmanager_secret_version" "iam_user_password_version_Morgan" {
  secret_id = aws_secretsmanager_secret.iam_user_password_secret_Morgan.id
  secret_string = jsonencode({
    username = aws_iam_user.Morgan.name
    password = random_password.secure_password_Morgan.result
  })
}

resource "aws_secretsmanager_secret_version" "iam_user_password_version_Reva" {
  secret_id = aws_secretsmanager_secret.iam_user_password_secret_Reva.id
  secret_string = jsonencode({
    username = aws_iam_user.Reva.name
    password = random_password.secure_password_Reva.result
  })
}
# Create an IAM group
resource "aws_iam_group" "Developers_group" {
  name = "Developers"
}

# Attach S3 Full Access policy to the group
resource "aws_iam_group_policy_attachment" "developers_s3_full_access" {
  group      = aws_iam_group.Developers_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

# Attach EC2 Full Access policy to the group
resource "aws_iam_group_policy_attachment" "developers_ec2_full_access" {
  group      = aws_iam_group.Developers_group.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

# Add all users to the Developers group
resource "aws_iam_user_group_membership" "user_in_Developers_group_Kristina" {
  user = aws_iam_user.Kristina.name
  groups = [
    aws_iam_group.Developers_group.name
  ]
}

resource "aws_iam_user_group_membership" "user_in_Developers_group_Stan" {
  user = aws_iam_user.Stan.name
  groups = [
    aws_iam_group.Developers_group.name
  ]
}

resource "aws_iam_user_group_membership" "user_in_Developers_group_Morgan" {
  user = aws_iam_user.Morgan.name
  groups = [
    aws_iam_group.Developers_group.name
  ]
}

resource "aws_iam_user_group_membership" "user_in_Developers_group_Reva" {
  user = aws_iam_user.Reva.name
  groups = [
    aws_iam_group.Developers_group.name
  ]
}
