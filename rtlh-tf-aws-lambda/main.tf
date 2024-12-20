
resource "aws_kms_key" "this" {
  description             = local.description
  enable_key_rotation     = var.enable_key_rotation
  rotation_period_in_days = var.key_rotation_period_in_days
  key_usage               = "ENCRYPT_DECRYPT"

}

data "aws_iam_policy_document" "this" {
  statement {
    sid    = "Enable IAM User Devops Admin Usage"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [sort(data.aws_iam_roles.devops.arns)[0], data.aws_iam_role.cicd.arn]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
  statement {
    sid    = "Enable IAM User Developer Key Usage"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = [sort(data.aws_iam_roles.developer.arns)[0]]
    }
    actions = ["kms:Encrypt",
      "kms:Decrypt",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
    "kms:DescribeKey"]
    resources = ["*"]
    condition {
      test     = "StringEquals"
      variable = "kms:ViaService"
      values   = ["kms.${data.aws_region.this.name}.amazonaws.com"]
    }
  }
  statement {
    sid    = "Allow KMS access to AWS services for backup and restoration"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["backup.amazonaws.com"]
    }
    resources = ["*"]
    actions = [
      "kms:CreateGrant",
      "kms:ListGrants",
      "kms:RevokeGrant"
    ]
    condition {
      test     = "Bool"
      variable = "kms:GrantIsForAWSResource"
      values   = ["true"]
    }
  }
  statement {
    sid    = "Allow Cloud Watch Log Group Access to the Key"
    effect = "Allow"
    principals {
      type        = "Service"
      identifiers = ["logs.${data.aws_region.this.name}.amazonaws.com"]
    }
    actions = [
      "kms:Encrypt*",
      "kms:Decrypt*",
      "kms:ReEncrypt*",
      "kms:GenerateDataKey*",
      "kms:Describe*"
    ]
    resources = ["*"]
    condition {
      test     = "ArnEquals"
      variable = "kms:EncryptionContext:aws:logs:arn"
      values   = ["arn:aws:logs:${data.aws_region.this.name}:${data.aws_caller_identity.current.account_id}:*"]
    }
  }
}

resource "aws_kms_key_policy" "this" {
  key_id = aws_kms_key.this.id
  policy = data.aws_iam_policy_document.this.json
}

resource "aws_kms_alias" "this" {
  target_key_id = aws_kms_key.this.id
  name          = format("alias/%s", local.name)
}
resource "aws_cloudwatch_log_group" "lambda_log_group" {
  count = var.create_aws_lambda_function == true && var.create_aws_cloudwatch_log_group == true ? 1 : 0

  name              = "/aws/lambda/${local.name}"
  retention_in_days = var.retention_in_days
  skip_destroy      = var.skip_destroy
  kms_key_id        = aws_kms_key.this.arn
  tags              = var.tags
}

resource "aws_lambda_function" "lambda" {
  depends_on = [
    aws_cloudwatch_log_group.lambda_log_group
  ]
  count                   = var.create_aws_lambda_function == true ? 1 : 0
  function_name           = local.name
  filename                = var.source_code_location == "local" ? var.filename : null
  s3_bucket               = var.source_code_location == "s3" ? var.s3_bucket : null
  s3_key                  = var.source_code_location == "s3" ? var.s3_key : null
  s3_object_version       = var.source_code_location == "s3" ? var.s3_object_version : null
  description             = var.description
  handler                 = var.package_type != "Image" ? var.handler : null
  runtime                 = var.package_type != "Image" ? var.runtime : null
  timeout                 = var.timeout
  role                    = var.role
  image_uri               = lower(var.source_code_location) == "ecr" ? var.image_uri : null
  kms_key_arn             = aws_kms_key.this.arn
  source_code_hash        = var.source_code_hash
  package_type            = lower(var.source_code_location) == "ecr" ? var.package_type : null
  architectures           = var.architectures
  code_signing_config_arn = var.code_signing_config_arn

  dynamic "vpc_config" {
    for_each = length(var.subnet_ids) == 0 ? [] : [1]
    content {
      subnet_ids         = var.subnet_ids
      security_group_ids = var.security_group_ids
    }
  }


  dynamic "image_config" {
    for_each = length(var.image_config) > 0 && lower(var.source_code_location) == "ecr" ? var.image_config : []
    content {
      entry_point       = lookup(image_config.value, "entry_point", "")
      command           = lookup(image_config.value, "command", "")
      working_directory = lookup(image_config.value, "working_directory", "")
    }
  }
  dynamic "environment" {
    for_each = length(var.lambda_environment) == 0 ? [] : [var.lambda_environment]
    content {
      variables = environment.value.variables
    }
  }

  dynamic "dead_letter_config" {
    for_each = var.dead_letter_target_arn == "" ? [] : [1]
    content {
      target_arn = var.dead_letter_target_arn
    }
  }

  dynamic "tracing_config" {
    for_each = length(var.tracing_config_mode) == 0 ? [] : [1]
    content {
      mode = var.tracing_config_mode
    }
  }

  layers                         = var.package_type != "Image" ? (length(var.layers) == 0 ? null : var.layers) : null
  memory_size                    = var.memory_size
  reserved_concurrent_executions = var.reserved_concurrent_executions
  publish                        = var.publish

  dynamic "file_system_config" {
    for_each = var.file_system_config_arn == "" ? [] : [1]
    content {
      arn              = var.file_system_config_arn
      local_mount_path = var.local_mount_path
    }
  }

  dynamic "ephemeral_storage" {
    for_each = var.ephemeral_storage
    content {
      size = lookup(ephemeral_storage.value, "size", null)
    }
  }

  tags = var.tags

  dynamic "logging_config" {
    for_each = var.logging_config
    content {
      log_format            = lookup(logging_config.value, "log_format", null)
      application_log_level = lookup(logging_config.value, "application_log_level", null)

      log_group        = lookup(logging_config.value, "log_group", null)
      system_log_level = lookup(logging_config.value, "system_log_level", null)
    }
  }


  dynamic "snap_start" {
    for_each = var.snap_start
    content {
      apply_on = lookup(snap_start.value, "apply_on", "")
    }
  }
}

