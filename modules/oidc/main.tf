resource "aws_iam_openid_connect_provider" "github" {
  url = "https://token.actions.githubusercontent.com"
  client_id_list = ["sts.amazonaws.com"]
  thumbprint_list = ["6938fd4d98bab03faadb97b34396831e3780aea1"] # GitHub's CA Thumbprint
}

resource "aws_iam_role" "github_actions_org_admin" {
  name = "GitHubActionsOrgAdmin"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRoleWithWebIdentity"
        Effect = "Allow"
        Principal = {
          Federated = aws_iam_openid_connect_provider.github.arn
        }
        Condition = {
          StringLike = {
            "token.actions.githubusercontent.com:sub": "repo:GlueOps/tofu-aws-org-foundation:*"
          }
        }
      }
    ]
  })
}

# Attach AdministratorAccess (or specific Org permissions)
resource "aws_iam_role_policy_attachment" "admin" {
  role = aws_iam_role.github_actions_org_admin.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
