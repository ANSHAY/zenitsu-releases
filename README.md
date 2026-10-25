# Zenitsu

Zenitsu is a fast, private task manager and notebook for Linux. Your tasks, notes and daily journal stay on your own computer, and AI apps such as Claude can read and update them for you, under rules you set.

## Download (Linux, free)

| Your system | Download |
|---|---|
| Ubuntu, Debian, Mint | [zenitsu-latest-amd64.deb](https://github.com/ANSHAY/zenitsu-releases/releases/latest/download/zenitsu-latest-amd64.deb) |
| Fedora, RHEL, openSUSE | [zenitsu-latest-x86_64.rpm](https://github.com/ANSHAY/zenitsu-releases/releases/latest/download/zenitsu-latest-x86_64.rpm) |
| Any distribution | [Zenitsu-latest-x86_64.AppImage](https://github.com/ANSHAY/zenitsu-releases/releases/latest/download/Zenitsu-latest-x86_64.AppImage) or [the tarball](https://github.com/ANSHAY/zenitsu-releases/releases/latest/download/zenitsu-latest-linux-x64.tar.gz) |

Older versions are on the [Releases](https://github.com/ANSHAY/zenitsu-releases/releases) page.

## Use Zenitsu with AI apps

Install Zenitsu first and open it once. It includes `zenitsu-mcp`, a small program that lets AI apps work with your tasks and notes on this computer. Nothing is sent anywhere by Zenitsu, and the AI can never erase your data.

**Claude Code** — install the Zenitsu plugin. It connects Claude to Zenitsu and teaches it how to use it well, and adds `/zenitsu:daily-line` and `/zenitsu:sunday-review`:

```text
/plugin marketplace add ANSHAY/zenitsu-releases
/plugin install zenitsu@zenitsu
```

**Other AI apps** — point them at `zenitsu-mcp`:

| App | How |
|---|---|
| Codex | `codex mcp add zenitsu -- zenitsu-mcp` |
| VS Code (Copilot) | `code --add-mcp '{"name":"zenitsu","type":"stdio","command":"zenitsu-mcp"}'` |
| Cursor, Claude Desktop, Gemini and others | add `{"mcpServers": {"zenitsu": {"command": "zenitsu-mcp", "args": []}}}` to the app's MCP settings |

With the AppImage, use the AppImage's path as the command and `mcp` as its first argument. In Zenitsu, **Settings → AI apps** shows the exact setup for your computer and lets you require that every task an AI adds has a priority, a type and a due date.

## Licence

The plugin in `claude-plugin/` is MIT-licensed; everything else is all rights reserved. See [LICENSE.md](LICENSE.md).
