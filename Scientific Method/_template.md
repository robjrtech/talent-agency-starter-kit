# Experiment Record — <YYYY-MM-DD> — <project / issue>

Copy one block per experiment into the post-build report (or the pre-build
report, for a planned test). Fill in **Prediction** before running anything.
See Overview.md → Standing Policies → Scientific method.

**Agent:** <who ran it>
**Type:** <troubleshooting / testing / research>
**Peer reviewer:** <QA Engineer / System Design Engineer / user>

## Experiment <n>

1. **Observation:** <evidence: exact error text, log lines, repro steps, data, source links>
2. **Question:** <one specific question this experiment answers>
3. **Hypothesis:** <testable, falsifiable explanation>
4. **Prediction (written before testing):**
   - If true, we'll see: <expected result>
   - It's false if we see: <result that disproves it>
5. **Experiment:** <exact steps to rerun it; the one variable changed; the control used>
6. **Result & analysis:** <what actually happened, with data> → **Supported / Disproven / Inconclusive**
7. **Next:** <new hypothesis (loop to Experiment n+1), fix applied, or conclusion>

---

## Conclusion

- **Answer / root cause:** <what the evidence shows, and how confident>
- **Disproven hypotheses:** <list, so no one re-tests them>
- **Self-Improvement entry?** <yes: link / no>
- **Peer review:** <reviewer, date, verdict>
