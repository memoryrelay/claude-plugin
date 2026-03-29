---
name: memory-project
description: Manage projects in MemoryRelay — register, list, info, or load context
---

Manage projects tracked in MemoryRelay.

**Usage:** `/memory-project [register|list|info|context] [--name N]`

**Arguments from user:** $ARGUMENTS

**Subcommands:**

- **No args / `list`**: Call `mcp__memoryrelay__project_list`. Display as a table: Name, Description (truncated), Memory Count, Last Updated.
- **`register`**: Requires `--name`. Interactively ask for description and metadata, then call `mcp__memoryrelay__project_register`.
- **`info`**: Requires `--name` (default: current directory name). Call `mcp__memoryrelay__project_info` and display full project details.
- **`context`**: Requires `--name` (default: current directory name). Call `mcp__memoryrelay__project_context` and display the loaded context memories.
