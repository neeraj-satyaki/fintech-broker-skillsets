#!/usr/bin/env bash
# Fintech Broker Skillsets — Installer
# Installs Claude Code broker tracking commands into any project.
#
# Usage:
#   curl -sSL https://raw.githubusercontent.com/YOUR_ORG/fintech-skillsets/main/install.sh | bash
#   OR
#   ./install.sh                    # install into current directory
#   ./install.sh /path/to/project   # install into specific project

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
TARGET_DIR="${1:-$(pwd)}"

echo "=== Fintech Broker Skillsets Installer ==="
echo "Installing into: $TARGET_DIR"
echo ""

# Create directory structure
mkdir -p "$TARGET_DIR/.claude/commands"
mkdir -p "$TARGET_DIR/snapshots"
mkdir -p "$TARGET_DIR/reports"
mkdir -p "$TARGET_DIR/brokers"

# Copy broker registry
if [ -f "$SCRIPT_DIR/broker-registry.json" ]; then
    cp "$SCRIPT_DIR/broker-registry.json" "$TARGET_DIR/broker-registry.json"
    echo "[+] Copied broker-registry.json"
else
    echo "[!] broker-registry.json not found in source, skipping"
fi

# Copy slash commands
for cmd in broker-sync broker-diff broker-list broker-update; do
    if [ -f "$SCRIPT_DIR/.claude/commands/${cmd}.md" ]; then
        cp "$SCRIPT_DIR/.claude/commands/${cmd}.md" "$TARGET_DIR/.claude/commands/${cmd}.md"
        echo "[+] Installed /$(echo $cmd | tr '-' '-') command"
    else
        echo "[!] ${cmd}.md not found in source, skipping"
    fi
done

# Copy CLAUDE.md if target doesn't have one, otherwise append
if [ -f "$TARGET_DIR/CLAUDE.md" ]; then
    echo ""
    echo "[!] CLAUDE.md already exists in target."
    echo "    Broker skillset docs saved to CLAUDE-broker-skillsets.md"
    echo "    You may want to merge it manually."
    if [ -f "$SCRIPT_DIR/CLAUDE.md" ]; then
        cp "$SCRIPT_DIR/CLAUDE.md" "$TARGET_DIR/CLAUDE-broker-skillsets.md"
    fi
else
    if [ -f "$SCRIPT_DIR/CLAUDE.md" ]; then
        cp "$SCRIPT_DIR/CLAUDE.md" "$TARGET_DIR/CLAUDE.md"
        echo "[+] Copied CLAUDE.md"
    fi
fi

# Add .gitignore entries for snapshots/reports if git repo
if [ -d "$TARGET_DIR/.git" ]; then
    GITIGNORE="$TARGET_DIR/.gitignore"
    touch "$GITIGNORE"
    for entry in "snapshots/*.md" "reports/*.md"; do
        if ! grep -qF "$entry" "$GITIGNORE" 2>/dev/null; then
            echo "# Broker doc snapshots and reports are tracked in git for the daily agent"
            echo "# Uncomment below to ignore them:"
            echo "# $entry"
        fi
    done
    echo "[+] Checked .gitignore"
fi

echo ""
echo "=== Installation Complete ==="
echo ""
echo "Available commands:"
echo "  /broker-sync zerodha      — Fetch latest Zerodha docs"
echo "  /broker-sync all          — Fetch all broker docs"
echo "  /broker-diff upstox       — Audit Upstox integration for deprecations"
echo "  /broker-list free         — List brokers with free API access"
echo "  /broker-list xts          — List XTS-based brokers"
echo "  /broker-update            — Run daily update (Zerodha, Upstox, Firstock)"
echo ""
echo "Next steps:"
echo "  1. Initialize git repo:  git init && git add -A && git commit -m 'Add broker skillsets'"
echo "  2. Push to GitHub so the daily remote agent can access it"
echo "  3. Update the remote trigger with your repo URL"
echo "  4. Run /broker-sync all to create initial snapshots"
