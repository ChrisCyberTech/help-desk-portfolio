# Case 02 – Application Won’t Launch (Instant Crash)

## 1) Environment
- OS: macOS (paste version from `systeminfo.txt`)
- Application: (Example: Visual Studio Code, Google Chrome, etc.)
- Version: (get from About info or package manager)
- User Type: Standard User / Admin
- Recent changes: App update, OS patch, or permission change.

## 2) Symptoms
- User double-clicks the app icon — it flashes briefly, then closes.
- No visible error message.
- App process appears briefly in Activity Monitor or `ps`, then disappears.
- Reinstalling didn’t help.

## 3) Evidence (Collected)
Evidence collected with `collect-evidence.sh` on **(date/time)**

- `systeminfo.txt` → confirms OS and hardware.
- `processes.txt` → shows process starts then dies.
- `logs.txt` → includes crash traces or permission errors.
- `disk.txt` → verifies disk space and I/O normal.
- `network.txt` → baseline (not relevant, but confirms system health).

Evidence collected with collect-evidence.sh on (timestamp)
Files generated:
- systeminfo.txt
- logs.txt
- processes.txt
- permissions.txt

**Key Findings:**
- Crash logs under `~/Library/Logs/DiagnosticReports/`
- `log show` reveals `Segmentation Fault` or `Code Signature Invalid`
- Permissions on app bundle show `root:wheel` but user needs access.

## 4) Analysis
Possible causes:
1. **Corrupted preferences/config files** – bad plist or JSON in user Library.
2. **Missing dependencies** – app updated but old frameworks remain.
3. **Code signature or quarantine flag** – macOS Gatekeeper blocked execution.
4. **Insufficient permissions** – user can’t read/execute binary.

## 5) Remediation Steps
1. **Check system logs**
   ```bash
   log show --predicate 'eventMessage CONTAINS[c] "AppName"' --last 2h
