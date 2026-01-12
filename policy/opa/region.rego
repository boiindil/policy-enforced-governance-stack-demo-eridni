package terraform.governance.region

deny[msg] {
  rc := input.resource_changes[_]
  rc.type == "terraform_data"
  after := rc.change.after
  region := after.input.region
  region == "" 
  msg := sprintf("%s region is empty (fail-closed)", [rc.address])
}
