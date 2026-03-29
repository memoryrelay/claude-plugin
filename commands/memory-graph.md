---
name: memory-graph
description: Visualize entity relationships in the MemoryRelay knowledge graph
---

Display the knowledge graph for an entity or the entire graph.

**Usage:** `/memory-graph [--entity E] [--depth N]`

**Arguments from user:** $ARGUMENTS

1. Parse optional flags:
   - `--entity` (specific entity to center the graph on)
   - `--depth` (traversal depth, default: 2)
2. Call `mcp__memoryrelay__entity_graph` with the parsed parameters
3. Display the graph as a formatted tree or adjacency list showing entities and their relationships
