#!/bin/sh
# Starts the zenitsu-mcp that ships with the user's installed Zenitsu, so the
# server always matches their Zenitsu version and database (a server older than
# the database refuses it). Bundling a copy in the plugin would break that.
set -eu

if [ -n "${ZENITSU_MCP:-}" ]; then
  exec "$ZENITSU_MCP" "$@"
fi
if [ -n "${ZENITSU_APPIMAGE:-}" ]; then
  exec "$ZENITSU_APPIMAGE" mcp "$@"
fi

for candidate in \
  "$(command -v zenitsu-mcp 2>/dev/null || true)" \
  "$HOME/.local/bin/zenitsu-mcp" \
  "$HOME/.local/lib/zenitsu/mcp/bin/zenitsu-mcp" \
  /usr/bin/zenitsu-mcp \
  /usr/lib/zenitsu/mcp/bin/zenitsu-mcp; do
  if [ -n "$candidate" ] && [ -x "$candidate" ]; then
    exec "$candidate" "$@"
  fi
done

echo "zenitsu-mcp was not found. Install Zenitsu (free for Linux:" \
  "https://github.com/ANSHAY/zenitsu-releases) and open it once. With the" \
  "AppImage, set ZENITSU_APPIMAGE to its path." >&2
exit 127
