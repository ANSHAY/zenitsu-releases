---
description: Run the weekly Sunday review in Zenitsu - read the week, ask the review questions in one go, write the review note, and tidy repeats and the coming week.
argument-hint: "[answers, if already written]"
disable-model-invocation: true
---

Run the Sunday review in Zenitsu. Answers the user has already written: $ARGUMENTS

1. **Get the frame.** Call `get_overview` (today's date) and read the note **Claude › House rules**. If the house rules describe the review (which tasks hold the questions, where the note goes, what else is recorded), follow them exactly; they win over every default below.
2. **Find the review tasks.** `list_tasks` with `search: "review"` and `snoozed: "all"`, plus any check-in or mood-score tasks the house rules name. Read each one with `get_task`: their details hold the questions.
3. **Read the week** (Monday to today): `get_timeline` with `from`/`to` and `include_status_moves: true`; the daily notes of those days (`run_sql_query` on `notes` by `date(note_date/1000, 'unixepoch', 'localtime')`, or `read_note` with each `date`); open tasks that are overdue (`list_tasks` with `due_before: "today"`); tasks in progress or blocked.
4. **Ask once.** Unless the answers were given above, ask every question from the review tasks in **one** message, with a short summary of the week first (what was finished, what slipped, what is overdue). Never ask them one by one.
5. **Write the review note** with `create_note`. Default place and title, unless the house rules say otherwise: folder `Reviews/<year>/<NN Mon>` (for example `Reviews/2026/10 Oct`, the month of this Sunday), title `wNN_review` where NN is the ISO week number. Content: the week's summary, the questions with the user's answers, and the decisions for next week.
6. **Tidy repeats.** For repeating tasks whose last date has passed, the repeat should already have stopped (`until`); for any that name a last date in their details but have no `until`, set it with `set_task_repeat`.
7. **Plan the coming week** with the user's decisions: move due dates, priorities and snoozes as agreed (say what will change before changing many tasks).
8. **Close the review tasks**: mark the ones done that were done; skip (`skip_occurrences`) any that were not.
9. Reply with the review note's title and folder and a short list of what changed.
