---
name: memory-pattern
description: Create or search reusable patterns in MemoryRelay
---

Manage reusable patterns in MemoryRelay.

**Usage:** `/memory-pattern [create|search] [--name N] [--query Q]`

**Arguments from user:** $ARGUMENTS

**Subcommands:**

- **No args / `search`**: Call `mcp__memoryrelay__pattern_search` with `--query` or list recent patterns. Display as a table: Name, Description (truncated), Adoption Count.
- **`create`**: Requires `--name`. Interactively ask the user for the pattern description and an example, then call `mcp__memoryrelay__pattern_create` with name, description, and example.
