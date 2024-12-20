# tests/test_vars.tfvars

cost_code              = "P-1101088.02.10"
requestor              = "Gibson Scott IST"
approver               = "Shea Andrew IST"
sub_domain             = "DataIntegration"
application            = "Lakehouse"
owner                  = "Shea Andrew IST"
environment            = "sbx"
iam_name               = "tests"
iam_assume_role_policy = "policy_documents/assume_role_policy.json"
iam_policy_names       = ["test-policy-ec2", "test-policy-s3"]
iam_role_policies      = ["policy_documents/policy_ec2_test.json", "policy_documents/policy_s3_test.json"]