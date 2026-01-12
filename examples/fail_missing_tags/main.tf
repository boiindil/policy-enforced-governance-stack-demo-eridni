terraform {
  required_version = ">= 1.5.0"
}

module "demo" {
  source = "../../"

  name_prefix  = "acme"
  environment  = "prod"
  region       = "eu-central-1"
  allowed_regions = ["eu-central-1", "eu-west-1"]

  # missing 'risk' tag -> OPA deny
  mandatory_tags = {
    owner   = "security@acme.tld"
    purpose = "demo"
  }
}
