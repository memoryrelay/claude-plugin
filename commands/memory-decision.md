---
name: memory-decision
description: Record, list, or check architectural decisions in MemoryRelay
---

Manage architectural decisions tracked in MemoryRelay.

**Usage:** `/memory-decision [record|list|check] [--project P] [--topic T]`

**Arguments from user:** $ARGUMENTS

**Subcommands:**

- **No args / `list`**: Call `mcp__memoryrelay__decision_list` with optional `--project` filter. Display as a table: ID, Topic, Decision (truncated), Date, Status.
- **`check`**: Requires `--topic`. Call `mcp__memoryrelay__decision_check` with project and topic. Report whether a prior decision exists and what it says.
- **`record`**: Requires `--topic`. Interactively ask the user for the decision and rationale, then call `mcp__memoryrelay__decision_record` with project, topic, decision, and rationale.
