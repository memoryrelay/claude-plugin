---
name: memory-promote
description: Promote a memory's tier for faster retrieval
---

Promote a memory to a higher tier (cold -> warm -> hot) for faster retrieval.

**Usage:** `/memory-promote <id> [--tier hot|warm]`

**Arguments from user:** $ARGUMENTS

1. Parse the memory ID (first argument)
2. Parse optional `--tier` (default: hot)
3. Call `mcp__memoryrelay__memory_get` to show current memory and tier
4. Call `mcp__memoryrelay__memory_promote` with the memory ID and target tier
5. Confirm the promotion
