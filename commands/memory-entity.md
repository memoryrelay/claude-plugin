---
name: memory-entity
description: Manage knowledge graph entities in MemoryRelay
---

Manage entities in the MemoryRelay knowledge graph.

**Usage:** `/memory-entity [create|list|link] [--name N] [--type T]`

**Arguments from user:** $ARGUMENTS

**Subcommands:**

- **No args / `list`**: Call `mcp__memoryrelay__entity_list`. Display as a table: Name, Type, Linked Entities Count.
- **`create`**: Requires `--name` and `--type`. Call `mcp__memoryrelay__entity_create` with name, type, and optional description.
- **`link`**: Requires two entity names/IDs. Call `mcp__memoryrelay__entity_link` to create a relationship between them. Ask for relationship type if not provided.
