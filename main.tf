locals {
  stack_id = "${var.name_prefix}-${var.environment}"
  tags     = merge(var.mandatory_tags, { env = var.environment, stack = local.stack_id })
}

# Demo-only resource change that carries fields for policy evaluation (no cloud calls).
resource "terraform_data" "governance_demo" {
  input = {
    name   = local.stack_id
    region = var.region
    tags   = local.tags
  }

  lifecycle {
    precondition {
      condition     = contains(var.allowed_regions, var.region)
      error_message = "Region guardrail violation: region must be in allowed_regions."
    }
    precondition {
      condition     = !contains(var.deny_regions, var.region)
      error_message = "Region guardrail violation: region is explicitly denied."
    }
  }
}
