---
name: memory-session-recall
description: Recall memories from a specific MemoryRelay session
---

Recall all memories stored during a specific session.

**Usage:** `/memory-session-recall <session-id> [--limit N]`

**Arguments from user:** $ARGUMENTS

1. Parse the session ID (first argument, required)
2. Parse optional `--limit` (default: 20)
3. Call `mcp__memoryrelay__session_recall` with the session ID and limit
4. Display memories as a numbered list with content, importance, and creation time
5. If no session ID provided, first call `mcp__memoryrelay__session_list` to show available sessions
