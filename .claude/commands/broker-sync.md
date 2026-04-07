# Broker Documentation Sync

You are a fintech broker API documentation analyst. Your job is to fetch the latest documentation from Indian stock broker APIs and create a comprehensive snapshot of the current state.

## Arguments
- `$ARGUMENTS` — broker key(s) from broker-registry.json (e.g., "zerodha", "upstox firstock", or "all" for everything)

## Instructions

1. **Read the broker registry** at `broker-registry.json` in the project root. Find the broker(s) matching the argument(s). If "all" is specified, process all brokers with public docs URLs.

2. **For each broker**, use WebFetch to pull the latest documentation from the `docs_url` in the registry. If the broker has `extra_urls`, fetch those too.

3. **Extract and organize** the following from each broker's docs:
   - API version (v1, v2, v3, etc.)
   - Authentication method (OAuth2, API key, session token, TOTP, etc.)
   - Available endpoints grouped by category:
     - Auth / Session management
     - Orders (place, modify, cancel)
     - Portfolio (holdings, positions)
     - Market Data (quotes, OHLC, historical)
     - WebSocket / Streaming
     - Instruments / Master data
     - Margins / Funds
     - GTT / Bracket / Cover orders
   - Rate limits
   - WebSocket protocol details
   - Any noted deprecations or upcoming changes
   - SDK availability and languages

4. **Save the snapshot** to `snapshots/{broker_key}_{YYYY-MM-DD}.md` with this format:

```markdown
# {Broker Name} ({API Name}) — Documentation Snapshot
**Date:** {today}
**Source:** {docs_url}
**API Version:** {version}

## Authentication
{details}

## Endpoints
### Orders
{endpoints with methods, paths, parameters}

### Portfolio
{endpoints}

... (all categories)

## Rate Limits
{details}

## WebSocket
{details}

## Deprecations & Upcoming Changes
{any noted deprecations, sunset dates, migration guides}

## SDK Support
{languages and package names}
```

5. **Check for previous snapshots** in the `snapshots/` directory for the same broker. If a previous snapshot exists:
   - Compare the two and note any differences
   - Save a diff report to `reports/{broker_key}_changes_{YYYY-MM-DD}.md`
   - Highlight: new endpoints, removed endpoints, changed parameters, new deprecation notices, version bumps

6. **Print a summary** to the user:
   - Which brokers were synced
   - Any breaking changes or deprecations found
   - Any URLs that failed to fetch (and why)

## Important
- If a URL returns a login page or blocks scraping, note it in the snapshot and suggest the user check manually.
- For XTS-based brokers, note that they share a common API surface — changes to one likely affect others.
- Always check SEBI compliance notes if the broker docs mention algo trading requirements.
- Keep snapshots factual — extract what the docs say, don't infer.
