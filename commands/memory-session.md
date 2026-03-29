---
name: memory-session
description: Manage MemoryRelay sessions — start, end, or list
---

Manage MemoryRelay sessions.

**Usage:** `/memory-session [start|end|list] [--project P] [--goal G]`

**Arguments from user:** $ARGUMENTS

**Subcommands:**

- **No args / `list`**: Call `mcp__memoryrelay__session_list` and display active and recent sessions in a table (ID, Project, Started, Status)
- **`start`**: Call `mcp__memoryrelay__session_start` with `--project` (default: current directory name) and `--goal` (default: "Manual session"). Report the new session ID.
- **`end`**: Call `mcp__memoryrelay__session_end` for the current active session. Include a summary if provided after `end`.
