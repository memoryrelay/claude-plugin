---
name: memory-forget
description: Delete memories from MemoryRelay by query or ID
---

Delete memories from MemoryRelay. Parse the arguments for a query or memory ID.

**Usage:** `/memory-forget <query or ID>`

**Arguments from user:** $ARGUMENTS

1. Determine if the argument is a memory ID (starts with `mem_`) or a search query
2. If it's a query:
   - Call `mcp__memoryrelay__memory_recall` to find matching memories
   - Show the matches and ask the user to confirm which ones to delete
3. If it's an ID:
   - Show the memory content and ask the user to confirm deletion
4. After confirmation, call `mcp__memoryrelay__memory_forget` with the confirmed ID(s)
5. Report how many memories were deleted
