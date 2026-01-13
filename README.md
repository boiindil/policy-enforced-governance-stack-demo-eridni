# Policy-Enforced Governance Stack – DEMO (ERIDNI)

This is an **evaluation-only** demo bundle that demonstrates **fail-closed governance enforcement**
without deploying any real cloud infrastructure.

## What this demo proves
- Mandatory tags are enforced (**owner, purpose, risk**)
- Naming standards are enforced (regex)
- Region allow/deny logic is enforced (fail-closed)
- Policy-as-Code gate works via **OPA/Rego + Conftest** against `terraform show -json`

## What this demo does NOT include (intentionally)
- No immutable audit storage (no Object Lock)
- No CloudTrail
- No Organizations SCP
- No KMS keys
- No budgets
- No production safeguards



## License
Evaluation-only. See `LICENSE_EVALUATION.txt`.
