---
description: Add one line to today's Zenitsu daily note for a piece of finished work, under the right bucket and project.
argument-hint: "[what was done]"
disable-model-invocation: true
---

Add one line to today's Zenitsu daily note for this finished work: $ARGUMENTS

If nothing was given, use the piece of work we just finished in this conversation.

1. Call `get_overview` for today's date and the exact bucket and project names, and read the note **Claude › House rules** if it exists (its rules win).
2. If the work is recorded by a task that is (or is about to be) marked done, do not add a line: done tasks are already on the timeline. Mark the task done instead if it is not, and say so.
3. Write one short, plain line in the past tense that says what was done, with no detail.
4. Pick the bucket and project the work belongs to. Call `append_to_note` with `date: "today"`, `heading: "<Bucket> > <Project>"` (or just `"<Bucket>"` when there is no real project) and `text: "- <line>"`. Never rewrite the note.
5. Reply with the line and the heading it went under.
