# Zenitsu plugin for Claude Code

Teaches Claude to use [Zenitsu](https://github.com/ANSHAY/zenitsu-releases), the local task manager and notebook, well: the rules for tasks, notes, the daily note, repeats and reviews, and two commands. Zenitsu itself runs on your computer, and Claude reaches it through `zenitsu-mcp`, the small program that ships with the Zenitsu app.

| Part | What it does |
|---|---|
| **`zenitsu` skill** | The rules for tasks, notes, the daily note, repeats and reviews. Claude loads it whenever Zenitsu is involved, instead of carrying the rules in every project's instructions. It reads your own conventions from the Zenitsu note **Claude › House rules** first. |
| **`/zenitsu:daily-line`** | Adds one line for finished work to today's daily note, under the right bucket and project. |
| **`/zenitsu:sunday-review`** | Runs the weekly review: reads the week, asks the review questions in one message, writes the review note, tidies repeats and plans the week. |

## Connect Zenitsu

This plugin holds only the skill and the commands. Claude needs the Zenitsu tools as well:

1. Install Zenitsu (free for Linux: [downloads](https://github.com/ANSHAY/zenitsu-releases)) and open it once.
2. In Zenitsu, open **Settings → AI apps** and press **Copy command** beside Claude Code.
3. Run that command in a terminal, then restart Claude Code. `claude mcp list` shows `zenitsu` as connected.

The skill and commands work in Claude Code, and in apps that run on the same computer as Zenitsu. In claude.ai chat they load, but Zenitsu cannot be reached from there, so Claude explains how to connect instead.

## Your own rules

Create a note titled **House rules** in a folder called **Claude** in Zenitsu, and write your conventions there in plain words: special projects, priority bands, which writes need your approval, where reviews go. The skill reads it at the start of every Zenitsu session, and it wins over the skill's general rules. In **Settings → AI apps → Rules for AI apps** you can also make the server itself refuse tasks without a priority, a type or a due date.

## Privacy

This plugin is text only: it runs no program and sends nothing anywhere. Zenitsu keeps your tasks and notes on your computer. The AI app you connect shares what it reads with its own provider. Full policy: [Zenitsu privacy policy](https://xernaitech.com/app/zenitsu/privacy-policy/).
