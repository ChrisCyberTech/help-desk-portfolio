#!/usr/bin/env bash
# Case 03 evidence: DNS/proxy/routes/TLS
set -euo pipefail
OUTDIR="$(cd "$(dirname "$0")" && pwd)"
TS=$(date +"%Y-%m-%d_%H-%M-%S"); echo "Collecting @ $TS"

# System
{ uname -a; sw_vers || true; } > "$OUTDIR/systeminfo.txt" 2>&1

# DNS
{
  scutil --dns | sed -n '1,120p' || true
  echo; echo "nslookup example.com:"; nslookup example.com 2>&1 || true
} > "$OUTDIR/dns.txt" 2>&1

# Proxy (system + common env)
{
  echo "scutil --proxy"; scutil --proxy
  echo; echo "Env proxies:"; env | grep -iE '^(http|https|all)_proxy' || true
  echo; echo "Network services:"; networksetup -listallnetworkservices 2>/dev/null || true
  echo; echo "Wi-Fi web/secure proxy:"; networksetup -getwebproxy "Wi-Fi" 2>/dev/null; networksetup -getsecurewebproxy "Wi-Fi" 2>/dev/null
} > "$OUTDIR/proxy.txt" 2>&1

# Routes / connectivity
{
  echo "Default route:"; route -n get default 2>/dev/null || netstat -rn | head -n 10
  echo; echo "Ping google.com:"; ping -c 4 google.com || true
  echo; echo "Traceroute to 8.8.8.8:"; traceroute -m 8 8.8.8.8 2>/dev/null || true
} > "$OUTDIR/routes.txt" 2>&1

# App endpoint test (edit TARGET as needed)
TARGET="${1:-https://example.com}"
{
  echo "curl -v $TARGET"; curl -v --max-time 10 "$TARGET"
} > "$OUTDIR/curl-test.txt" 2>&1

# TLS handshake (host:port inferred from TARGET)
HOST="$(echo "$TARGET" | sed -E 's#https?://([^/:]+).*#\1#')"
{
  echo "openssl s_client to $HOST:443 (SNI=$HOST)"
  echo | openssl s_client -connect "${HOST}:443" -servername "$HOST" -brief -showcerts 2>&1 | sed -n '1,120p'
} > "$OUTDIR/tls.txt" 2>&1

echo "Done."
