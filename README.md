# tofu-aws-org-foundation

## The "Bootstrap" Workflow
1. Local Run: Run `tofu init` and `tofu apply` with the `backend "s3"` block commented out. This creates the S3 bucket, DynamoDB table, and OIDC roles using your local credentials.
2. Migrate: Uncomment the `backend "s3"` block.
3. Re-init: Run `tofu init` again. OpenTofu will ask: "Do you want to copy existing state to a new backend?" Type `yes`.
4. GitHub Actions: Now your GitHub Actions (via OIDC) can take over and manage new account creation and SCP updates.
