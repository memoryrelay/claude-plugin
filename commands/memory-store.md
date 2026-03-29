---
name: memory-store
description: Manually store a memory in MemoryRelay
---

Store a new memory in MemoryRelay. Parse the arguments for content and optional flags.

**Usage:** `/memory-store <content> [--project P] [--importance N] [--tier T]`

**Arguments from user:** $ARGUMENTS

1. Parse the content (everything before any `--` flags)
2. Parse optional flags:
   - `--project` (default: infer from current directory)
   - `--importance` (1-10, default: 5)
   - `--tier` (hot/warm/cold, default: warm)
3. Call `mcp__memoryrelay__memory_store` with the parsed content and metadata
4. Confirm storage with the returned memory ID
