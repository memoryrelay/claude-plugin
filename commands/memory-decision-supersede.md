---
name: memory-decision-supersede
description: Replace an outdated architectural decision with a new one
---

Supersede an existing architectural decision in MemoryRelay.

**Usage:** `/memory-decision-supersede <decision-id> <new-decision> [--rationale R]`

**Arguments from user:** $ARGUMENTS

1. Parse the decision ID (first argument, required)
2. Parse the new decision text (remaining text before flags)
3. Parse optional `--rationale` flag
4. Call `mcp__memoryrelay__decision_check` or `mcp__memoryrelay__decision_list` to show the current decision being superseded
5. Confirm with the user before proceeding
6. Call `mcp__memoryrelay__decision_supersede` with the decision ID, new decision, and rationale
7. Confirm the supersession
