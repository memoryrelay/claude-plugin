---
name: memory-project-impact
description: Analyze change impact and shared patterns for a project
---

Analyze what would be affected by changes to a project.

**Usage:** `/memory-project-impact <project>`

**Arguments from user:** $ARGUMENTS

1. Parse the project name (first argument, default: current directory name)
2. Call `mcp__memoryrelay__project_impact` to get impact analysis
3. Call `mcp__memoryrelay__project_shared_patterns` to find patterns shared with other projects
4. Present a combined report:
   - Affected downstream projects
   - Shared patterns that might need updating
   - Risk assessment based on dependency depth
