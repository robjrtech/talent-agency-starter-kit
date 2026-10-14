# Routing: Model & Effort per Agent

How the agency picks which model and effort level each agent runs at, and why.
The **Model & effort routing** standing policy in [Overview.md](Overview.md)
points here.

## The goal

Use as little usage as possible **without lowering quality**. Redoing work is
the most expensive outcome: the usage spent on a failed attempt is lost, and
the retry costs it again. A routing choice that saves usage on the first
attempt but causes a redo has cost more, not less.

## Core principle

> **Route by the cost of a mistake, not by the size of the task.**

A large but mechanical task (reformatting 40 files) can run on a cheap model,
because errors show up immediately and are easy to fix. A small but high-stakes
judgment (one line of auth logic, an architecture choice) needs the strongest
model, because a missed error spreads into everything built on it and is found
late, when it costs the most to fix.

Two questions decide the tier:
1. **Can the output be checked cheaply?** Can tests, a diff, a schema, or a
   quick look tell you whether it's right? If yes, a cheaper tier is safe. If
   checking it requires the same judgment that produced it, it isn't.
2. **How far does a mistake spread?** If other agents build on this output, or
   it is a gate that other work trusts, use the strong tier.

## The tiers

Tiers are tool-neutral. Which model each tier uses in each tool is set in
[Agent Definitions/models.json](Agent%20Definitions/models.json). The
quarterly currency audit re-checks it.

| Tier | Strengths | Use for | Example (Claude / OpenAI / Gemini) |
|------|-----------|---------|------------------------------------|
| **Fast** | Fast and cheap; reliable on clear rules | Mechanical, rule-based work that's easy to check | Haiku / GPT-6 Luna / Flash-Lite |
| **Standard** (default) | Strong builder; follows a clear spec well | Building and writing from an approved spec or plan | Sonnet / GPT-6.1 Sol / Flash |
| **Deep** | Best at ambiguity, trade-offs and catching subtle errors | Judgment, ambiguity, gates, and anything others build on | Opus / GPT-6.1 Sol (high effort) / Pro |

Only these three tiers are used. If a tool can't pin a model per agent, the
tier still tells the agent how carefully to work and when to escalate.

## Effort levels

Effort is how much reasoning the model does before answering. It's a separate
setting from the tier.

| Effort | Use for |
|--------|---------|
| **Low** | Lookups, formatting, applying a change that's already decided |
| **Medium** (default) | Normal build and writing work from a spec |
| **High** | Gate reviews, debugging an unknown cause, plans and specs others will build from |
| **Max** | Only after High has already failed on a hard problem. Never a default. |

## Routing table

Each agent's **default** tier and effort. A specific task can move an agent
up or down (see "Overrides" below).

### Information Technology

| Agent | Tier | Effort | Why |
|-------|------|--------|-----|
| System Design Engineer | Deep | High | Architecture gate. Every other agent builds on its call, so a bad call spreads the furthest. |
| Security Engineer | Deep | High | Security gate and OWASP Top 10 review. A missed vulnerability isn't visible until it's exploited. |
| UI Lead | Deep | High | Design gate. Must tell your preferences apart from biases and argue with evidence, which is pure judgment. |
| QA Engineer | Standard | Medium; High for test plans | Running tests is checkable work. Designing the test plan decides what gets caught, so it's raised. |
| Python / C++ / iOS / Web / React Native Engineer | Standard | Medium | Builds from an approved plan. Tests and code review catch errors. Moves up after a failed fix (see Escalation). |
| UI Designer | Standard | Medium | Produces variations from an approved storyboard, and the UI Lead and you review every one. |
| UX Agent | Standard | Medium; High for storyboards | Research gathering is checkable. The storyboard defines the problem everything else solves, so it's raised. |
| Deployment Agent | Standard | Medium | Follows a defined release process. Build/CI output shows whether it worked. |
| Sysadmin Agent | Standard | Medium | Setup and configuration are verifiable by running them. |
| Support/Triage Agent | Fast for first pass | Low | Classifying and routing a report is rule-based. Root-causing an unknown bug moves to Standard/High under the Scientific Method policy. |
| Content Integrity Agent | Fast | (set by the installed gate) | Runs on every external read, so it must be cheap. Where an enforced gate is installed, its rule-based first layer backs it up; a reject halts work for your review. |
| IT Automation Agent | Fast | Low | Runs approved, step-by-step tasks that each carry their own check (scan exit codes, expected output). Never deploys or changes anything, and stops on any finding it can't classify. |

### Finance and Accounting

