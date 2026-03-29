---
name: memory-search
description: Semantic search across MemoryRelay memories
---

Search MemoryRelay for relevant memories. Parse the arguments for a search query and optional flags.

**Usage:** `/memory-search <query> [--limit N] [--threshold N]`

**Arguments from user:** $ARGUMENTS

1. Parse the query from the arguments (everything before any `--` flags)
2. Parse optional `--limit` (default: 5, max: 20) and `--threshold` (default: 0.3, range: 0-1)
3. Call `mcp__memoryrelay__memory_recall` with:
   - query: the parsed query
   - limit: parsed limit
   - threshold: parsed threshold
4. Display results as a numbered list with similarity scores and creation dates
5. If no results found, suggest broadening the query or lowering the threshold
