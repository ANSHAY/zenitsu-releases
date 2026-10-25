---
name: zenitsu
description: Rules for using Zenitsu, the user's local task manager and notebook, through the zenitsu MCP tools. Use whenever a to-do is created, started, finished or changed in any project; when the user asks what is on their list, what to do next, or what they did; when writing a daily-note line, a note, a plan or a review; and before any change to Zenitsu tasks, notes, buckets, projects, types or statuses.
---

# Zenitsu

Zenitsu is the user's own task manager and notebook. The `zenitsu` MCP tools read and change it directly, and the user sees every change in the open app within about a second. It is the one place that shows what is going on across all of their projects, so keep it true.

## Start of every Zenitsu session

1. Call `get_overview`. It gives **today's date** (use it, not your own idea of the date: work after midnight belongs to the new day), the time zone, every bucket, project, type and status by their exact names, and `rules_for_ai`.
2. Read the user's house rules: `search` for "House rules", then `read_note` on the note titled **House rules** in the folder **Claude**. It holds their personal conventions (special projects, priority bands, folders, review layout, approvals). **The house rules win over anything below.** If there is no such note, use the rules below as they are.

## What needs the user's approval

- **Deleting** anything (tasks, notes, catalogue entries): always. Show exactly what will be deleted and ask; delete only what was approved. `restore_tasks` brings deleted tasks back.
- **Creating a bucket, project, type or status**: always ask first. Use the existing names from `get_overview`; the tool error lists them when a name is wrong.
- **Changing many tasks at once**: say what will change before doing it.
- Reading never needs approval. Other writes follow the house rules; when they say nothing, write and then tell the user what you wrote.

## Keep Zenitsu up to date, unasked

When your work in any project creates a new to-do, starts one, finishes one or changes one, make the matching Zenitsu change **in the same step**, without waiting to be told.

- Started work: move the task to the in-progress status (it stamps when work began).
- Finished work: move it to the done status. That completes it, puts it on the timeline, and makes a repeating task create its next copy.
- A missed occurrence of a routine is **skipped** (`skip_occurrences`), never marked done, so the timeline only shows what happened.
- Plans, roadmaps and playbooks in repos stay as reference documents; the task list itself lives in Zenitsu.

## Every task, fully tagged

Set **bucket, project, type, status and priority** on every task, never leaving type empty (pick the closest). Add a **due date** whenever there is a target day, a **repeat** for recurring work, a **snooze** date when it should stay hidden until later, and a **time needed** ("45m", "1h30") when you can estimate it. If `rules_for_ai` says a field is required, the server refuses a task without it and says what to add.

**Priority:** a number where **lower is more important** (0 first, 10 later, 100 much later). Fractions place a task between two others (2.5 between 2 and 3). A negative priority means "none given yet", never "most important", and it is what a task gets when you pass none, so always pass a real one: run `list_tasks` for the same project and place the new task among its open tasks. If the right place is unclear, ask.

## Task text: short and complete

- **Title:** what to do, in a few words.
- **Details:** a few short lines with the time it needs, why it matters if that is not obvious, and whatever is needed to do it (a path, a command, a prompt). No paragraphs of background, nothing the title already says.
- **Checklist:** the steps that are not obvious, one short line each (`create_tasks` takes `checklist`; `update_checklist` changes it).
- The task must be complete enough to act on without asking, but never so long that reading it feels daunting.

## Repeating tasks

- Never make several copies of one task for different dates: make one task and give it a repeat (`set_task_repeat`). Rules are RRULE text: `FREQ=DAILY`, `FREQ=WEEKLY;BYDAY=MO,TH`, `FREQ=MONTHLY;BYMONTHDAY=-1` (last day), `FREQ=MONTHLY;BYDAY=1SU` (first Sunday), `INTERVAL=2`.
- When a repeat should stop on a day, pass `until` (the last day an occurrence may fall on).
- Editing a repeating task changes only the current copy. To change the copies still to come too, pass `include_future_copies: true` to `update_tasks`.
- The next copy is made from the series, not from the current copy's checklist, so for a repeating task put the steps in the **details**.

## The daily note: one line per finished thing

- After each piece of finished work that has **no task**, add one plain line to today's daily note saying what was done. Work recorded by marking a task done gets **no** line: done tasks are already on the timeline. Small steps along the way do not get lines.
- The note is laid out by bucket, then project: `## <Bucket>`, and under it `### <Project>` with `- ` lines. Work with no real project goes straight under the bucket heading.
- Write it with `append_to_note`: `date: "today"`, `heading: "<Bucket> > <Project>"` (or just `"<Bucket>"`), `text: "- <line>"`. It adds the line at the end of that section and creates missing headings and the note itself. **Never rewrite a daily note** (`update_note` refuses one unless told otherwise, and that is only for when the user asked).

## Notes

- Notes are markdown in folders written as paths ("Work/Ideas"); `create_note` creates missing folders.
- To add to a note use `append_to_note`, not `update_note`, which replaces the whole text. Read a note before replacing any of it.
- Notes that should be reachable from every project belong in Zenitsu, not in one repo.
- The **inbox** holds quick lines that have not been filed: `capture_to_inbox` when the user has not said where something belongs, `file_inbox_items` to turn lines into tasks.

## Reviews and history

- `get_timeline` with `from` and `to` lists what was finished in a period (`include_status_moves` adds what moved between statuses).
- `read_note` with `date` reads that day's daily note. For a whole month, `run_sql_query` on `notes` is faster: `note_date` is milliseconds since 1970, so use `date(note_date/1000, 'unixepoch', 'localtime')`.
- `get_task` includes a task's change history; `suggest_next_task` is the app's "What now?" and takes `minutes` for "what fits in my next 2 hours?".

## Large changes

- Use the batch tools: `create_tasks` (up to 50 per call) and `update_tasks` (up to 200 ids) apply all or none.
- After a big write, read it back (`list_tasks` or `run_sql_query`) and check it matches what you meant.
- Nothing the tools do erases data, and a safety copy of the database is taken before the first change in any 30 minutes.
