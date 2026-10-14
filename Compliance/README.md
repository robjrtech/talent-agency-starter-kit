# Compliance

Write-ups from the **Compliance review** standing policy (see [Overview.md](../Overview.md)).
Not a fixed checklist — which frameworks apply depends on the data and jurisdiction
actually involved in a given project or vendor relationship.

## When a report gets filed

- **Before a project ships** — Security Engineer identifies which frameworks apply
  (GDPR, SOC 2, CCPA, HIPAA, etc.) and confirms the relevant controls are met.
- **Before onboarding a vendor or third party** that will touch the agency's or a
  client's data — Vendor/Ops Agent vets the vendor (data-sharing/processing agreement,
  the vendor's own SOC 2 report or equivalent attestation, exactly what data they'll
  touch).
- **Every project report** includes the OWASP Top 10 (2025) table, with all 10
  categories marked pass / gap / N/A with a reason. Vendor reports record the
  vendor's OWASP Top 10 evidence. The list lives in
  [`OWASP Top 10.md`](OWASP%20Top%2010.md).
- **If you've turned on the optional SOX-style module**
  ([`Optional/SOX/`](Optional/SOX/README.md)), projects with financial data also fill
  in its [report table](Optional/SOX/Report%20table.md).
- Either review may surface a gap that needs a new or updated SOP — that's the
  **Process Agent**'s job to document, not this folder's.

## Filing a report

One file per project ship or vendor onboarding:
`YYYY-MM-DD-<project-or-vendor-name>.md`. Copy [`_template.md`](_template.md) as the
starting point.

Like other project deliverables, a filed report goes through the publishing gate
(reviewed by the Publishing Agent) before it's treated as official.

## Index

| Date | Scope | Frameworks | Report |
|------|-------|-----------|--------|
