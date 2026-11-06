Split out of #4471 (support desk). One of three problems the desk merged into it. #4471's own table marks this cause "not this ticket — no ticket of its own".

## Problem
The booking-v3 form prints the hint `MM/DD/YYYY` under its date field. People type month first as told, then the form reads the value in the tenant's day-first order, so day and month swap. This is a different bug from the parser, and it stays after the parser fix ships.

Only reports sent through the form (`channel: form`) of the booking-v3 tenants: alder.physio (de-DE), copper.studio (es-ES), pale.harbour (pt-PT).

**Reports covered: 33** (unique report ids, all merged into #4471)

Tenants (3): alder.physio, copper.studio, pale.harbour
Seen: 2026-04-17 → 2026-09-22

<details><summary>All 33 report ids</summary>

R-41230, R-41241, R-41251, R-41259, R-41262, R-41275, R-41294, R-41305, R-41308, R-41366, R-41372, R-41384, R-41387, R-41396, R-41400, R-41406, R-41415, R-41416, R-41418, R-41428, R-41439, R-41441, R-41449, R-41453, R-41456, R-41460, R-41472, R-41485, R-41493, R-41539, R-41572, R-41582, R-41584

</details>

## Fix
Make booking-v3's hint match the order the form reads (the tenant's locale, e.g. `DD/MM/YYYY`), as booking-v2 does.

Note: intake's `hint` tag does not match this group. Of these 33, intake tagged 18 `hint` and 15 `parser`. Count by tenant form and channel, not by tag.

Page: [kb/incidents/4471/problems](https://github.com/MPRevell/support-kb-4471/blob/main/src/routes/kb/incidents/4471/problems/%2Bpage.svx) · rendered: [build/kb/incidents/4471/problems.html](https://github.com/MPRevell/support-kb-4471/blob/main/build/kb/incidents/4471/problems.html)
