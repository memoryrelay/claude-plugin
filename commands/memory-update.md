---
name: memory-update
description: Edit an existing memory's content or metadata
---

Update an existing memory in MemoryRelay.

**Usage:** `/memory-update <id> <new-content> [--metadata key=value]`

**Arguments from user:** $ARGUMENTS

1. Parse the memory ID (first argument)
2. Parse the new content (remaining text before flags)
3. Parse optional `--metadata` flags as key=value pairs
4. Call `mcp__memoryrelay__memory_get` to show the current memory content
5. Call `mcp__memoryrelay__memory_update` with the new content and metadata
6. Confirm the update was successful
