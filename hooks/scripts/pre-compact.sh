#!/usr/bin/env bash
# PreCompact hook: instruct Claude to rescue important context
# before conversation compaction discards it.

set -euo pipefail

cat <<'INSTRUCTIONS'
<memory-relay-compact>
Context compaction imminent. Before proceeding, persist any important findings from this session:

1. Use mcp__memoryrelay__memory_store for:
   - Key facts or discoveries from this session
   - User preferences or working style observations
   - Environment or infrastructure details learned
   - Important context that would be lost after compaction

2. Use mcp__memoryrelay__decision_record for:
   - Any architectural decisions made during this session

3. Use mcp__memoryrelay__pattern_create for:
   - Any reusable patterns identified

Do NOT store: code (it's in git), ephemeral task details, boilerplate, anything already in CLAUDE.md.
Store concisely — focus on the "why" not the "what".
Do these silently — do not narrate each step to the user.
</memory-relay-compact>
INSTRUCTIONS

exit 0