| Agent | Tier | Effort | Why |
|-------|------|--------|-----|
| Financial Risk Manager | Deep | High | Risk judgment on real money. A missed risk is costly and shows up late. |
| Financial Analyst | Deep | High | Its models and forecasts drive decisions, so a wrong assumption carries into every decision built on them. |
| Reporting Agent | Standard | Medium | Builds standard reports from data. The totals can be checked against the source. |
| Bookkeeping Agent | Fast | Low | Categorizing and reconciling against rules. Mismatches are visible. Unclear transactions go to you, not a guess. |
| Invoicing Agent | Fast | Low | Template-driven drafts. You review before anything is sent. |
| Finance Automation Agent | Standard | Low | Approved steps with built-in checks, but it runs unattended on real figures, so a quiet mistake may not surface until month end. One tier above Bookkeeping for that reason. Never sends or pays. |

### Operations

| Agent | Tier | Effort | Why |
|-------|------|--------|-----|
| Publishing Agent | Standard | Medium | Approval gate, but it checks completeness and filing, not technical correctness. Security and QA have already signed off. |
| Process Agent | Standard | Medium | Writes SOPs from decisions already made. Compliance SOPs move to High. |
| Vendor/Ops Agent | Standard | Medium | Coordination and vetting against a checklist (including OWASP evidence). Anything missing is flagged to you. |
| Scheduling Agent | Fast | Low | Calendar coordination is rule-based and easy to check. Nothing is sent without confirmation. |
| Operations Automation Agent | Fast | Low | Status checks and digests from approved steps, easy to verify. Never sends or files. |

### Research and Development

| Agent | Tier | Effort | Why |
|-------|------|--------|-----|
| Quantitative Researcher | Deep | High | Statistical design errors (overfitting, leakage) look like success until real money is at stake. |
| Product Agent | Standard | Medium; High for specs | The spec is what engineers build from, so a weak spec causes rework downstream. |
| Research Agent | Standard | Medium | Gathers and summarizes sources. Claims a decision depends on go through the Scientific Method policy and your review. |
| Research Automation Agent | Fast | Low | Sourced digests from approved steps. Every claim carries a link you can check, and conclusions go to the Research Agent, not the digest. |
| Prototyping Agent | Standard | Medium | Proofs of concept are meant to be thrown away. Speed matters more than polish. |

### Tasks that aren't tied to one agent

| Task | Tier | Effort | Why |
|------|------|--------|-----|
| Pre-build plan / report | Deep | High | The single biggest lever against rework (see Rule 1). |
| File and code searches, read-only sweeps | Fast | Low | Results are checked by opening the files. |
| Debugging after a fix failed | Deep | High | The obvious answer has already been tried. |

## The process

For every task:

0. **Evaluate the task** against four questions:
   - **Cost of a mistake:** does it touch security, money, auth, or user
     data, or will other work build on it?
   - **Checkability:** can tests, a diff, a schema, or a review cheaply show
     whether the result is right?
   - **Ambiguity:** is the spec clear, or are there decisions only the user
     can make? Those go to the user as questions, not assumptions.
   - **History:** has this already failed once?

   Both sides do this. The **orchestrating session** evaluates before
   launching an agent, and can pass a different `model` when the task calls
   for it. The **agent** evaluates again when it starts. If the task is above
   its level, it stops and returns an escalation request (recommended tier
   and effort, the reason, and evidence so far) instead of weak work that
   would have to be redone.
1. **Start from the agent's default** in the routing table.
2. **Check for overrides.** Is this task riskier or more mechanical than the
   agent's usual work? Adjust (see below).
3. **Plan before building.** For any build, the pre-build plan is written at
   Deep/High and approved by you. Execution then runs at the agent's own tier.
4. **Run.** If the result passes its checks, you're done.
5. **If it fails, escalate. Don't retry at the same level** (see Escalation).
6. **Log any redo** in the agent's Self-Improvement log with its cause.

## The rules

### Rule 1: Spend on the plan, save on the execution
Most rework comes from a vague spec, not a weak model. One Deep/High plan,
approved by you, lets the build run at Standard/Medium with little risk of a
redo. This works together with the **Ask, don't assume** habit: an open
question answered up front costs far less than a rebuild.

### Rule 2: Use a cheaper tier only when something can check the result
Tests, a diff, a schema, a total, or your review before anything is sent.
If nothing checks the output, use the stronger tier.

### Rule 3: Escalate after one failure. Never repeat the same attempt.
Retrying at the same tier and effort usually gives the same wrong answer
and doubles the cost. The ladder:

```
Fast/Low → Standard/Medium → Standard/High → Deep/High → Deep/Max → stop and ask the user
```

Each step up takes the **evidence from the failed attempt** (error text, what
was tried, what was disproven) under the Scientific Method policy. Moving up
without that evidence just repeats the same guess with a stronger model.

### Rule 4: Gates never get downgraded
System Design, Security, UI Lead, and the Financial Risk Manager stay at
Deep/High even for small reviews. A problem caught at a gate costs the least
to fix. A missed one costs the most.

