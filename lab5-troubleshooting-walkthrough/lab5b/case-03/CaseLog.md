# Case 03 – Application Can’t Connect to Network (DNS / Proxy / TLS)

## 1) Environment
- **OS:** macOS (captured via `systeminfo.txt`)
- **Application:** ExampleApp (e.g., Slack, Zoom, or internal web client)
- **Version:** (if available)
- **Network Type:** Wi-Fi (home or corporate)
- **Recent Changes:** VPN installed, proxy change, or system update prior to failure.

## 2) Symptoms
- Application opens normally but displays an error such as:
  > "Unable to reach server" or "Check your internet connection."
- Other applications or browsers may work fine.
- Occurs only on Wi-Fi, or only when VPN is active.
- System network indicators show internet access.
- No firewall or antivirus alerts.

## 3) Evidence (Collected)
Evidence collected with `collect-evidence.sh` on **2025-10-27 14:00**  

Files generated:
- `systeminfo.txt` → confirms OS and hardware.  
- `dns.txt` → shows DNS servers and resolution results.  
- `proxy.txt` → lists system and environment proxy settings.  
- `routes.txt` → shows network routing and connectivity tests.  
- `curl-test.txt` → verifies app endpoint connectivity.  
- `tls.txt` → inspects TLS handshake and certificate chain.  

**Key Findings:**
- DNS resolution for target domain (`api.example.com`) failed intermittently.  
- `scutil --proxy` revealed outdated HTTP/HTTPS proxy still enabled.  
- `curl -v` output showed a `407 Proxy Authentication Required` error.  
- TLS certificate chain valid; no SSL issues detected.  

## 4) Analysis
**Likely Root Causes:**
1. Stale or incorrect system proxy configuration from prior VPN session.  
2. DNS cache returning outdated or local resolver entries.  
3. Environment variables (`HTTP_PROXY`, `HTTPS_PROXY`) overriding system settings.  
4. Split-tunnel VPN blocking the app’s specific domain.  

## 5) Remediation Steps
1. **Reset proxy settings**  
   ```bash
   scutil --proxy
   networksetup -setwebproxystate "Wi-Fi" off
   networksetup -setsecurewebproxystate "Wi-Fi" off
   unset http_proxy https_proxy HTTP_PROXY HTTPS_PROXY
   ```

2. Flush DNS cache

- sudo dscacheutil -flushcache
sudo killall -HUP mDNSResponder


3. Verify routing and DNS resolution

- nslookup api.example.com
traceroute api.example.com


4. Test HTTPS/TLS connectivity

- curl -v https://api.example.com
echo | openssl s_client -connect api.example.com:443 -servername api.example.com


5. Retry application connection — confirm success after proxy and DNS reset.

### Script Simulations (Fixes Folder)

These scripts automate each troubleshooting step for repeatability:

- [x] **reset-proxy.sh** — disables system/web proxies and clears environment proxy variables.
Expected Result: Proxy settings fully cleared; network traffic routed directly.

- [x] **flush-dns.sh** — flushes DNS cache and restarts resolver service.
Expected Result: Old resolver entries cleared; new DNS resolution succeeds.

- [x] **verify-connectivity.sh** — runs curl and openssl checks to confirm endpoint connectivity and TLS handshake.
Expected Result: HTTP 200/3xx success response; valid certificate chain.

- Verification Metric	Before Fix	After Fix	Notes
DNS Resolution	Fails	Successful	Domain resolves to valid IP
Proxy State	Enabled	Disabled	Cleared via script
curl Result	Timeout / 407	HTTP 200	Endpoint reachable
TLS Handshake	Incomplete	Verified	Cert chain valid
App Connectivity	Failed	Normal	App reconnects successfully

## 6) Verification
- After running reset-proxy.sh and flush-dns.sh, connectivity was restored.
verify-connectivity.sh https://api.example.com confirmed a 200 OK response and valid TLS handshake.
The affected app connected normally on next launch without VPN.

## 7) Root Cause

- An outdated proxy configuration from a previous VPN session continued intercepting HTTPS traffic, blocking the app’s outbound connection.

## 8) Preventive Measures

- Disable proxy settings automatically on VPN disconnect.

- Use network location profiles for “Home” vs. “Corporate” configurations.

- Regularly flush DNS after major network or VPN changes.

- ocument proxy and DNS settings for troubleshooting repeat cases.

- Monitor outbound connectivity with periodic curl and ping tests.

---