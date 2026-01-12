package terraform.governance.tags

required := {"owner", "purpose", "risk"}

deny[msg] {
  rc := input.resource_changes[_]
  rc.type == "terraform_data"
  after := rc.change.after
  inputobj := after.input

  # fail-closed: tags must exist
  not inputobj.tags
  msg := sprintf("%s is missing tags object (fail-closed)", [rc.address])
}

deny[msg] {
  rc := input.resource_changes[_]
  rc.type == "terraform_data"
  after := rc.change.after
  tags := after.input.tags

  missing := required - {k | tags[k]}
  count(missing) > 0
  msg := sprintf("%s is missing mandatory tags: %v", [rc.address, missing])
}

deny[msg] {
  rc := input.resource_changes[_]
  rc.type == "terraform_data"
  after := rc.change.after
  tags := after.input.tags

  risk := lower(tags.risk)
  not risk_in_allowed(risk)
  msg := sprintf("%s has invalid risk tag: %q (allowed: low|medium|high|critical)", [rc.address, tags.risk])
}

risk_in_allowed(r) { r == "low" }
risk_in_allowed(r) { r == "medium" }
risk_in_allowed(r) { r == "high" }
risk_in_allowed(r) { r == "critical" }
