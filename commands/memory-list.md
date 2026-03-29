---
name: memory-list
description: List recent memories from MemoryRelay
---

List memories stored in MemoryRelay. Parse the arguments for optional filters.

**Usage:** `/memory-list [--limit N] [--offset N] [--scope S]`

**Arguments from user:** $ARGUMENTS

1. Parse optional flags:
   - `--limit` (default: 10, max: 100)
   - `--offset` (default: 0)
   - `--scope` (optional: filter by scope)
2. Call `mcp__memoryrelay__memory_list` with parsed parameters
3. Display as a numbered table with columns: ID (truncated), Content (first 80 chars), Created, Importance
