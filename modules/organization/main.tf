
resource "aws_organizations_organization" "org" {
  feature_set = "ALL"
}

resource "aws_organizations_organizational_unit" "prod" {
  name = "Production"
  parent_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_organizational_unit" "non_prod" {
  name = "Non-Production"
  parent_id = aws_organizations_organization.org.roots[0].id
}

resource "aws_organizations_account" "new_prod_account" {
  name = "production-workload-01"
  email = "aws-prod-01@yourcompany.com"
  parent_id = aws_organizations_organizational_unit.prod.id
  role_name = "OrganizationAccountAccessRole"
}

resource "aws_organizations_account" "new_non_prod_account" {
  name = "nonproduction-workload-01"
  email = "aws-nonprod-01@yourcompany.com"
  parent_id = aws_organizations_organizational_unit.non_prod.id
  role_name = "OrganizationAccountAccessRole"
}
