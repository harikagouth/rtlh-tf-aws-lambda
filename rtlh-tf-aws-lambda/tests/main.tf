module "lambda" {

  source = ".//.."


  #Required Parameters
  #function_name = "test-lambda" #A unique name for your Lambda Function.
  handler     = "lambda_function.lambda_handler"
  description = "This is a test lambda function"
  #s3_key = var.s3_key
  #s3_object_version = var.s3_object_version
  #s3_bucket =  var.s3_bucket                                                                                           #The function entrypoint in your code.
  role = module.iam_role_policy_example.iam_role_arn #IAM role attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to.

  #Optional parameters
  create_aws_lambda_function = true         #Controls if Lambda shoulbd be created
  source_code_location       = "local"      #The location of source code. It can be either s3 or local or ecr.
  filename                   = "./test.zip" #Required when "source_code_location" is "local" and need to provide valid value for the attribute .The path to the function's deployment package within the local filesystem. If defined, The s3_-prefixed options cannot be used.
  # ephemeral_storage = [{
  #   size = 512
  # }] # The size of the Lambda function Ephemeral storage(/tmp) represented in MB. The minimum supported ephemeral_storage value defaults to 512MB and the maximum supported value is 10240MB.
  # lambda_environment = {
  #   variables = {
  #     "test"  = "test"
  #     "test1" = "test1"
  #   }
  # } #The Lambda environment's configuration settings.

}

module "iam_role_policy_example" {
  source = "github.com/rio-tinto/rtlh-tf-aws-iam?ref=v1.1.1"

  iam_name               = "example-role-name"
  iam_assume_role_policy = file("${path.module}/policy_documents/assume_role_policy.json")

  iam_policy_names = ["example-policy-lambda", "example-policy-s3"]

  iam_role_policies = [
    file("${path.module}/policy_documents/policy_lambda_example.json"),
    file("${path.module}/policy_documents/policy_s3_example.json")
  ]

  create_iam_role   = true # Set to false if you don't want to create the role
  create_iam_policy = true # Set to false if you don't want to create the policies
}