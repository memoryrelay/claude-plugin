#!/usr/bin/env bash
# Privacy filter for MemoryRelay memory_store operations.
# Receives tool input JSON on stdin. Checks content against blocklist patterns.
# Returns {"decision": "block"} if sensitive content detected, {"decision": "approve"} otherwise.

set -euo pipefail

INPUT=$(cat)

# Extract the content field from tool input JSON
CONTENT=$(echo "$INPUT" | jq -r '.tool_input.content // empty' 2>/dev/null)

if [ -z "$CONTENT" ]; then
  # No content field — nothing to filter, approve
  echo '{"decision": "approve"}'
  exit 0
fi

# Blocklist patterns (extended grep, case-insensitive)
PATTERNS=(
  'password[[:space:]]*[:=][[:space:]]*[^[:space:]]+'
  'credit[[:space:]]*card'
  '[0-9]{3}-[0-9]{2}-[0-9]{4}'
  'social[[:space:]]*security'
  '\b(sk-|mem_prod_|ghp_|gho_|AKIA)[A-Za-z0-9_]+'
  'secret[[:space:]]*[:=][[:space:]]*[^[:space:]]+'
  'token[[:space:]]*[:=][[:space:]]*[^[:space:]]+'
  'BEGIN[[:space:]]+(RSA|DSA|EC|OPENSSH)[[:space:]]+PRIVATE[[:space:]]+KEY'
)

for PATTERN in "${PATTERNS[@]}"; do
  if echo "$CONTENT" | grep -qiE "$PATTERN"; then
    jq -n \
      --arg reason "Content matches privacy blocklist pattern" \
      '{"decision": "block", "reason": $reason}'
    exit 2
  fi
done

echo '{"decision": "approve"}'
exit 0
