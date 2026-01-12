package terraform.governance.naming

name_regex := "^[a-z][a-z0-9-]{2,62}$"

deny[msg] {
  rc := input.resource_changes[_]
  rc.type == "terraform_data"
  after := rc.change.after
  name := after.input.name
  not re_match(name_regex, name)
  msg := sprintf("%s name %q violates naming standard (%s)", [rc.address, name, name_regex])
}
