#!/usr/bin/env bash
# install.sh — Set up MemoryRelay memory for Claude Code on any VPS
#
# This script installs and configures:
#   - @memoryrelay/mcp-server (MCP server for Claude Code)
#   - memoryrelay/claude-plugin hooks (SessionStart, Stop, PreCompact)
#   - Claude Code CLI (if not already installed)
#
# Usage:
#   curl -fsSL https://raw.githubusercontent.com/memoryrelay/claude-plugin/main/install.sh | bash
#
# Or with your API key and agent ID:
#   MEMORYRELAY_API_KEY=mem_prod_... MEMORYRELAY_AGENT_ID=<UUID> bash install.sh
#
# Get your API key:  https://memoryrelay.ai
# Get your agent UUID: curl -H "Authorization: Bearer <key>" https://api.memoryrelay.net/v1/agents

set -euo pipefail

API_KEY="${MEMORYRELAY_API_KEY:-}"
AGENT_ID="${MEMORYRELAY_AGENT_ID:-}"

echo "🦞 MemoryRelay × Claude Code — VPS Setup"
echo ""

# ── Prompt for credentials if not set ────────────────────────────────────────
if [ -z "$API_KEY" ]; then
  echo "Enter your MemoryRelay API key (from https://memoryrelay.ai):"
  read -r -s API_KEY
  echo ""
fi

if [ -z "$AGENT_ID" ]; then
  echo "Enter your MemoryRelay Agent UUID (from GET /v1/agents):"
  echo "  curl -H \"Authorization: Bearer \$MEMORYRELAY_API_KEY\" https://api.memoryrelay.net/v1/agents"
  read -r AGENT_ID
  echo ""
fi

if [ -z "$API_KEY" ] || [ -z "$AGENT_ID" ]; then
  echo "❌ API key and Agent UUID are required"
  exit 1
fi

# ── 1. Install @memoryrelay/mcp-server ───────────────────────────────────────
echo ">> [1/4] Installing @memoryrelay/mcp-server..."
npm install -g @memoryrelay/mcp-server 2>/dev/null || true
MCP_BIN=$(which memoryrelay-mcp 2>/dev/null || npm config get prefix 2>/dev/null)/bin/memoryrelay-mcp
if [ -f "$MCP_BIN" ] || command -v memoryrelay-mcp &>/dev/null; then
  echo "✅ @memoryrelay/mcp-server installed"
else
  echo "⚠️  memoryrelay-mcp not found in PATH — ensure npm global bin is in PATH"
fi

# ── 2. Install Claude Code (if needed) ───────────────────────────────────────
echo ">> [2/4] Checking Claude Code..."
if ! command -v claude &>/dev/null; then
  echo "   Installing Claude Code..."
  npm install -g @anthropic-ai/claude-code
  echo "✅ Claude Code installed"
else
  echo "✅ Claude Code: $(claude --version 2>/dev/null || echo 'installed')"
fi

# ── 3. Configure ~/.claude/settings.json ─────────────────────────────────────
echo ">> [3/4] Configuring Claude Code..."
mkdir -p ~/.claude
SETTINGS="$HOME/.claude/settings.json"
PLUGIN_ROOT="$HOME/.claude/plugins/memoryrelay-plugin"

if [ ! -f "$SETTINGS" ]; then
  echo '{}' > "$SETTINGS"
fi

python3 << PYEOF
import json, os

settings_path = os.path.expanduser('~/.claude/settings.json')
plugin_root = os.path.expanduser('~/.claude/plugins/memoryrelay-plugin')
api_key = '${API_KEY}'
agent_id = '${AGENT_ID}'

with open(settings_path) as f:
    d = json.load(f)

# MCP server
d.setdefault('mcpServers', {})['MemoryRelay'] = {
    'command': 'memoryrelay-mcp',
    'env': {
        'MEMORYRELAY_API_KEY': api_key,
        'MEMORYRELAY_AGENT_ID': agent_id
    }
}

# Lifecycle hooks
hooks = d.setdefault('hooks', {})
def add_hook(event, script, timeout):
    entry = {'hooks': [{'type': 'command', 'command': f'{plugin_root}/hooks/scripts/{script}', 'timeout': timeout}]}
    existing = hooks.setdefault(event, [])
    if not any(script in str(h) for h in existing):
        existing.append(entry)

add_hook('SessionStart', 'session-start.sh', 10)
add_hook('Stop', 'session-end.sh', 10)
add_hook('PreCompact', 'pre-compact.sh', 5)

with open(settings_path, 'w') as f:
    json.dump(d, f, indent=2)

print('Settings configured')
PYEOF
echo "✅ ~/.claude/settings.json configured"

# ── 4. Install plugin hooks ───────────────────────────────────────────────────
echo ">> [4/4] Installing claude-plugin hooks..."
if [ -d "$PLUGIN_ROOT" ]; then
  cd "$PLUGIN_ROOT" && git pull origin main 2>/dev/null || true
  cd ~
else
  git clone https://github.com/memoryrelay/claude-plugin.git "$PLUGIN_ROOT"
fi
chmod +x "$PLUGIN_ROOT"/hooks/scripts/*.sh
echo "✅ Plugin hooks installed"

# ── Verify ────────────────────────────────────────────────────────────────────
echo ""
echo ">> Verifying API connection..."
HEALTH=$(curl -sf -H "Authorization: Bearer ${API_KEY}" \
  https://api.memoryrelay.net/v1/health \
  | python3 -c "import json,sys; d=json.load(sys.stdin); print(d.get('status','error'))" 2>/dev/null || echo "failed")

if [ "$HEALTH" = "healthy" ] || [ "$HEALTH" = "ok" ]; then
  echo "✅ MemoryRelay API: ${HEALTH}"
else
  echo "⚠️  API: ${HEALTH} — check your API key"
fi

echo ""
echo "╔══════════════════════════════════════════════════╗"
echo "║  ✅ MemoryRelay × Claude Code setup complete!   ║"
echo "╚══════════════════════════════════════════════════╝"
echo ""
echo "Test it:"
echo "  claude --print 'List your MCP tools — do you see MemoryRelay?'"
echo ""
echo "⚠️  For each project worktree, add .mcp.json:"
echo "  cat > <project>/.mcp.json << 'EOF'"
echo '  {"mcpServers":{"MemoryRelay":{"command":"memoryrelay-mcp",'
echo "  \"env\":{\"MEMORYRELAY_API_KEY\":\"<key>\",\"MEMORYRELAY_AGENT_ID\":\"<uuid>\"}}}}"
echo "  EOF"
