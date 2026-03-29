---
name: memory-project-deps
description: Show project dependency graph from MemoryRelay
---

Display dependency relationships for a project.

**Usage:** `/memory-project-deps <project> [--direction up|down|both]`

**Arguments from user:** $ARGUMENTS

1. Parse the project name (first argument, default: current directory name)
2. Parse optional `--direction` (default: both)
3. Based on direction:
   - `up`: Call `mcp__memoryrelay__project_dependents` (who depends on this project)
   - `down`: Call `mcp__memoryrelay__project_dependencies` (what this project depends on)
   - `both`: Call both, plus `mcp__memoryrelay__project_related` for lateral relationships
4. Display as a dependency tree showing upstream and downstream projects
