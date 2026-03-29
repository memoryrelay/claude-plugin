---
name: memory-status
description: Show MemoryRelay connection status, active session, and memory count
---

Check MemoryRelay status by calling these MCP tools and presenting the results in a clean summary:

1. Call `mcp__memoryrelay__memory_health` to check API connectivity
2. Call `mcp__memoryrelay__memory_status` to get current status details
3. Call `mcp__memoryrelay__session_list` to check for active sessions

Present results as:

```
MemoryRelay Status
──────────────────
API:       [healthy/unhealthy] (response time)
Endpoint:  api.memoryrelay.net
Memories:  [count] total
Session:   [active session ID or "none"]
Agent:     [agent ID]
```
