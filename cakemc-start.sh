#!/bin/bash
set -euo pipefail

SERVER_JAR_URL="https://raw.githubusercontent.com/badcakee/cakemc/refs/heads/main/server.jar"

if command -v curl >/dev/null 2>&1; then
  curl -fsSL "$SERVER_JAR_URL" -o server.jar
elif command -v wget >/dev/null 2>&1; then
  wget --no-hsts -qO server.jar "$SERVER_JAR_URL"
else
  echo "curl or wget is required to download CakeMC." >&2
  exit 1
fi

test -s server.jar
exec java -Xms64M -Xmx${CAKEMC_HEAP:-128M} -jar server.jar
