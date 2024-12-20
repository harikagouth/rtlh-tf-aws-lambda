<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >=1.9 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >=5.23.1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >=5.23.1 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_cloudwatch_log_group.lambda_log_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group) | resource |
| [aws_lambda_function.lambda](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lambda_function) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_architectures"></a> [architectures](#input\_architectures) | (Optional) "Default : ["x86\_64"] ". Instruction set architecture for your Lambda function. Valid values are ["x86\_64"] and ["arm64"].  Removing this attribute, function's architecture stay the same. | `any` | <pre>[<br>  "x86_64"<br>]</pre> | no |
| <a name="input_code_signing_config_arn"></a> [code\_signing\_config\_arn](#input\_code\_signing\_config\_arn) | (Optional) "Default : null". To enable code signing for this function, specify the ARN of a code-signing configuration. A code-signing configuration includes a set of signing profiles, which define the trusted publishers for this function. | `string` | `null` | no |
| <a name="input_context"></a> [context](#input\_context) | (Optional) The context that the resource is deployed in. e.g. devops, logs, lake | `string` | `"01"` | no |
| <a name="input_create_aws_cloudwatch_log_group"></a> [create\_aws\_cloudwatch\_log\_group](#input\_create\_aws\_cloudwatch\_log\_group) | (Optional) "Default : true". Controls if Cloudwatch Log Group should be created | `bool` | `true` | no |
| <a name="input_create_aws_lambda_function"></a> [create\_aws\_lambda\_function](#input\_create\_aws\_lambda\_function) | (Optional) "Default : true". Controls if Lambda shoulbd be created | `bool` | `true` | no |
| <a name="input_dead_letter_target_arn"></a> [dead\_letter\_target\_arn](#input\_dead\_letter\_target\_arn) | (Optional) "Default : "" ". The ARN of an SNS topic or SQS queue to notify when an invocation fails. If this option is used, the function's IAM role must be granted suitable access to write to the target object, which means allowing either the sns:Publish or sqs:SendMessage action on this ARN, depending on which service is targeted. | `string` | `""` | no |
| <a name="input_description"></a> [description](#input\_description) | (Optional) "Default : " " ". Description of what your Lambda Function does. | `string` | `""` | no |
| <a name="input_ephemeral_storage"></a> [ephemeral\_storage](#input\_ephemeral\_storage) | (Optional) "Default : []". The size of the Lambda function Ephemeral storage(/tmp) represented in MB. The minimum supported ephemeral\_storage value defaults to 512MB and the maximum supported value is 10240MB. | `any` | `[]` | no |
| <a name="input_file_system_config_arn"></a> [file\_system\_config\_arn](#input\_file\_system\_config\_arn) | (Optional) "Default : " " ". The Amazon Resource Name (ARN) of the Amazon EFS Access Point that provides access to the file system. | `string` | `""` | no |
| <a name="input_filename"></a> [filename](#input\_filename) | (Optional) Default : "" ". Required when "source\_code\_location" is "local" and need to provide valid value for the attribute .The path to the function's deployment package within the local filesystem. If defined, The s3\_-prefixed options cannot be used. | `string` | `""` | no |
| <a name="input_function_name"></a> [function\_name](#input\_function\_name) | (Required) A unique name for your Lambda Function. | `string` | n/a | yes |
| <a name="input_handler"></a> [handler](#input\_handler) | (Required) The function entrypoint in your code. | `string` | n/a | yes |
| <a name="input_image_config"></a> [image\_config](#input\_image\_config) | (Optional) "Default : []". Configuration block. | `any` | `[]` | no |
| <a name="input_image_uri"></a> [image\_uri](#input\_image\_uri) | (Optional) "Default : null". ECR image URI containing the function's deployment package. Conflicts with filename, s3\_bucket, s3\_key, and s3\_object\_version. | `any` | `null` | no |
| <a name="input_kms_key_arn"></a> [kms\_key\_arn](#input\_kms\_key\_arn) | (Required) Amazon Resource Name (ARN) of customer managed CMK should be used for encryption. | `string` | n/a | yes |
| <a name="input_lambda_environment"></a> [lambda\_environment](#input\_lambda\_environment) | (Optional) "Default : {}". The Lambda environment's configuration settings. | `map(any)` | `{}` | no |
| <a name="input_lambda_logs_kms_key_id"></a> [lambda\_logs\_kms\_key\_id](#input\_lambda\_logs\_kms\_key\_id) | (Optional) "Default : 90". The ARN of the KMS Key to use when encrypting log data. Please note, after the AWS KMS CMK is disassociated from the log group, AWS CloudWatch Logs stops encrypting newly ingested data for the log group. All previously ingested data remains encrypted, and AWS CloudWatch Logs requires permissions for the CMK whenever the encrypted data is requested. | `string` | n/a | yes |
| <a name="input_layers"></a> [layers](#input\_layers) | (Optional) "Default : []". List of Lambda Layer Version ARNs (maximum of 5) to attach to your Lambda Function. | `list(any)` | `[]` | no |
| <a name="input_local_mount_path"></a> [local\_mount\_path](#input\_local\_mount\_path) | (Optional) "Default : " " ". The path where the function can access the file system, starting with /mnt/. | `string` | `""` | no |
| <a name="input_logging_config"></a> [logging\_config](#input\_logging\_config) | (Optional) "Default : {}".Configuration block used to specify advanced logging settings | `any` | `{}` | no |
| <a name="input_memory_size"></a> [memory\_size](#input\_memory\_size) | (Optional) "Default : "128" ". Amount of memory in MB your Lambda Function can use at runtime. Defaults to 128. | `string` | `"128"` | no |
| <a name="input_package_type"></a> [package\_type](#input\_package\_type) | (Optional) "Default : null". Lambda deployment package type. Valid values are Zip and Image. | `string` | `null` | no |
| <a name="input_publish"></a> [publish](#input\_publish) | (Optional) "Default : false". Whether to publish creation/change as new Lambda Function Version. Defaults to false. | `string` | `"false"` | no |
| <a name="input_reserved_concurrent_executions"></a> [reserved\_concurrent\_executions](#input\_reserved\_concurrent\_executions) | (Optional) "Default : "-1" ". The amount of reserved concurrent executions for this lambda function. A value of 0 disables lambda from being triggered and -1 removes any concurrency limitations. Defaults to Unreserved Concurrency Limits -1. | `string` | `"-1"` | no |
| <a name="input_retention_in_days"></a> [retention\_in\_days](#input\_retention\_in\_days) | (Optional) "Default : 90". Specifies the number of days you want to retain log events in the specified log group. Possible values are: 1, 3, 5, 7, 14, 30, 60, 90, 120, 150, 180, 365, 400, 545, 731, 1096, 1827, 2192, 2557, 2922, 3288, 3653, and 0. If you select 0, the events in the log group are always retained and never expire. | `number` | `90` | no |
| <a name="input_role"></a> [role](#input\_role) | (Required) IAM role attached to the Lambda Function. This governs both who / what can invoke your Lambda Function, as well as what resources our Lambda Function has access to. | `string` | n/a | yes |
| <a name="input_runtime"></a> [runtime](#input\_runtime) | (Optional) "Default : "nodejs20.x" " . Valid runtimes: nodejs10.x \| nodejs12.x \| java8 \| java11 \| python2.7 \| python3.6 \| python3.7 \| python3.8 \| dotnetcore2.1 \| dotnetcore3.1 \| go1.x \| ruby2.5 \| ruby2.7 \| valid values can check [here](https://docs.aws.amazon.com/lambda/latest/dg/API_CreateFunction.html#SSS-CreateFunction-request-Runtime | `string` | `"nodejs20.x"` | no |
| <a name="input_s3_bucket"></a> [s3\_bucket](#input\_s3\_bucket) | (Optional) "Default : "" ". The S3 bucket location containing the function's deployment package. | `string` | `""` | no |
| <a name="input_s3_key"></a> [s3\_key](#input\_s3\_key) | (Optional) "Default : "" ". The S3 key of an object containing the function's deployment package. | `string` | `""` | no |
| <a name="input_s3_object_version"></a> [s3\_object\_version](#input\_s3\_object\_version) | (Optional) "Default : "" ". The object version containing the function's deployment package. | `string` | `""` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | (Optional) "Default : []". A list of security group IDs associated with the Lambda function. | `list(any)` | `[]` | no |
| <a name="input_skip_destroy"></a> [skip\_destroy](#input\_skip\_destroy) | (Optional) "Default : false". Set to true if you do not wish the log group (and any logs it may contain) to be deleted at destroy time, and instead just remove the log group from the Terraform state. | `bool` | `false` | no |
| <a name="input_snap_start"></a> [snap\_start](#input\_snap\_start) | (Optional) "Default : {}".This feature is currently only supported for java11, java17 and java21 runtimes. Snap start settings block | `any` | `{}` | no |
| <a name="input_source_code_hash"></a> [source\_code\_hash](#input\_source\_code\_hash) | (Optional) Default : null. Required when "source\_code\_location" is "s3" and need to provide valid value for the attribute .Used to trigger updates. Must be set to a base64-encoded SHA256 hash of the package file specified with either filename or s3\_key. The usual way to set this is filebase64sha256("file.zip") (Terraform 0.11.12 and later) or base64sha256(file("file.zip")) (Terraform 0.11.11 and earlier), where "file.zip" is the local filename of the lambda function source archive. | `string` | `null` | no |
| <a name="input_source_code_location"></a> [source\_code\_location](#input\_source\_code\_location) | (Optional) "Default : "s3" ". The location of source code. It can be either s3 or local or ecr. | `string` | `"s3"` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | (Optional) "Default : []". A list of subnet IDs associated with the Lambda function. | `list(any)` | `[]` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) A mapping of tags to assign to the bucket. | `map(string)` | `{}` | no |
| <a name="input_timeout"></a> [timeout](#input\_timeout) | (Optional) "Default : "15" ". The amount of time your Lambda Function has to run in seconds. Max: 900 (15 min) | `string` | `"15"` | no |
| <a name="input_tracing_config_mode"></a> [tracing\_config\_mode](#input\_tracing\_config\_mode) | (Optional) "Default : "" ". Can be either PassThrough or Active. If PassThrough, Lambda will only trace the request from an upstream service if it contains a tracing header with sampled=1. If Active, Lambda will respect any tracing header it receives from an upstream service. If no tracing header is received, Lambda will call X-Ray for a tracing decision. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_function_arn"></a> [function\_arn](#output\_function\_arn) | The Amazon Resource Name (ARN) identifying your Lambda Function. |
| <a name="output_invoke_arn"></a> [invoke\_arn](#output\_invoke\_arn) | The ARN to be used for invoking Lambda Function from API Gateway - to be used in aws\_api\_gateway\_integration's uri |
| <a name="output_kms_key_arn"></a> [kms\_key\_arn](#output\_kms\_key\_arn) | The ARN for the KMS encryption key. |
| <a name="output_last_modified"></a> [last\_modified](#output\_last\_modified) | The date this resource was last modified. |
| <a name="output_log_group_arn"></a> [log\_group\_arn](#output\_log\_group\_arn) | The Amazon Resource Name (ARN) specifying the lambda log group. |
| <a name="output_qualified_arn"></a> [qualified\_arn](#output\_qualified\_arn) | The Amazon Resource Name (ARN) identifying your Lambda Function Version. |
| <a name="output_source_code_hash"></a> [source\_code\_hash](#output\_source\_code\_hash) | Base64-encoded representation of raw SHA-256 sum of the zip file, provided either via filename or s3\_* parameters. |
| <a name="output_source_code_size"></a> [source\_code\_size](#output\_source\_code\_size) | The size in bytes of the function .zip file. |
| <a name="output_version"></a> [version](#output\_version) | Latest published version of your Lambda Function. |
<!-- END_TF_DOCS -->