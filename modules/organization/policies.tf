resource "aws_organizations_policy" "prevent_leave" {
  name        = "PreventLeaveOrganization"
  description = "Prevents member accounts from leaving the organization"
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Deny"
        Action   = ["organizations:LeaveOrganization"]
        Resource = "*"
      }
    ]
  })
}

resource "aws_organizations_policy_attachment" "root_attachment" {
  policy_id = aws_organizations_policy.prevent_leave.id
  target_id = aws_organizations_organization.org.roots[0].id
}
