variable "name_prefix" {
  description = "Prefix for demo resources. Lowercase, digits, hyphen; must start with a letter."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{2,20}$", var.name_prefix))
    error_message = "name_prefix must match ^[a-z][a-z0-9-]{2,20}$ (3-21 chars)."
  }
}

variable "environment" {
  description = "Environment identifier (dev|stage|prod|lab|regulated)."
  type        = string
  nullable    = false

  validation {
    condition     = can(regex("^(dev|stage|prod|lab|regulated)$", var.environment))
    error_message = "environment must be one of: dev, stage, prod, lab, regulated."
  }
}

variable "mandatory_tags" {
  description = "Mandatory tags enforced by policy: owner, purpose, risk."
  type        = map(string)
  nullable    = false

  validation {
    condition = (
      contains(keys(var.mandatory_tags), "owner") &&
      contains(keys(var.mandatory_tags), "purpose") &&
      contains(keys(var.mandatory_tags), "risk") &&
      trimspace(var.mandatory_tags["owner"])   != "" &&
      trimspace(var.mandatory_tags["purpose"]) != "" &&
      contains(["low","medium","high","critical"], lower(trimspace(var.mandatory_tags["risk"])))
    )
    error_message = "mandatory_tags must include non-empty owner, purpose, and risk (low|medium|high|critical)."
  }
}

variable "allowed_regions" {
  description = "Allow-list of regions. Fail-closed: must be non-empty."
  type        = list(string)
  nullable    = false

  validation {
    condition     = length(var.allowed_regions) > 0
    error_message = "allowed_regions must be a non-empty list."
  }
}

variable "region" {
  description = "Demo region value to validate against allow/deny lists."
  type        = string
  nullable    = false
}

variable "deny_regions" {
  description = "Explicit deny-list (optional)."
  type        = list(string)
  default     = []
}

