> [!WARNING]
> **This repository is retired.** The MemoryRelay plugin for Claude Code now lives in
> [`memoryrelay/api` → `plugins/memoryrelay`](https://github.com/memoryrelay/api/tree/main/plugins/memoryrelay),
> rewritten on the current tool surface. The hooks and commands here call tools the
> MemoryRelay API no longer serves (`session_start`, `project_context`, `decision_check`,
> `decision_record`, `pattern_create`, …) and do nothing useful.
>
> Install the new plugin:
>
> ```bash
> claude plugin marketplace add memoryrelay/memoryrelay-marketplace
> claude plugin install memoryrelay@memoryrelay
> ```
>
> Inside a session: `/plugin marketplace add memoryrelay/memoryrelay-marketplace`, then
> `/plugin install memoryrelay@memoryrelay`. It needs `MEMORYRELAY_API_KEY` and Node.js;
> see [Connect an agent](https://docs.memoryrelay.ai/connect-an-agent#the-claude-code-plugin).
> If you installed this repository's copy by hand, remove it first.

# MemoryRelay plugin for Claude Code (retired)

The files below are kept for reference until the repository is archived.
