#!/usr/bin/env sh
set -eu

EXAMPLE_DIR="${1:-examples/pass}"

cd "$(dirname "$0")/.."

echo "[eridni-demo] init"
terraform -chdir="$EXAMPLE_DIR" init -input=false >/dev/null

echo "[eridni-demo] plan"
terraform -chdir="$EXAMPLE_DIR" plan -out=tfplan -input=false >/dev/null
terraform -chdir="$EXAMPLE_DIR" show -json tfplan > "$EXAMPLE_DIR/plan.json"

echo "[eridni-demo] conftest"
conftest test "$EXAMPLE_DIR/plan.json" -p policy/opa --all-namespaces --output table
