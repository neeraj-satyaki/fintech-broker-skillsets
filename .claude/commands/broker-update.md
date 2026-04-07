# Daily Broker Documentation Update

Automated daily update for priority brokers. Fetches latest docs, diffs against previous snapshots, and reports changes.

## Arguments
- `$ARGUMENTS` — optional override of broker list. Defaults to: `upstox firstock zerodha`

## Instructions

1. **Determine target brokers:**
   - If arguments provided, use those broker keys
   - If no arguments, default to: `upstox`, `firstock`, `zerodha`

2. **Read broker-registry.json** and get docs URLs for each target.

3. **For each broker, run the full sync cycle:**

   ### Step A: Fetch Latest Docs
   - Use WebFetch to pull the documentation page from the broker's `docs_url`
   - Extract: API version, endpoints, auth method, deprecations, changelog if available
   - Look specifically for:
     - Changelog / What's New / Release Notes sections
     - Deprecated endpoint notices
     - New endpoint announcements
     - SDK version updates

   ### Step B: Load Previous Snapshot
   - Find the most recent snapshot in `snapshots/{broker_key}_*.md`
   - If none exists, this is the first snapshot — save it and move on

   ### Step C: Diff Analysis
   Compare current fetch against previous snapshot and categorize changes:

   **Added:**
   - New endpoints
   - New parameters on existing endpoints
   - New order types or features
   - New SDK languages or versions

   **Removed / Deprecated:**
   - Endpoints no longer documented
   - Parameters removed
   - Deprecated authentication methods
   - Sunset notices

   **Modified:**
   - Changed parameter names or types
   - Changed response formats
   - Updated rate limits
   - Modified WebSocket protocols

   ### Step D: Save Results
   - Save new snapshot to `snapshots/{broker_key}_{YYYY-MM-DD}.md`
   - If changes found, save diff to `reports/{broker_key}_changes_{YYYY-MM-DD}.md`

4. **Scan codebase for impact:**
   - For each change found, grep the codebase for affected code
   - Flag any code using deprecated/removed features
   - Note files and line numbers

5. **Print daily summary:**

```
=== Daily Broker Update: {date} ===

ZERODHA (Kite Connect v3):
  Status: No changes detected / X changes found
  [list changes if any]
  Code impact: None / {files affected}

UPSTOX (Upstox API):
  Status: ...

FIRSTOCK (Firstock API):
  Status: ...

Action items:
  - [any required code changes]
  - [any deprecation deadlines approaching]
```

## Important
- If a fetch fails (timeout, auth wall, etc.), note it but continue with other brokers
- Keep snapshots clean and consistent for reliable diffing
- Flag any SEBI circular references found in broker docs
- For Zerodha specifically, also check https://kite.trade/docs/connect/v3/changes/ if available
