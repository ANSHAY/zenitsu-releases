# Zenitsu plugin for Claude Code

Everything Claude Code needs to use [Zenitsu](https://github.com/ANSHAY/zenitsu-releases) well, in one install. Install Zenitsu itself first, from the downloads on that page.

| Part | What it does |
|---|---|
| **MCP server** (`.mcp.json`) | A small start-up script finds the `zenitsu-mcp` that came with your installed Zenitsu (1.10+: `.deb`, `.rpm` or tarball; for the AppImage, set `ZENITSU_APPIMAGE` to its path) and starts it, so the server always matches your Zenitsu. It finds your database in the usual place, or in `$ZENITSU_DB`. |
| **`zenitsu` skill** | The rules for tasks, notes, the daily note, repeats and reviews. Claude loads it whenever Zenitsu is involved, instead of carrying the rules in every project's instructions. It reads your own conventions from the Zenitsu note **Claude › House rules** first. |
| **`/zenitsu:daily-line`** | Adds one line for finished work to today's daily note, under the right bucket and project. |
| **`/zenitsu:sunday-review`** | Runs the weekly review: reads the week, asks the review questions in one message, writes the review note, tidies repeats and plans the week. |

## Install

```text
/plugin marketplace add ANSHAY/zenitsu-releases
/plugin install zenitsu@zenitsu
```

Or from a terminal: `claude plugin marketplace add ANSHAY/zenitsu-releases`, then `claude plugin install zenitsu@zenitsu`. If you registered Zenitsu before with `claude mcp add … zenitsu`, remove that (`claude mcp remove zenitsu -s user`) so the tools are not offered twice.

## Your own rules

Create a note titled **House rules** in a folder called **Claude** in Zenitsu, and write your conventions there in plain words: special projects, priority bands, which writes need your approval, where reviews go. The skill reads it at the start of every Zenitsu session, and it wins over the skill's general rules. In **Settings → AI apps → Rules for AI apps** you can also make the server itself refuse tasks without a priority, a type or a due date.
