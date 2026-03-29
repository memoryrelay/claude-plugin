---
name: memory-context
description: Build a token-aware context window from relevant memories
---

Build a context window from MemoryRelay memories optimized for token budget.

**Usage:** `/memory-context [--tokens N] [--project P]`

**Arguments from user:** $ARGUMENTS

1. Parse optional flags:
   - `--tokens` (default: 4000, max token budget for context)
   - `--project` (default: infer from current directory)
2. Call `mcp__memoryrelay__context_build` with:
   - max_tokens: parsed token limit
   - project: parsed project
3. Display the built context, showing which memories were included and total token usage
