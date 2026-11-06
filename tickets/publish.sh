#!/bin/sh
# Creates the public repo, pushes, and files the three tickets (in this order: #1 parser, #2 hint, #3 shift).
set -e
cd "$(dirname "$0")/.."
gh repo create MPRevell/support-kb-4471 --public --description "Support desk kb: ticket #4471 split by cause (MEGA S01E03)" --source . --push
gh issue create -R MPRevell/support-kb-4471 -t "Parser reads day-first dates month first: 379 reports from #4471" -F tickets/1-parser.md
gh issue create -R MPRevell/support-kb-4471 -t "booking-v3 form hint says MM/DD/YYYY: 33 reports from #4471" -F tickets/2-hint.md
gh issue create -R MPRevell/support-kb-4471 -t "Booking dates move by one day (time zone): 5 reports from #4471" -F tickets/3-shift.md
