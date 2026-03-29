---
name: memory-agent
description: Manage agent identities in MemoryRelay
---

Manage agent identities registered in MemoryRelay.

**Usage:** `/memory-agent [list|create|get] [--id I] [--name N]`

**Arguments from user:** $ARGUMENTS

**Subcommands:**

- **No args / `list`**: Call `mcp__memoryrelay__agent_list`. Display as a table: ID, Name, Created, Memory Count.
- **`create`**: Requires `--name`. Call `mcp__memoryrelay__agent_create` with the name and optional metadata.
- **`get`**: Requires `--id`. Call `mcp__memoryrelay__agent_get` and display full agent details including associated memories and sessions.
