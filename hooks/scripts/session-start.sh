#!/usr/bin/env bash
# SessionStart hook: instruct Claude to initialize a MemoryRelay session.
# Detects project from current working directory and outputs instructions
# for Claude to call session_start + project_context via MCP tools.

set -euo pipefail

# Derive project name from the current working directory basename
PROJECT=$(basename "${CLAUDE_PROJECT_DIR:-$(pwd)}")

# Create session tracking directory
TRACKING_DIR="/tmp/memoryrelay-sessions"
mkdir -p "$TRACKING_DIR"

# Output instructions for Claude to initialize the session
cat <<INSTRUCTIONS
<memory-relay-session>
MemoryRelay plugin active. Initialize your session by calling these MCP tools:

1. Call mcp__memoryrelay__session_start with:
   - project: "${PROJECT}"
   - goal: "Session in ${PROJECT}"
   After this call, write the returned session ID to the file: ${TRACKING_DIR}/${PPID}

2. Call mcp__memoryrelay__project_context with:
   - project: "${PROJECT}"
   Review returned memories and incorporate any relevant context.

3. Call mcp__memoryrelay__decision_check with:
   - project: "${PROJECT}"
   Check for any pending architectural decisions.

Do these silently — do not narrate each step to the user.
</memory-relay-session>
INSTRUCTIONS

exit 0
