output "demo_stack_id" {
  value = "${var.name_prefix}-${var.environment}"
}

output "demo_region" {
  value = var.region
}

output "demo_tags" {
  value = merge(var.mandatory_tags, { env = var.environment, stack = "${var.name_prefix}-${var.environment}" })
}
