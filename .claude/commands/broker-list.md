# Broker Registry Lookup

Quick lookup tool for the Indian stock broker API registry.

## Arguments
- `$ARGUMENTS` — search query or filter. Examples:
  - `all` — list all brokers
  - `free` — brokers with free API access
  - `paid` — brokers with paid API access
  - `xts` — XTS-based brokers (similar API surface)
  - `websocket` — brokers with WebSocket support
  - `python` — brokers with Python SDK
  - `discount` / `full-service` / `tech-forward` / `aggregator` / `regulators` — by category
  - Any broker name — show full details for that broker
  - `compare zerodha upstox dhan` — side-by-side comparison

## Instructions

1. Read `broker-registry.json` from the project root.

2. Based on the argument:

   **If listing/filtering:** Display a table with columns:
   | Broker | API Name | Access | WebSocket | SDKs | Category |

   **If showing details:** Display full broker info including all URLs, notes, and latest snapshot date (check `snapshots/` directory).

   **If comparing:** Create a side-by-side comparison table highlighting differences in:
   - Access model (free/paid)
   - WebSocket support
   - SDK languages
   - XTS-based or not
   - Latest snapshot date

3. Also show:
   - Total count matching the filter
   - Any brokers with stale snapshots (>7 days old)
   - Suggestion to run `/broker-sync` for brokers without snapshots
