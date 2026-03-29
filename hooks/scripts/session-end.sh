#!/usr/bin/env bash
# Stop hook: close the active MemoryRelay session via direct API call.
# Reads session ID from tracking file written during SessionStart.
# Fails silently if no session is active (idempotent).

set -uo pipefail

TRACKING_DIR="/tmp/memoryrelay-sessions"
TRACKING_FILE="${TRACKING_DIR}/${PPID}"

# Check if session tracking file exists
if [ ! -f "$TRACKING_FILE" ]; then
  # No active session — nothing to close
  exit 0
fi

SESSION_ID=$(cat "$TRACKING_FILE" 2>/dev/null)

if [ -z "$SESSION_ID" ]; then
  rm -f "$TRACKING_FILE"
  exit 0
fi

API_KEY="${MEMORYRELAY_API_KEY:-}"
API_URL="${MEMORYRELAY_API_URL:-https://api.memoryrelay.net}"

if [ -z "$API_KEY" ]; then
  # No API key — can't close session directly, skip
  rm -f "$TRACKING_FILE"
  exit 0
fi

# Close the session via direct API call
curl -sf -X POST \
  "${API_URL}/api/v1/sessions/${SESSION_ID}/end" \
  -H "Authorization: Bearer ${API_KEY}" \
  -H "Content-Type: application/json" \
  -d '{"summary": "Session ended by Claude Code Stop hook"}' \
  --max-time 5 \
  >/dev/null 2>&1 || true

# Clean up tracking file
rm -f "$TRACKING_FILE"

exit 0
