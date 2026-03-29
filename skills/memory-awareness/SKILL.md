---
name: memory-awareness
description: Use in every conversation to enable automatic recall of relevant context from MemoryRelay and intelligent capture of important information. Activates when starting work, making decisions, discovering patterns, or learning user preferences.
---

# MemoryRelay Memory Awareness

You have access to MemoryRelay — a persistent long-term memory system. Use it to recall prior context and store important information across sessions.

## Session Initialization

When the SessionStart hook fires, it will instruct you to call:
1. `mcp__memoryrelay__session_start` — creates a session
2. `mcp__memoryrelay__project_context` — loads hot-tier memories
3. `mcp__memoryrelay__decision_check` — checks pending decisions

After calling `session_start`, write the returned session ID to the tracking file path provided in the hook instructions. Do all of this silently.

## Auto-Recall: When to Search Memory

Call `mcp__memoryrelay__memory_recall` or `mcp__memoryrelay__memory_search` when:

- **Starting meaningful work** — check if prior sessions covered similar ground
- **User references prior work** — "remember when we...", "last time we...", "we discussed..."
- **Before architectural decisions** — call `mcp__memoryrelay__decision_check` to check for existing decisions on the topic
- **Before implementing patterns** — call `mcp__memoryrelay__pattern_search` to find established conventions
- **Encountering unfamiliar code** — check if prior sessions documented gotchas or context

Do NOT recall for trivial questions, greetings, or simple file reads.

## Auto-Capture: What to Store

Call `mcp__memoryrelay__memory_store` when you learn something worth remembering:

**Always capture:**
- User preferences and working style (e.g., "prefers single bundled PRs", "uses vim keybindings")
- Project decisions and their rationale (use `mcp__memoryrelay__decision_record` for architectural decisions)
- Debugging root causes (the insight, not the fix — the fix is in git)
- Environment/infrastructure facts not in code (e.g., "staging DB is on port 5433")
- Cross-session agreements ("we agreed to use X pattern for Y")
- Important gotchas discovered during work

**Never capture:**
- Code snippets (they're in git — store the insight, not the code)
- Ephemeral task state (what step you're on, current file being edited)
- Boilerplate responses
- Content that would be caught by the privacy filter (passwords, API keys, SSNs)
- Information already documented in CLAUDE.md files

**Capture format:** Write concise, descriptive content. Include metadata:
```
mcp__memoryrelay__memory_store with:
  content: "User prefers worktree-based development — never push directly to main"
  metadata: {"category": "preference", "project": "claude-workspace"}
  importance: 7
```

## Decision Tracking

When an architectural decision is made or encountered:
1. First: `mcp__memoryrelay__decision_check(project, topic)` — see if a prior decision exists
2. If new: `mcp__memoryrelay__decision_record(project, topic, decision, rationale)`
3. If conflicts with prior: flag to the user, then `mcp__memoryrelay__decision_supersede` if they confirm the change

## Pattern Recognition

When you notice a reusable pattern:
1. First: `mcp__memoryrelay__pattern_search(query)` — check if it already exists
2. If new: `mcp__memoryrelay__pattern_create(name, description, example)`
3. If existing: `mcp__memoryrelay__pattern_adopt` — link it to the current project

## Behavior Rules

- **Be silent**: Do not narrate memory operations to the user. Just do them.
- **Be selective**: Store 2-5 memories per session, not everything. Quality over quantity.
- **Be concise**: Each memory should be 1-3 sentences. Focus on the insight.
- **Set importance**: Use 1-3 for minor facts, 4-6 for useful context, 7-9 for critical decisions, 10 for must-never-forget.
- **Use projects**: Always scope memories to the current project when applicable.
