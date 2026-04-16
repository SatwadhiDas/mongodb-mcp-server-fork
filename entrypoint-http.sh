#!/bin/sh
# Starts the MongoDB MCP server in HTTP mode with bearer token auth.
#
# Required env vars:
#   MDB_MCP_CONNECTION_STRING  — MongoDB Atlas connection string
#   MCP_BEARER_TOKEN           — Bearer token for auth (validated via httpHeaders)
#
# Optional env vars:
#   MCP_PORT       — HTTP port (default: 8080)
#   MCP_MAX_TIME_MS — Query timeout in ms (default: 60000)

set -e

PORT="${MCP_PORT:-8080}"
MAX_TIME="${MCP_MAX_TIME_MS:-60000}"

exec node dist/esm/index.js \
  --transport http \
  --httpHost 0.0.0.0 \
  --httpPort "$PORT" \
  --connectionString "$MDB_MCP_CONNECTION_STRING" \
  --maxTimeMs "$MAX_TIME" \
  --healthCheckHost 0.0.0.0 \
  --healthCheckPort 8081 \
  --monitoringServerFeatures health-check \
  --httpHeaders.Authorization "Bearer $MCP_BEARER_TOKEN" \
  --loggers stderr,mcp
