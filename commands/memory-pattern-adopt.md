---
name: memory-pattern-adopt
description: Adopt a pattern or get pattern suggestions for the current project
---

Adopt an existing pattern for the current project or get AI suggestions.

**Usage:** `/memory-pattern-adopt [<pattern-id>] [--project P]`

**Arguments from user:** $ARGUMENTS

1. If a pattern ID is provided:
   - Call `mcp__memoryrelay__pattern_adopt` with the pattern ID and project (default: current directory name)
   - Confirm adoption
2. If no pattern ID:
   - Call `mcp__memoryrelay__pattern_suggest` with the current project
   - Display suggested patterns and let the user choose which to adopt
