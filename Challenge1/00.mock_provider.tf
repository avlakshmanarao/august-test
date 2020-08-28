provider "aws" {
  access_key                  = "mock_access_key"
  region                      = "us-east-1"
  s3_force_path_style         = true
  secret_key                  = "mock_secret_key"
  skip_credentials_validation = true
  skip_metadata_api_check     = true
  skip_requesting_account_id  = true
  version                     = "2.68.0"

  endpoints {
    apigateway     = "http://localhost:4567"
    cloudformation = "http://localhost:4581"
    cloudwatch     = "http://localhost:4582"
    dynamodb       = "http://localhost:4569"
    es             = "http://localhost:4578"
    iam            = "http://localhost:4593"
    kinesis        = "http://localhost:4568"
    lambda         = "http://localhost:4574"
    r53            = "http://localhost:4580"
    s3             = "http://localhost:4572"
    sns            = "http://localhost:4575"
    sqs            = "http://localhost:4576"
    ssm            = "http://localhost:4583"
    sts            = "http://localhost:4592"
    firehose       = "http://localhost:4573"
    redshift       = "http://localhost:4577"
    secretsmanager = "http://localhost:4584"
    ses            = "http://localhost:4579"
    stepfunctions  = "http://localhost:4585"
  }
}