### Rule 5: Use as few subagents as possible
Each subagent starts with no context and re-reads everything, which costs
usage before it does any work. This applies to **any agent** — the
top-level session or a Talent Agency agent already running as a
subagent — deciding whether to delegate part of its own task. On any
plan with usage limits:
- Spawn subagents only for **independent, parallel** work or large read-only
  sweeps. Otherwise do the work yourself.
- **Check usage first.** Run at most **3–4 at a time, across the whole
  operation** — not per agent. If other subagents are already running
  (yours or another agent's), that shared ceiling applies to you too.
- Give each one an exact brief: file paths, the approved plan, and what
  "done" means. Then it doesn't re-derive what's already known.
- **One level of delegation by default.** A subagent you spawn does its
  task directly rather than spawning sub-agents of its own — ask the user
  before going deeper, so the delegation tree stays shallow and auditable.
- Agents **save progress to disk as they go**. Resume an interrupted agent
  instead of restarting it, if your tool can (see `Adapters/`); otherwise
  start a new one and point it at the progress it saved.

Why: several Deep-tier subagents running in parallel can use up a whole
usage window in minutes, and if they all run out partway through, all of
that work is lost.

#### Checking usage across sessions and devices

"Check usage first" above assumed one session tracking its own count. That
breaks when the user runs multiple agent sessions at once, in one tool or several — different
project builds, possibly on different devices — because separate sessions
have no visibility into each other's active subagent count. The 3–4 cap is
still global across all of them; the only thing that changes is how a
session finds out what everyone else is doing.

**`Session Heartbeats/`** holds this, one JSON file per session (never
shared, never appended to by more than one session — see
[`Session Heartbeats/README.md`](Session%20Heartbeats/README.md) for the
exact format). Before spawning a subagent:

1. Write/update **your own** heartbeat file with your current active count
   and a fresh timestamp. Never touch another session's file.
2. Read every heartbeat file in the folder. Ignore any whose timestamp is
   more than 10 minutes old — treat it as 0 (that session is gone or stuck).
3. Sum the remaining `active_subagents` values, including your own.
4. If that sum plus the subagents you're about to add would exceed 4, hold
   back — queue, reduce the number you launch, or ask the user. Don't spawn.
5. Update your own file as subagents finish. Delete it when you have none
   active or your session is ending.

This is **advisory, not a hard lock** — two sessions checking at nearly the
same instant can still both proceed and briefly overshoot the cap, because
nothing here is atomic across cloud sync. That's an accepted tradeoff: the
goal is to catch the common case cheaply, not to build real distributed
mutual exclusion for a personal tool. It degrades safely (a brief overshoot,
not corrupted state), which is the same bar the rest of this policy already
applies ("guidance agents apply with judgment, not a hard lock").

## Overrides

A task can move an agent off its default. Record the reason in the
pre-build report.

- **Move up** when the task touches security, money, auth, or user data, or
  when it's an architecture decision, an unknown-cause bug, or something other
  agents will build on. Example: a Web Engineer writing session handling runs at
  Deep/High.
- **Move down** when the task is mechanical and checkable, even for a gate
  agent. Example: the Security Engineer listing dependency versions runs at
  Fast/Low. The review of that list stays at Deep/High.

## Tracking and tuning

Every redo is logged as a new entry file in the agent's
`Self-Improvement/<Agent Name>/` directory with a **Rework** field: the tier
and effort used, and one cause:
- **Vague spec:** the plan or request was unclear. Fix with Rule 1.
- **Wrong tier:** the model wasn't strong enough for the task.
- **Effort too low:** right model, not enough reasoning.
- **Missing context:** the agent didn't have files, decisions, or history it needed.

At the **quarterly rollup** (same cadence as the currency audit), the
**Process Agent** reviews Rework entries across agents and proposes changes to
this table. For example: an agent that keeps hitting "wrong tier" moves up,
and a Deep agent with no rework in a quarter is tested at Standard. Changes go
through the normal publishing gate.

## How it's applied

Routing is **guidance the agents apply with judgment**, not a hard lock
(user decision, 2026-10-04). Each role becomes a native agent in every
supported tool (Claude Code, Codex, Cursor, Gemini CLI, Copilot), generated
from its role file by
[Agent Definitions/generate.py](Agent%20Definitions/README.md):

- The definition sets the **default** model and effort from the role's
  Default Routing section.
- The orchestrating session can **override the model** for a single launch
  when its evaluation calls for it.
- **Effort can't be overridden per launch.** It's fixed by the definition.
  When a task needs more effort than the agent's default, the agent returns
  an escalation request, and the work either moves to a Deep agent (a
  `model` override) or is done in the main session at the needed effort.
- Every definition starts with the Step 0 task evaluation above.

After changing a role's routing or Routing.md, rerun the generator.
