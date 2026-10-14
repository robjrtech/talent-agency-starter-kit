# <Task name>

- **Department:** <Finance and Accounting | Information Technology | Operations | Research and Development>
- **Executed by:** <Finance | IT | Operations | Research> Automation Agent
- **Status:** Proposed
- **Approved:** <date, filled in only when the user approves in session>
- **Method:** <Cloud (scheduled cloud run) | Local (timer in an open session, or started by name)>
- **Schedule:** <e.g. weekdays 08:00 local; 1st of each month 09:00>
- **Cloud run / timer ID:** <filled in by the Scheduling Agent when armed>
- **Written by:** Process Agent · **Scheduled by:** Scheduling Agent

## Purpose
<One or two sentences: what this saves and who uses the result.>

## Inputs and access
- **Reads:** <files, folders, connectors, URLs>
- **Writes:** <exact output location(s)>
- **Untrusted external content?** <yes/no. If yes and Cloud: summarize and report only.>

## Steps
1. <Concrete, checkable step>
2. ...

## Verification
<How each run proves it worked, e.g. totals match the source export; scan
exits 0; every row has a category. A run that can't verify stops.>

## Needs approval every run
<Anything in this task that sends, pays, deploys, publishes or deletes. The
run prepares it and stops. Write "none" if there is nothing.>

## Stop conditions
<When the run must stop, log and Pause instead of continuing, e.g. an
uncategorizable transaction, a critical CVE, a missing input file.>

## Output and reporting
<Where the result goes and who is told: the run log, a workspace entry through
the publishing gate, a draft email for the user, etc.>

## Change history
| Date | Change | Back to Proposed? |
|---|---|---|
