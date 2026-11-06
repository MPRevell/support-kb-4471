Split out of #4471 (support desk). One of three problems the desk merged into it. #4471 counts these reports under `parser`.

## Problem
The date moves by one day. It is not a day/month swap. Examples from the reports:
- "Invite says Tuesday 12 May. Calendar says Monday 11 May."
- "Client in Lisbon got Tuesday. Client in Toronto got Monday. Same meeting."
- "Every booking in June is one day off. Only June."
- "The invite arrived before I made the booking."

This points to a time zone or summer-time conversion (for example a date-only value sent as midnight UTC, then shown in a zone west of it). The parser fix does not touch it.

The desk's own notes (`desk-notes.json` → `oneDayMove`) list these reports.

**Reports covered: 5** (unique report ids, all merged into #4471)

Tenants (5): alder.physio, kettle.books, lantern.row, nine.lanterns, pale.harbour
Seen: 2026-04-02 → 2026-10-04

<details><summary>All 5 report ids</summary>

R-41202, R-41209, R-41236, R-41344, R-41620

</details>

## Fix
Store and send booking dates as date-only values, or with the tenant's time zone, and test across summer-time changes and zones west of UTC.

Page: [kb/incidents/4471/problems](https://github.com/MPRevell/support-kb-4471/blob/main/src/routes/kb/incidents/4471/problems/%2Bpage.svx) · rendered: [build/kb/incidents/4471/problems.html](https://github.com/MPRevell/support-kb-4471/blob/main/build/kb/incidents/4471/problems.html)
