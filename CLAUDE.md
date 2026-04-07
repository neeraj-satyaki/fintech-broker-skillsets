# Fintech Broker Skillsets

A Claude Code plugin system for tracking Indian stock broker API documentation changes, detecting deprecations, and auditing codebase coverage.

## Slash Commands

| Command | Purpose |
|---------|---------|
| `/broker-sync <broker\|all>` | Fetch latest docs and save snapshots |
| `/broker-diff <broker\|all>` | Compare codebase against latest docs, find deprecated code |
| `/broker-list <filter>` | Look up brokers by category, feature, or name |
| `/broker-update [brokers]` | Daily update cycle (defaults to upstox firstock zerodha) |

## Project Structure

```
broker-registry.json     — Master registry of 60+ brokers with URLs and metadata
snapshots/               — Point-in-time documentation snapshots per broker
reports/                 — Diff reports, audit reports, daily summaries
brokers/                 — Category folders for broker-specific configs
.claude/commands/        — Claude Code slash command definitions
install.sh               — Installer script for setting up in any project
```

## Broker Registry Keys

Use these keys when invoking commands:
- Discount: zerodha, upstox, angelone, dhan, fyers, 5paisa, groww, paytm_money, samco, mstock
- Full-service: kotak, icici_direct, hdfc_sec, motilal_oswal, iifl, sharekhan, nuvama, anand_rathi, religare, geojit
- Tech-forward: finvasia, flattrade, aliceblue, firstock, rupeezy, pocketful, and 15+ more
- Aggregator: openalgo, stocks_developer, algomojo, tradetron, quantiply
- Regulators: sebi, nse, bse, nsdl, cdsl

## Daily Agent

A remote agent runs daily at 8:00 AM IST to:
1. Fetch latest docs for Zerodha, Upstox, Firstock
2. Diff against previous snapshots
3. Audit codebase for deprecated/missing implementations
4. Generate summary reports in `reports/`

Manage at: https://claude.ai/code/scheduled

## SEBI Compliance Notes

- API-originated orders must be tagged per SEBI's algo trading framework
- Apps distributing algos need empanelment via SEBI-registered broker
- KYC (CVL/CKYC), risk disclosure, and SCORES integration are mandatory for user-facing products
