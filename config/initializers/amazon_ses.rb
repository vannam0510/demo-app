require "aws-sdk"

ses_client_configs = {
  region: Settings.aws.ses.region,
  raise_response_errors: true
}

AMAZON_SES = Aws::SES::Client.new ses_client_configs
